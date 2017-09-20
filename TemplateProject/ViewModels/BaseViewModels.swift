//
//  BaseViewModels.swift
//  TemplateProject
//
//  Created by Vishal Lohia on 6/3/17.
//  Copyright © 2017 Mobileprogramming. All rights reserved.
//

import Foundation

protocol BaseModelDelegate:class {
    func refreshController(model:BaseViewModels?,info:Any?,error:Error?)
}

class BaseViewModels:WebApiWrapperDelegate {
    var delegate:BaseModelDelegate? = nil
    
    //MARK: Delegate Method Of Webservice Wrapper. It will work if not overridden
    func didReceiveResponse(request:Requestable, data:Any?,error:Error?) {
        self.delegate?.refreshController(model: self, info: data, error: error)
    }
}
