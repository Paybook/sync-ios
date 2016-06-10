//
//  User.swift
//  Pods
//
//  Created by Gabriel Villarreal on 06/06/16.
//
//

import Foundation
import Alamofire


public class User {
    
    public var id_user : String!
    public var id_external : String!
    public var name : String!
    public var dt_create : NSDate!
    public var dt_modify : NSDate!
    
    
    
    public init (username: String){
        
        // Init
        self.name = username
        // Create user in API
        register(username, completionHandler: {
            responseObject, error in
            if responseObject != nil {
                if var user = responseObject!["response"] as? NSDictionary {
                    self.id_user = user["id_user"] as? String
                    self.id_external = user["id_external"] as? String
                    self.dt_create = user["dt_create"] as? NSDate
                    self.dt_modify = user["dt_modify"] as? NSDate
                    print(user)
                }
            }else if error != nil{
                print(error)
            }
            
            
        })
        
       
        
    }

    
    // Mark Private function to send user to Paybook API
    
    func register(username: String, completionHandler: ((NSDictionary?, NSError?) -> ())?){
        
        var data = [
            "api_key" : pubKey,
            "name" : username
        ]
        
        let url = "\(baseURLString)users"
        
        Alamofire.request(.POST, url, parameters: data, encoding: .JSON , headers: ["Content-Type": "application/json; charset=utf-8"]).responseJSON { response in
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
    
    
    // Mark Public functions
    
    
    
/*
    
    public func signup(completionHandler: ((NSDictionary?, NSError?) -> ())?){
        
        var data = [
            "api_key" : pubKey,
            "name" : self.name
        ]
        
        let url = "\(baseURLString)users"
        
        Alamofire.request(.POST, url, parameters: data, encoding: .JSON , headers: ["Content-Type": "application/json; charset=utf-8"]).responseJSON { response in
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
    
    }*/
    
    /** Example
     
     User.signup(username.text!, password: password.text!, completionHandler: {
        responseObject, error in
        print("responseObject = \(responseObject); error = \(error)")
        return
     })
     
     */
    
    
    
    
    
    
    public class func get_all(completionHandler: ((NSDictionary?, NSError?) -> ())?) {//-> [User]?{
        
        var data = [
            "api_key" : pubKey
        ]
 
        let url = "\(baseURLString)users"
        
        var array = [User]()
        
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
     User.get_all() {
        responseObject , error in
        print("responseObject = \(responseObject); error = \(error)")
        return
     }
    */
    
    
    
    
    
    
    public class func login(username: String, password: String, completionHandler: ((NSDictionary?, NSError?) -> ())?){
        
        var data = [
            "api_key" : pubKey,
            "username" : username,
            "password" : password
        ]
        
        let url = "\(baseURLString)login"
        
        Alamofire.request(.POST, url, parameters: data, encoding: .JSON , headers: ["Content-Type": "application/json; charset=utf-8"]).responseJSON { response in
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
    /*
     User.login(username.text!, password: password.text!, completionHandler: {
        responseObject, error in
        print("responseObject = \(responseObject); error = \(error)")
        return
     })
     
     */
    
    
    
    
    
    
    
    public class func delete(id_user: String, completionHandler: ((NSDictionary?, NSError?) -> ())?){
        
        var data = [
            "api_key" : pubKey,
            "id_user" : id_user
        ]
        
        let url = "\(baseURLString)users/\(id_user)"
        
        Alamofire.request(.DELETE, url, parameters: data, encoding: .JSON , headers: ["Content-Type": "application/json; charset=utf-8"]).responseJSON { response in
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
    
    /*
     User.delete("5737adb80b212ae23d8b4584", completionHandler: {
        responseObject, error in
        print("responseObject = \(responseObject); error = \(error)")
        return
     })
    */
    
    
}



