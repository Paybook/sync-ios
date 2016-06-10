//
//  Requests.swift
//  Pods
//
//  Created by Gabriel Villarreal on 06/06/16.
//
//

import Foundation
import Alamofire



// MARK: - API requests

/**
 Sign up request.
 
 parameters = [
    "user" : String,
    "password" : String
 ]
 
 - parameter user:        The user.
 - parameter password:    The password.
 
 */

public func signupRequest(parameters: [String: AnyObject],completionHandler: ((NSDictionary?, NSError?) -> ())?) {
    let url = "\(baseURLString)signup"
    
    Alamofire.request(.POST, url, parameters: parameters, encoding: .JSON , headers: ["Content-Type": "application/json; charset=utf-8"])
        .responseJSON { response in
            switch response.result {
            case .Success(let value):
                if (completionHandler != nil) {
                    completionHandler!(value as? NSDictionary, nil)
                }
            case .Failure(let error):
                if (completionHandler != nil) {
                    completionHandler!(nil, error)
                }
            }
    }
}

/**
 Log in request.
 
 parameters = [
    "user" : String,
    "password" : String
 ]
 
 - parameter user:        The user.
 - parameter password:    The password.
 
 */

public func login(parameters: [String: AnyObject],completionHandler: ((NSDictionary?, NSError?) -> ())?) {
    let url = "\(baseURLString)login"
    
    Alamofire.request(.POST, baseURLString, parameters: parameters, encoding: .JSON , headers: ["Content-Type": "application/json; charset=utf-8"])
        .responseJSON { response in
            switch response.result {
            case .Success(let value):
                if (completionHandler != nil) {
                    completionHandler!(value as? NSDictionary, nil)
                }
            case .Failure(let error):
                if (completionHandler != nil) {
                    completionHandler!(nil, error)
                }
            }
    }
}