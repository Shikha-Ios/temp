//
//  UserInfo.swift
//  TemplateProject
//
//  Created by Vishal Lohia on 6/3/17.
//  Copyright © 2017 Mobileprogramming. All rights reserved.
//

import Foundation

protocol Identifiable {
    static func parseJSON(data:Any?)->ResponseResult<Any>?
}

class UserInfo:Identifiable {

    var PatientId:String?
    var FirstName:String?
    var EmailId:String?
    var LastName:String?
    
    static func parseJSON(data:Any?)->ResponseResult<Any>? {
        
        if let d = data as? [String:String] {

                if let status = d["status"], status != "200" {
                    let desc = d["msg"]
                    let err = APIResponseError.generalError(domain: "Parsing Error", description: desc, errorCode:111)
                    return .failure(err)
                }
           
            let user = UserInfo()
            user.FirstName = d["FirstName"]
            user.LastName = d["LastName"]
            user.EmailId = d["EmailId"]
            user.PatientId = d["PatientId"]


            return .success(user)
        }
       
        let err = APIResponseError.generalError(domain: "Parsing Error", description: "Wrong Data Format", errorCode:111)
        return .failure(err)
   }

}
