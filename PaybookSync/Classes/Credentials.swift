//
//  Credentials.swift
//  Pods
//
//  Created by Gabriel Villarreal on 10/06/16.
//
//

import Foundation


public class Credentials : Paybook {
    
    var id_credential : String!
    var id_site : String!
    var username : String!
    var id_site_organization : String!
    var id_site_organization_type : String!
    var ws : String!
    var status : String!
    var twofa : String!
    
    
    // Return a Credentials in completionHandler.
    /**
     _ = Credentials(session: [mySession], id_user: nil, id_site: ["id_site"], credentials: [data_credentials], completionHandler: {
        response, error in
        print(" \(response), \(error)")
    })
     */
    
    public convenience init (session : Session ,id_user : String? , id_site: String, credentials: NSDictionary , completionHandler: ((Credentials?, PaybookError?) -> ())?){
        
        
        
        // Init
        self.init()
        self.id_site = credentials["id_site"] as? String
        self.id_site_organization = credentials["id_site_organization"] as? String
        self.id_site_organization_type = credentials["id_site_organization_type"] as? String
        // Create user in API
        let data = [
            "token" : session.token,
            "id_site" : id_site,
            "credentials" : credentials
        ]
        
        let url = "credentials"
        
        Paybook.call("POST", endpoint: url, parameters: data, completionHandler: {
            response, error in
            
            
            if response != nil {
                if let responseObject = response!["response"] as? NSDictionary{
                    
                    self.id_credential = responseObject["id_credential"] as? String
                    self.username = responseObject["username"] as? String
                    self.ws = responseObject["ws"] as? String
                    self.status = responseObject["status"] as? String
                    self.twofa = responseObject["twofa"] as? String
                    
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
    
    
    
    // ** MARK Instance Methods
    
   
    
    // [Dict]
    public func get_status( session : Session,id_user : String, completionHandler: ((NSDictionary?, PaybookError?) -> ())? ){
        
    }
    
    
    
    // ** MARK Class Methods
    
    // Bool deleted
    public class func delete( session : Session,id_user : String? ,id_credential: String, completionHandler: ((Bool?, PaybookError?) -> ())?){
        
        
        let data = [
            "token" : session.token,
        ]
        
        let url = "credentials/\(id_credential)"
        
        self.call("DELETE", endpoint: url, parameters: data, completionHandler: {
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
    
    
    
    
    // Return [Credentials] in completionHandler
    /** Example
     Credentials.get(vartest, id_user: nil, completionHandler: {
        response, error in
        print(" \(response), \(error)")
     })
     */
    public class func get(session: Session,id_user: String?, completionHandler: ((NSDictionary?, PaybookError?) -> ())?){
        
        let url = "credentials"
        let data = [
            "token" : session.token
        ]
        
        self.call("GET", endpoint: url, parameters: data, completionHandler: {
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