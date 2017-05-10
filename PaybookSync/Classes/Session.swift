//
//  Session.swift
//  Pods
//
//  Created by Gabriel Villarreal on 08/06/16.
//
//

import Foundation
import Alamofire


open class Session: Paybook {
    
    open var token : String!
    open var id_user : String!
    
    
    
    
    // ** MARK Convenience INIT
    
    // Return (Session?, NSError?) in completionHandler
    /** To init a Session you can use this code
     
     _ = Session(id_user: "[id_user]", completionHandler: {
     session , error in
     print("Session created in API = \(session?.token); error = \(error)")
     })
     
     */
    
    public convenience init(id_user: String, completionHandler: ((Session?, PaybookError?) -> ())?){
        self.init()
        
        self.id_user = id_user
        
        
        let data = [
            "id_user" : id_user
        ]
        
        let url = "https://sync.paybook.com/v1/sessions"
        
        
        Paybook.call("POST", endpoint: url, parameters: data as [String : AnyObject]?,authenticate: nil, completionHandler: {
            response, error in
            
            if response != nil {
                if let responseObject = response!["response"] as? NSDictionary{
                    self.token = responseObject["token"] as? String
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
    
    // Return (NSDictionary?, NSError?) in completionHandler
    /** Example to delete a Session
     
     Session.delete("[token]", completionHandler: {
        responseObject, error in
        print("responseObject = \(responseObject); error = \(error)")
        return
     })
     
     */
    
    open class func delete(_ token: String, completionHandler: ((Bool?, PaybookError?) -> ())?){
        
        
        var authenticate : [String:String] = ["token": token]
        let url = "https://sync.paybook.com/v1/sessions/\(token)"
        
        
        self.call("DELETE", endpoint: url, parameters: nil, authenticate: authenticate, completionHandler: {
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
    
   
    
    // ** MARK Instance Methods
    
    // Return (NSDictionary?, NSError?) in completionHandler
    /** Example to validate Session
     
     mySession.validate() {
        responseObject , error in
        print("responseObject = \(responseObject); error = \(error)")
        return
     }
    
    */
    
    open func validate(_ completionHandler: ((Bool?, PaybookError?) -> ())?) {//-> [User]?{
        
        var authenticate : [String:String] = ["token": token]
        let url = "https://sync.paybook.com/v1/sessions/\(self.token!)/verify"
        
        
        Paybook.call("GET", endpoint: url, parameters: nil,authenticate: authenticate, completionHandler: {
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
                    completionHandler!(false,error)
                }
            }
            
        })
    }
    
    

    
    
    
    
}
