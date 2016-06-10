//
//  Session.swift
//  Pods
//
//  Created by Gabriel Villarreal on 08/06/16.
//
//

import Foundation
import Alamofire


public class Session {
    
    public var token : String!
    public var id_user : String!
    //public var user : User
    
    
    
    
    public convenience init(id_user: String){
        self.init()
        
        self.id_user = id_user
    }
    
    
    
    
    
    
    public func create(completionHandler: ((NSDictionary?, NSError?) -> ())?) {//-> [User]?{
        
        var data = [
            "api_key" : pubKey,
            "id_user" : self.id_user
        ]
        
        let url = "\(baseURLString)sessions"
        
        
        Alamofire.request(.POST, url, parameters: data, encoding: .JSON , headers: ["Content-Type": "application/json; charset=utf-8"]).responseJSON { response in
            switch response.result {
            case .Success(let value):
                //Update Session object
                if var response = value as? NSDictionary{
                    if var responseObject = response["response"] as? NSDictionary {
                            self.token = responseObject["token"] as? String
                    }
                }
                //Run completionHandler
                if(completionHandler != nil){
                    completionHandler!(value as? NSDictionary, nil)
                }
            case .Failure(let error):
                if(completionHandler != nil){
                    completionHandler!(nil, error)
                }
            }
        }
        
    }
    
    /** Example
     var mySession = Session([id_user])
     
     mySession.create() {
        responseObject , error in
        print("responseObject = \(responseObject); error = \(error)")
        return
     }
     */
    
    
    
    
    
    
    
    public func delete(completionHandler: ((NSDictionary?, NSError?) -> ())?) {//-> [User]?{
        
        let url = "\(baseURLString)sessions/\(self.token)"
        
        Alamofire.request(.DELETE, url, parameters: nil, encoding: .JSON , headers: ["Content-Type": "application/json; charset=utf-8"]).responseJSON { response in
            switch response.result {
            case .Success(let value):
                if(completionHandler != nil){
                    completionHandler!(value as? NSDictionary, nil)
                }
            case .Failure(let error):
                if(completionHandler != nil){
                    completionHandler!(nil, error)
                }
            }
        }
        
    }
    
    /** Example
     mySession.delete() {
        responseObject , error in
        print("responseObject = \(responseObject); error = \(error)")
        return
     }
     */
    
    
    
    
    
    
    
    public func validate(completionHandler: ((NSDictionary?, NSError?) -> ())?) {//-> [User]?{
        
        var data = [
            "token" : self.token
            
        ]
        
        let url = "\(baseURLString)sessions/\(self.token)/verify"
        
        
        Alamofire.request(.GET, url, parameters: data, encoding: .JSON , headers: ["Content-Type": "application/json; charset=utf-8"]).responseJSON { response in
            switch response.result {
            case .Success(let value):
                if(completionHandler != nil){
                    completionHandler!(value as? NSDictionary, nil)
                }
            case .Failure(let error):
                if(completionHandler != nil){
                    completionHandler!(nil, error)
                }
            }
        }
        
    }
    
    /** Example
     mySession.validate() {
        responseObject , error in
        print("responseObject = \(responseObject); error = \(error)")
        return
     }
     */

    
    
}
