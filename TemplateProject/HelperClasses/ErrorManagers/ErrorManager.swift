//
//  ErrorManager.swift
//  TemplateProject
//
//  Created by Vishal Lohia on 6/3/17.
//  Copyright © 2017 Mobileprogramming. All rights reserved.
//

import Foundation

enum APIResponseError:Error {
    case generalError(domain:String?,description:String?,errorCode:Int?)
}

extension APIResponseError : LocalizedError {
    var errorDescription: String? {
        switch self {
        case .generalError(domain: _, description:let desc, errorCode: _):
            return desc!
        }
    }
}

extension APIResponseError:CustomStringConvertible {

    var description: String {
        
        let arr = [Int]()
        
        switch self {
        case .generalError(domain: _, description:let desc, errorCode: _):
            return desc!
        }
    }
}
