//
//  LoginViewModel.swift
//  TemplateProject
//
//  Created by Vishal Lohia on 4/28/17.
//  Copyright © 2017 Mobileprogramming. All rights reserved.
//

import Foundation

protocol ViewModelParams {
    func apiCallWithType(type:ServicePath)
}

class LoginViewModel:BaseViewModels, ViewModelParams  {
    
    var userInfo:UserInfo?
    let webAPIWrapper:WebAPIWrapper = WebAPIWrapper()
    
    func apiCallForLogin(username:String, password:String) {
        let dict = ["username":username,"pwd":password]
        //....
    }
    
    func apiCallWithType(type:ServicePath) {
        let envelop = LoginEnvelop(pathType: type)
        webAPIWrapper.delegate = self
        webAPIWrapper.callServiceWithRequest(requestEnvelop: envelop)
    }
    
    //MARK:Overridden Delegate Method Of Webservice Wrapper.
    override func didReceiveResponse(request:Requestable, data:Any?,error:Error?) {
        
        guard let d = data else {
            self.delegate?.refreshController(model: self, info: data, error: error)
            return
        }
        
        let info = UserInfo.parseJSON(data: "")
        
        
        
        if let result = d as? ResponseResult<Any>,
            let resultValue = result.error   {
            self.userInfo = nil
            self.delegate?.refreshController(model: self, info: nil, error: resultValue)
        }
        
        if let result = d as? ResponseResult<Any>,
            let resultValue = result.value as? UserInfo {
            self.userInfo = resultValue
            self.delegate?.refreshController(model: self, info: nil, error: error)
        }
    }
}

