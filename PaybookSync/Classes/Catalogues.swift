//
//  Catalogues.swift
//  Pods
//
//  Created by Gabriel Villarreal on 16/06/16.
//
//

import Foundation

// ** MARK Class Structures


public struct Account_type {
    var id_account_type : String!
    var name : String!
}

public struct Attachment_type {
    var id_attachment_type : String!
    var name : String!
}

public struct Country {
    var id_country : String!
    var name : String!
    var code : String!
}

public struct Site {
    var id_site : String!
    var id_site_organization : String!
    var id_site_organization_type : String!
    var name : String!
    var credentials : NSArray!
}

public struct Credential_structure {
    var name : String!
    var type : String!
    var label : String!
    var required : Bool!
    var username : String!
}

public struct Site_organization {
    var id_site_organization : String!
    var id_site_organization_type : String!
    var id_country : String!
    var name : String!
    var avatar : String!
    var small_cover : String!
    var cover : String!
}



public class Catalogues : Paybook {
    
    
    // ** MARK Class Methods
    
    
    
    
    // Return ([Account_type]?, NSError?) in completionHandler
    /** Example

     Catalogues.get_account_types(mySession, id_user: nil, completionHandler: {
        response , error in
        print("get_account_types \(response), \(error)")
     })

    */
    
    public class func get_account_types(session: Session, id_user: String?,completionHandler: (([Account_type]?, NSError?) -> ())?){
        
        let url = "catalogues/account_types"
        let data = [
            "token" : session.token
        ]
        self.call("GET", endpoint: url, parameters: data, completionHandler: {
        response, error in
            
            if response != nil {
                var array = [Account_type]()
                
                if let responseArray = response!["response"] as? NSArray{
                    
                    for (value) in responseArray{
                        array.append(Account_type(id_account_type: value["id_account_type"] as! String, name: value["name"] as! String))
                    }
                    
                    if completionHandler != nil {
                        completionHandler!(array,error)
                    }
                }
                
            }else{
                if completionHandler != nil {
                    completionHandler!(nil,error)
                }
            }

        
        })
       
    }
    
    
    
    

    
    // Return ([Attachment_type]?, NSError?) in completionHandler
    /** Example
     
     Catalogues.get_attachment_types(mySession, id_user: nil, completionHandler: {
        response , error in
        print("get_attachment_types  \(response), \(error)")
     })
     
     */
    public class func get_attachment_types(session: Session, id_user: String?,completionHandler: (([Attachment_type]?, NSError?) -> ())?){
        
        let url = "catalogues/attachment_types"
        let data = [
            "token" : session.token
        ]
        self.call("GET", endpoint: url, parameters: data, completionHandler: {
            response, error in
            
            if response != nil {
                var array = [Attachment_type]()
                
                if let responseArray = response!["response"] as? NSArray{
                    
                    for (value) in responseArray{
                        array.append(Attachment_type(id_attachment_type: value["id_attachment_type"] as? String, name: value["name"] as? String))
                    }
                    
                    if completionHandler != nil {
                        completionHandler!(array,error)
                    }
                }
                
            }else{
                if completionHandler != nil {
                    completionHandler!(nil,error)
                }
            }
            
            
        })

    }
    
    
    
    
    
    
    // Return ([Country]?, NSError?) in completionHandler
    /** Example
     
     Catalogues.get_countries( mySession, id_user: nil, completionHandler: {
        response , error in
        print("get_countries  \(response), \(error)")
     })
     
     */
    public class func get_countries(session: Session, id_user: String?,completionHandler: (([Country]?, NSError?) -> ())?){
        
        
        let url = "catalogues/countries"
        let data = [
            "token" : session.token
        ]
        self.call("GET", endpoint: url, parameters: data, completionHandler: {
            response, error in
            
            if response != nil {
                var array = [Country]()
                
                if let responseArray = response!["response"] as? NSArray{
                    
                    for (value) in responseArray{
                        array.append(Country(id_country: value["id_country"] as! String, name: value["name"] as! String, code: value["code"] as! String))
                    }
                    
                    if completionHandler != nil {
                        completionHandler!(array,error)
                    }
                }
                
            }else{
                if completionHandler != nil {
                    completionHandler!(nil,error)
                }
            }
            
            
        })
        
        
    }
    
    
    
    
    
    
    // Return ([Site]?, NSError?) in completionHandler
    /** Example
     
     Catalogues.get_sites(mySession, id_user: nil, completionHandler: {
        response , error in
        print("get_sites \(response), \(error)")
     })
     
     */
    public class func get_sites(session: Session, id_user: String?,completionHandler: (([Site]?, NSError?) -> ())?){
        
        
        let url = "catalogues/sites"
        let data = [
            "token" : session.token
        ]
        self.call("GET", endpoint: url, parameters: data, completionHandler: {
            response, error in
            
            if response != nil {
                var array = [Site]()
                
                if let responseArray = response!["response"] as? NSArray{
                    
                    for (value) in responseArray{
                        array.append(Site(id_site: value["id_site"] as? String, id_site_organization: value["id_site_organization"] as? String, id_site_organization_type: value["id_site_organization_type"] as? String, name: value["name"] as? String, credentials: value["credentials"] as? NSArray))
                    }
                    
                    if completionHandler != nil {
                        completionHandler!(array,error)
                    }
                }
                
            }else{
                if completionHandler != nil {
                    completionHandler!(nil,error)
                }
            }
            
            
        })
        
    }
    
    
    
    
    
    // Return ([Site_organization]?, NSError?) in completionHandler
    /** Example
     
     Catalogues.get_site_organizations(mySession, id_user: nil, completionHandler: {
        response , error in
        print("get_site_organizations  \(response), \(error)")
     })
     
     */
    public class func get_site_organizations(session: Session, id_user: String?,completionHandler: (([Site_organization]?, NSError?) -> ())?){
        
        
        let url = "catalogues/site_organizations"
        let data = [
            "token" : session.token
        ]
        self.call("GET", endpoint: url, parameters: data, completionHandler: {
            response, error in
            
            if response != nil {
                var array = [Site_organization]()
                
                if let responseArray = response!["response"] as? NSArray{
                    
                    for (value) in responseArray{
                        array.append(Site_organization(
                            id_site_organization: value["id_site_organization"] as? String,
                            id_site_organization_type: value["id_site_organization_type"] as? String,
                            id_country: value["id_country"] as? String,
                            name: value["name"] as? String,
                            avatar: value["avatar"] as? String,
                            small_cover: value["small_cover"] as? String,
                            cover: value["cover"] as? String))
                    }
                    
                    if completionHandler != nil {
                        completionHandler!(array,error)
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