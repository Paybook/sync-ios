//
//  User.swift
//  Pods
//
//  Created by Gabriel Villarreal on 06/06/16.
//
//

import Foundation
import Alamofire


public class User : Paybook {
    
    public var id_user : String!
    public var id_external : String!
    public var name : String!
    public var dt_create : NSDate!
    public var dt_modify : NSDate!
    
    
    
    init(username: String){
        
        // Init
        self.name = username
        super.init()
        
    }
    
    // Init with NSDictionary with existing users from API
    convenience init(dic: NSDictionary){
        
        // Init
        self.init(username: dic["name"] as! String)
        
        self.id_user = dic["id_user"] as? String
        self.id_external = dic["id_external"] as? String
        self.dt_create = dic["dt_create"] as? NSDate
        self.dt_modify = dic["dt_modify"] as? NSDate
        
    }
    
    // Init object and create user in API
    
    /** Example how to get all users
     _ = User(username: "[username]", completionHandler: {
        user , error in
        print("User created in API = \(user); error = \(error)")
     })
     */
 
    convenience public init(username: String, completionHandler: ((User?, NSError?) -> ())?){
        
        // Init
        self.init(username: username)
        
        // Create user in API
        var data = [
            "name" : username
        ]
        
        let url = "users"
        
        Paybook.call("POST", endpoint: url, parameters: data, completionHandler: {
            response, error in
            
            
            if response != nil {
                if var responseObject = response!["response"] as? NSDictionary{
                    self.id_user = responseObject["id_user"] as? String
                    self.id_external = responseObject["id_external"] as? String
                    self.dt_create = responseObject["dt_create"] as? NSDate
                    self.dt_modify = responseObject["dt_modify"] as? NSDate
                    
                    if completionHandler != nil {
                        completionHandler!(self,error)
                    }
                        
                    
                }
                
                
            }else{
                if completionHandler != nil {
                    completionHandler!(nil,error)
                }
            }
            
        })
        
        
    }
    
    
    
    
    // ** MARK Class Methods
    
    
    
    /** Example how to get all users
     User.get_all() {
        responseArray , error in
    
        print("responseObject = \(responseObject); error = \(error)")
        return
     }
     */
    
    public class func get(completionHandler: (([User]?, NSError?) -> ())?) {//-> [User]?{
 
        let url = "users"
        
        var array = [User]()
        
        
        
        self.call("GET", endpoint: url, parameters: nil, completionHandler: {
            response, error in
            
            if response != nil {
                var usersArray = [User]()
                
                if var responseArray = response!["response"] as? NSArray{
                    
                    for (value) in responseArray{
                        usersArray.append(User(dic: value as! NSDictionary))
                    }
                    if completionHandler != nil {
                        completionHandler!(usersArray,error)
                    }
                }
                
            }else{
                if completionHandler != nil {
                    completionHandler!(nil,error)
                }
            }
            
        })
        
    }
    
    
    
    
    
    /** Example how to delete a users
     User.delete("[id_user]", completionHandler: {
        responseObject, error in
        print("responseObject = \(responseObject); error = \(error)")
        return
     })
     */
    public class func delete(id_user: String, completionHandler: ((NSDictionary?, NSError?) -> ())?){
        
        
        
        let url = "users/\(id_user)"
        
        self.call("DELETE", endpoint: url, parameters: nil, completionHandler: {
            response, error in
            
            if response != nil {
                if completionHandler != nil {
                    completionHandler!(response,error)
                }
                
            }else{
                if completionHandler != nil {
                    completionHandler!(nil,error)
                }
            }
            
        })
    
    
    
    
    
    }
    
    
    
    
}



