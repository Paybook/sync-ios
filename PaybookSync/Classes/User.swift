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
    public var dt_create : Int!
    public var dt_modify : Int!
    
    
    
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
        self.dt_create = dic["dt_create"] as? Int
        self.dt_modify = dic["dt_modify"] as? Int
        
    }
    
    // Init object and create user in API
    
    // Return (User,NSError) in completionHandler
    /** Example how to create a user
     _ = User(username: "[username]", completionHandler: {
        user , error in
        print("User created in API = \(user); error = \(error)")
     })
     */
 
    convenience public init(username: String, id_user: String?,completionHandler: ((User?, PaybookError?) -> ())?){
        
        // Init
        self.init(username: username)
        
        if id_user != nil {
            // Create user in API
            
            let url = "https://sync.paybook.com/v1/users/\(id_user!)"
            
            Paybook.call("GET", endpoint: url, parameters: nil, completionHandler: {
                response, error in
                
                if response != nil {
                    
                    if let responseObject = response!["response"] as? NSArray{
                        if let user = responseObject[0] as? NSDictionary {
                            self.id_user = user["id_user"] as? String
                            self.id_external = user["id_external"] as? String
                            self.dt_create = user["dt_create"] as? Int
                            self.dt_modify = user["dt_modify"] as? Int
                            self.name = user["name"] as? String
                            
                            if completionHandler != nil {
                                completionHandler!(self,error)
                            }
                        }
                    }
                    
                
                }else{
                    if completionHandler != nil {
                        completionHandler!(nil,error)
                    }
                }
                
            })

            
            
            
        }else{
            
            // Create user in API
            let data = [
                "name" : username
            ]
            
            let url = "https://sync.paybook.com/v1/users"
            
            Paybook.call("POST", endpoint: url, parameters: data, completionHandler: {
                response, error in
                
                
                if response != nil {
                    if let responseObject = response!["response"] as? NSDictionary{
                        self.id_user = responseObject["id_user"] as? String
                        self.id_external = responseObject["id_external"] as? String
                        self.dt_create = responseObject["dt_create"] as? Int
                        self.dt_modify = responseObject["dt_modify"] as? Int
                        
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
        
        
        
    }
    
    
    
    
    // ** MARK Class Methods
    
    
    // Return ([User],NSError) in completionHandler
    /** Example how to get all users
     User.get() {
        responseArray , error in
    
        print("responseObject = \(responseArray); error = \(error)")
        return
     }
     */
    
    public class func get(completionHandler: (([User]?, PaybookError?) -> ())?) {//-> [User]?{
 
        let url = "https://sync.paybook.com/v1/users"
        
        self.call("GET", endpoint: url, parameters: nil, completionHandler: {
            response, error in
            
            if response != nil {
                var usersArray = [User]()
                
                if let responseArray = response!["response"] as? NSArray{
                    
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
    
    
    
    
    // Return (NSDictionary,NSError) in completionHandler
    /** Example how to delete a users
     User.delete("[id_user]", completionHandler: {
        responseObject, error in
        print("responseObject = \(responseObject); error = \(error)")
        return
     })
     */
    public class func delete(id_user: String, completionHandler: ((Bool?, PaybookError?) -> ())?){
        
        
        
        let url = "https://sync.paybook.com/v1/users/\(id_user)"
        
        self.call("DELETE", endpoint: url, parameters: nil, completionHandler: {
            response, error in
            
            if response != nil{
                if response!["code"] as! Int == 200{
                    if completionHandler != nil {
                        completionHandler!(true,error)
                    }
                }else{
                    if completionHandler != nil {
                        completionHandler!(false,error)
                    }
                }
                
            }else{
                if completionHandler != nil {
                    completionHandler!(nil,error)
                }
            }
            
        })
    
    
    
    
    
    }
    
    
    
    
}



