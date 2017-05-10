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
    
    public static func get_options() -> [String:AnyObject]{
        
        let dict : [String:AnyObject] = [
            "fields" :	"String" as AnyObject,                   //Select fields to be returned.
            "limit" :	"Number" as AnyObject,                   //Limit the number of rows to be returned.
            "skip" :	"Number" as AnyObject,                   //Skip rows to be returned.
            "order" :	"String" as AnyObject                    //Order the rows to be returned.
        ]
        
        return dict
    }
    
}

public struct Attachment_type {
    public var id_attachment_type : String!
    public var name : String!
    
    public static func get_options() -> [String:AnyObject]{
        let dict : [String:AnyObject] = [
            "fields" :	"String" as AnyObject,                   //Select fields to be returned.
            "limit" :	"Number" as AnyObject,                   //Limit the number of rows to be returned.
            "skip" :	"Number" as AnyObject,                   //Skip rows to be returned.
            "order" :	"String" as AnyObject                    //Order the rows to be returned.
        ]
        return dict
    }
}

public struct Country {
    public var id_country : String!
    public var name : String!
    public var code : String!
    
    public static func get_options() -> [String:AnyObject]{
        let dict : [String:AnyObject] = [
            "fields" :	"String" as AnyObject,                   //Select fields to be returned.
            "limit" :	"Number" as AnyObject,                   //Limit the number of rows to be returned.
            "skip" :	"Number" as AnyObject,                   //Skip rows to be returned.
            "order" :	"String" as AnyObject                    //Order the rows to be returned.
        ]
        return dict
    }
}

public struct Site {
    public var id_site : String!
    public var id_site_organization : String!
    public var id_site_organization_type : String!
    public var name : String!
    public var credentials : NSArray!
    
    public static func get_options() -> [String:AnyObject]{
        let dict : [String:AnyObject] = [
            "id_site" :	"String" as AnyObject,                       //Site ID.
            "id_site_organization" : "String" as AnyObject,          //Site Organization ID.
            "id_site_organization_type" : "String" as AnyObject,     //Site Organization Type ID.
            "fields" :	"String" as AnyObject,                       //Select fields to be returned.
            "limit" :	"Number" as AnyObject,                       //Limit the number of rows to be returned.
            "skip" :	"Number" as AnyObject,                       //Skip rows to be returned.
            "order" :	"String" as AnyObject                        //Order the rows to be returned.
        ]
        return dict
    }
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
    
    
    public static func get_options() -> [String:AnyObject]{
        let dict : [String:AnyObject] = [
            "id_site_organization" : "String" as AnyObject,          //Site Organization ID.
            "id_site_organization_type" : "String" as AnyObject,     //Site Organization Type ID.
            "id_country" : "String" as AnyObject,                    //Country ID.
            "fields" :	"String" as AnyObject,                       //Select fields to be returned.
            "limit" :	"Number" as AnyObject,                       //Limit the number of rows to be returned.
            "skip" :	"Number" as AnyObject,                       //Skip rows to be returned.
            "order" :	"String" as AnyObject                        //Order the rows to be returned.
        ]
        return dict
    }
    
}



open class Catalogues : Paybook {
    
    
    // ** MARK Class Methods
    
    
    
    
    // Return ([Account_type]?, NSError?) in completionHandler
    /** Example

     Catalogues.get_account_types(mySession, id_user: nil, completionHandler: {
        response , error in
        print("get_account_types \(response), \(error)")
     })

    */
    
    open class func get_account_types(_ session: Session?, id_user: String?,completionHandler: (([Account_type]?, PaybookError?) -> ())?){
        
        let url = "https://sync.paybook.com/v1/catalogues/account_types"
        var data = [String: AnyObject]()
        
        if session == nil && id_user == nil{
            if completionHandler != nil {
                completionHandler!(nil,PaybookError(code: 401, message: "Unauthorized", response: nil, status: false))
            }
        }else{
            
            
            /*
             if session != nil{
             data.update(["token" : session!.token])
             }
             
             if id_user != nil{
             data.update(["id_user": id_user!])
             }*/
            var authenticate : [String:String] = [:]
            if session != nil{
                authenticate.update(["token" : session!.token])
            }
            
            if id_user != nil{
                authenticate.update(["id_user": id_user!])
            }
            
            
            self.call("GET", endpoint: url, parameters: data, authenticate: authenticate, completionHandler: {
                response, error in
                
                if response != nil {
                    var array = [Account_type]()
                    
                    if let responseArray = response!["response"] as? [AnyObject]{
                        
                        for (item) in responseArray{
                            //array.append(Account_type(id_account_type: value["id_account_type"] as! String, name: value["name"] as! String))
                            array.append(Account_type(id_account_type: item.value(forKey: "id_account_type") as? String ?? "", name: item.value(forKey: "name") as? String ?? ""))
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
    
    open class func get_account_types(_ session: Session?, id_user: String?,options: [String:AnyObject],completionHandler: (([Account_type]?, PaybookError?) -> ())?){
        
        let url = "https://sync.paybook.com/v1/catalogues/account_types"
        var data = [String: AnyObject]()
        
        if session == nil && id_user == nil{
            if completionHandler != nil {
                completionHandler!(nil,PaybookError(code: 401, message: "Unauthorized", response: nil, status: false))
            }
        }else{
            
            
            /*
             if session != nil{
             data.update(["token" : session!.token])
             }
             
             if id_user != nil{
             data.update(["id_user": id_user!])
             }*/
            var authenticate : [String:String] = [:]
            if session != nil{
                authenticate.update(["token" : session!.token])
            }
            
            if id_user != nil{
                authenticate.update(["id_user": id_user!])
            }
            
            data.update(options)
            
            self.call("GET", endpoint: url, parameters: data, authenticate: authenticate, completionHandler: {
                response, error in
                
                if response != nil {
                    var array = [Account_type]()
                    
                    if let responseArray = response!["response"] as? [AnyObject]{
                        
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
        
        
    }

    
    

    
    // Return ([Attachment_type]?, NSError?) in completionHandler
    /** Example
     
     Catalogues.get_attachment_types(mySession, id_user: nil, completionHandler: {
        response , error in
        print("get_attachment_types  \(response), \(error)")
     })
     
     */
    open class func get_attachment_types(_ session: Session?, id_user: String?,completionHandler: (([Attachment_type]?, PaybookError?) -> ())?){
        
        let url = "https://sync.paybook.com/v1/catalogues/attachment_types"
        var data = [String: AnyObject]()
        
        if session == nil && id_user == nil{
            if completionHandler != nil {
                completionHandler!(nil,PaybookError(code: 401, message: "Unauthorized", response: nil, status: false))
            }
        }else{
            
            
            /*
             if session != nil{
             data.update(["token" : session!.token])
             }
             
             if id_user != nil{
             data.update(["id_user": id_user!])
             }*/
            var authenticate : [String:String] = [:]
            if session != nil{
                authenticate.update(["token" : session!.token])
            }
            
            if id_user != nil{
                authenticate.update(["id_user": id_user!])
            }
            
            
            self.call("GET", endpoint: url, parameters: data, authenticate: authenticate, completionHandler: {
                response, error in
                
                if response != nil {
                    var array = [Attachment_type]()
                    
                    if let responseArray = response!["response"] as? [AnyObject]{
                        
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
        
        
    }
    
    open class func get_attachment_types(_ session: Session?, id_user: String?, options: [String:AnyObject],completionHandler: (([Attachment_type]?, PaybookError?) -> ())?){
        
        let url = "https://sync.paybook.com/v1/catalogues/attachment_types"
        var data = [String: AnyObject]()
        
        if session == nil && id_user == nil{
            if completionHandler != nil {
                completionHandler!(nil,PaybookError(code: 401, message: "Unauthorized", response: nil, status: false))
            }
        }else{
            
            
            /*
             if session != nil{
             data.update(["token" : session!.token])
             }
             
             if id_user != nil{
             data.update(["id_user": id_user!])
             }*/
            var authenticate : [String:String] = [:]
            if session != nil{
                authenticate.update(["token" : session!.token])
            }
            
            if id_user != nil{
                authenticate.update(["id_user": id_user!])
            }
            
            data.update(options)
            self.call("GET", endpoint: url, parameters: data, authenticate: authenticate, completionHandler: {
                response, error in
                
                if response != nil {
                    var array = [Attachment_type]()
                    
                    if let responseArray = response!["response"] as? [AnyObject]{
                        
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
        
        
    }

    
    
    
    
    
    // Return ([Country]?, NSError?) in completionHandler
    /** Example
     
     Catalogues.get_countries( mySession, id_user: nil, completionHandler: {
        response , error in
        print("get_countries  \(response), \(error)")
     })
     
     */
    open class func get_countries(_ session: Session?, id_user: String?,completionHandler: (([Country]?, PaybookError?) -> ())?){
        
        
        let url = "https://sync.paybook.com/v1/catalogues/countries"
        var data = [String: AnyObject]()
        
        if session == nil && id_user == nil{
            if completionHandler != nil {
                completionHandler!(nil,PaybookError(code: 401, message: "Unauthorized", response: nil, status: false))
            }
        }else{
            
            /*
             if session != nil{
             data.update(["token" : session!.token])
             }
             
             if id_user != nil{
             data.update(["id_user": id_user!])
             }*/
            var authenticate : [String:String] = [:]
            if session != nil{
                authenticate.update(["token" : session!.token])
            }
            
            if id_user != nil{
                authenticate.update(["id_user": id_user!])
            }
            
            
            self.call("GET", endpoint: url, parameters: data, authenticate: authenticate, completionHandler: {
                response, error in
                
                if response != nil {
                    var array = [Country]()
                    
                    if let responseArray = response!["response"] as? [AnyObject]{
                        
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

    }
    
    open class func get_countries(_ session: Session?, id_user: String?, options: [String:AnyObject],completionHandler: (([Country]?, PaybookError?) -> ())?){
        
        
        let url = "https://sync.paybook.com/v1/catalogues/countries"
        var data = [String: AnyObject]()
        
        if session == nil && id_user == nil{
            if completionHandler != nil {
                completionHandler!(nil,PaybookError(code: 401, message: "Unauthorized", response: nil, status: false))
            }
        }else{
            
            /*
             if session != nil{
             data.update(["token" : session!.token])
             }
             
             if id_user != nil{
             data.update(["id_user": id_user!])
             }*/
            var authenticate : [String:String] = [:]
            if session != nil{
                authenticate.update(["token" : session!.token])
            }
            
            if id_user != nil{
                authenticate.update(["id_user": id_user!])
            }
            
            
            data.update(options)
            self.call("GET", endpoint: url, parameters: data, authenticate: authenticate, completionHandler: {
                response, error in
                
                if response != nil {
                    var array = [Country]()
                    
                    if let responseArray = response!["response"] as? [AnyObject]{
                        
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
        
    }

    
    
    
    
    // Return ([Site]?, NSError?) in completionHandler
    /** Example
     
     Catalogues.get_sites(mySession, id_user: nil, completionHandler: {
        response , error in
        print("get_sites \(response), \(error)")
     })
     
     */
    open class func get_sites(_ session: Session?, id_user: String?,is_test: Bool?,completionHandler: (([Site]?, PaybookError?) -> ())?){
        
        
        let url = "https://sync.paybook.com/v1/catalogues/sites"
        var data = [String: AnyObject]()
        
        
        if session == nil && id_user == nil{
            if completionHandler != nil {
                completionHandler!(nil,PaybookError(code: 401, message: "Unauthorized", response: nil, status: false))
            }
        }else{
            if is_test != nil{
                data.update(["is_test" : is_test! as AnyObject])
            }
            
            /*
             if session != nil{
             data.update(["token" : session!.token])
             }
             
             if id_user != nil{
             data.update(["id_user": id_user!])
             }*/
            var authenticate : [String:String] = [:]
            if session != nil{
                authenticate.update(["token" : session!.token])
            }
            
            if id_user != nil{
                authenticate.update(["id_user": id_user!])
            }
            
            
            self.call("GET", endpoint: url, parameters: data, authenticate: authenticate, completionHandler: {
                response, error in
                
                if response != nil {
                    var array = [Site]()
                    
                    if let responseArray = response!["response"] as? [AnyObject]{
                        
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
        
        
    }
    
    open class func get_sites(_ session: Session?, id_user: String?,is_test: Bool?,options: [String:AnyObject],completionHandler: (([Site]?, PaybookError?) -> ())?){
        
        
        let url = "https://sync.paybook.com/v1/catalogues/sites"
        var data = [String: AnyObject]()
        
        
        if session == nil && id_user == nil{
            if completionHandler != nil {
                completionHandler!(nil,PaybookError(code: 401, message: "Unauthorized", response: nil, status: false))
            }
        }else{
            if is_test != nil{
                data.update(["is_test" : is_test! as AnyObject])
            }
            
            /*
             if session != nil{
             data.update(["token" : session!.token])
             }
             
             if id_user != nil{
             data.update(["id_user": id_user!])
             }*/
            var authenticate : [String:String] = [:]
            if session != nil{
                authenticate.update(["token" : session!.token])
            }
            
            if id_user != nil{
                authenticate.update(["id_user": id_user!])
            }
            
            data.update(options)
            
            self.call("GET", endpoint: url, parameters: data, authenticate: authenticate, completionHandler: {
                response, error in
                
                if response != nil {
                    var array = [Site]()
                    
                    if let responseArray = response!["response"] as? [AnyObject]{
                        
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
        
        
    }
    
    
    
    
    // Return ([Site_organization]?, NSError?) in completionHandler
    /** Example
     
     Catalogues.get_site_organizations(mySession, id_user: nil, completionHandler: {
        response , error in
        print("get_site_organizations  \(response), \(error)")
     })
     
     */
    open class func get_site_organizations(_ session: Session?, id_user: String?,completionHandler: (([Site_organization]?, PaybookError?) -> ())?){
        
        
        let url = "https://sync.paybook.com/v1/catalogues/site_organizations"
        var data = [String: AnyObject]()
        
        if session == nil && id_user == nil{
            if completionHandler != nil {
                completionHandler!(nil,PaybookError(code: 401, message: "Unauthorized", response: nil, status: false))
            }
        }else{
            
            
            /*
             if session != nil{
             data.update(["token" : session!.token])
             }
             
             if id_user != nil{
             data.update(["id_user": id_user!])
             }*/
            var authenticate : [String:String] = [:]
            if session != nil{
                authenticate.update(["token" : session!.token])
            }
            
            if id_user != nil{
                authenticate.update(["id_user": id_user!])
            }
            
            
            self.call("GET", endpoint: url, parameters: data, authenticate: authenticate, completionHandler: {
                response, error in
                
                if response != nil {
                    var array = [Site_organization]()
                    
                    if let responseArray = response!["response"] as? [AnyObject]{
                        
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
    
    open class func get_site_organizations(_ session: Session?, id_user: String?, options: [String:AnyObject],completionHandler: (([Site_organization]?, PaybookError?) -> ())?){
        
        
        let url = "https://sync.paybook.com/v1/catalogues/site_organizations"
        var data = [String: AnyObject]()
        
        if session == nil && id_user == nil{
            if completionHandler != nil {
                completionHandler!(nil,PaybookError(code: 401, message: "Unauthorized", response: nil, status: false))
            }
        }else{
            
            /*
             if session != nil{
             data.update(["token" : session!.token])
             }
             
             if id_user != nil{
             data.update(["id_user": id_user!])
             }*/
            var authenticate : [String:String] = [:]
            if session != nil{
                authenticate.update(["token" : session!.token])
            }
            
            if id_user != nil{
                authenticate.update(["id_user": id_user!])
            }
            
            data.update(options)
            self.call("GET", endpoint: url, parameters: data, authenticate: authenticate, completionHandler: {
                response, error in
                
                if response != nil {
                    var array = [Site_organization]()
                    
                    if let responseArray = response!["response"] as? [AnyObject]{
                        
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

    
    
    
}
