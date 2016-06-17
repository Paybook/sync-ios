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
    
    
    // Credentials
    public init (session : String,id_user : String,id_site: String, credentials: NSDictionary , completionHandler: ((NSDictionary?, NSError?) -> ())?){
        self.id_credential = credentials["id_credential"] as? String
        self.id_site = credentials["id_site"] as? String
        self.username = credentials["username"] as? String
        self.id_site_organization = credentials["id_site_organization"] as? String
        self.id_site_organization_type = credentials["id_site_organization_type"] as? String
        self.ws = credentials["ws"] as? String
        self.status = credentials["status"] as? String
        self.twofa = credentials["twofa"] as? String
    }
    
    
    
    // ** MARK Instance Methods
    
   
    
    // [Dict]
    public func get_status( session : Session,id_user : String, completionHandler: ((NSDictionary?, NSError?) -> ())? ){
        
    }
    
    
    
    // ** MARK Class Methods
    
    // Bool deleted
    public class func delete( session : Session,id_user : String ,id_credential: String, completionHandler: ((NSDictionary?, NSError?) -> ())?){
        
    }
    
    // [Credentials]
    public class func get(session: Session,id_user: String, completionHandler: ((NSDictionary?, NSError?) -> ())?){
        
        let url = "credentials"
        var data = [
            "token" : session.token,
            //"id_user" : session.id_user
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