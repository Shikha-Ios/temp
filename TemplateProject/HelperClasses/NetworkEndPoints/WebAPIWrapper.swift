//
//  WebAPIWrapper.swift
//  TemplateProject
//
//  Created by Vishal Lohia on 6/2/17.
//  Copyright © 2017 Mobileprogramming. All rights reserved.
//

import Foundation
import Alamofire

protocol WebApiWrapperDelegate:class {
    func didReceiveResponse(request:Requestable, data:Any?,error:Error?)
}

class WebAPIWrapper {
    var delegate:WebApiWrapperDelegate?
    
    /* Developers can add NSURLSession Code Respectively */
    func callServiceWithRequest(requestEnvelop:Requestable) {
        let method = requestEnvelop.httpType.rawValue
        let type = HTTPMethod(rawValue: method)
        
        Alamofire.request(
            requestEnvelop.requestURL()!,
            method: type!,
            parameters: requestEnvelop.pathType.httpBodyEnvelop(),
            encoding:URLEncoding.queryString,
            headers: requestEnvelop.httpHeaders()).validate()
            .responseJSON { (response) -> Void in
                
                
                if let cls = requestEnvelop.modelType  {
                   let results = cls.parseJSON(data: response.value)
                    self.delegate?.didReceiveResponse(request:requestEnvelop , data: results, error: response.result.error)
                    return
                }
                
                
                self.delegate?.didReceiveResponse(request:requestEnvelop , data: response.data, error: response.result.error)
                }
        }
}

