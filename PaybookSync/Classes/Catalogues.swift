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
    public var id_account_type : String!
    public var name : String!
}

public struct Attachment_type {
    public var id_attachment_type : String!
    public var name : String!
}

public struct Country {
    public var id_country : String!
    public var name : String!
    public var code : String!
}

public struct Site {
    public var id_site : String!
    public var id_site_organization : String!
    public var id_site_organization_type : String!
    public var name : String!
    public var credentials : NSArray!
}

public struct Credential_structure {
    public var name : String!
    public var type : String!
    public var label : String!
    public var required : Bool!
    public var username : String!
}

public struct Site_organization {
    public var id_site_organization : String!
    public var id_site_organization_type : String!
    public var id_country : String!
    public var name : String!
    public var avatar : String!
    public var small_cover : String!
    public var cover : String!
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
    
    public class func get_account_types(session: Session, id_user: String?,completionHandler: (([Account_type]?, PaybookError?) -> ())?){
        
        let url = "https://sync.paybook.com/v1/catalogues/account_types"
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
    public class func get_attachment_types(session: Session, id_user: String?,completionHandler: (([Attachment_type]?, PaybookError?) -> ())?){
        
        let url = "https://sync.paybook.com/v1/catalogues/attachment_types"
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
    public class func get_countries(session: Session, id_user: String?,completionHandler: (([Country]?, PaybookError?) -> ())?){
        
        
        let url = "https://sync.paybook.com/v1/catalogues/countries"
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
    public class func get_sites(session: Session, id_user: String?,is_test: Bool?,completionHandler: (([Site]?, PaybookError?) -> ())?){
        
        
        let url = "https://sync.paybook.com/v1/catalogues/sites"
        let data: NSDictionary
        
        if is_test != nil{
            data = [
                "token" : session.token,
                "is_test" : is_test!
            ]
        }else{
            data = [
                "token" : session.token
            ]
        }
        
        
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
    public class func get_site_organizations(session: Session, id_user: String?,completionHandler: (([Site_organization]?, PaybookError?) -> ())?){
        
        
        let url = "https://sync.paybook.com/v1/catalogues/site_organizations"
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