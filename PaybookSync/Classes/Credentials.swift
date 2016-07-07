//
//  Credentials.swift
//  Pods
//
//  Created by Gabriel Villarreal on 10/06/16.
//
//

import Foundation


public class Credentials : Paybook {
    
    public var id_credential : String!
    public var id_site : String!
    public var username : String!
    public var id_site_organization : String!
    public var id_site_organization_type : String!
    public var ws : String!
    public var status : String!
    public var twofa : String!
    
    
    // Return a Credentials in completionHandler.
    /**
     _ = Credentials(session: [mySession], id_user: nil, id_site: ["id_site"], credentials: [data_credentials], completionHandler: {
        response, error in
        print(" \(response), \(error)")
    })
     */
    
    public convenience init (session : Session? ,id_user : String? , id_site: String, credentials: NSDictionary , completionHandler: ((Credentials?, PaybookError?) -> ())?){
        
        
        
        // Init
        self.init()
        self.id_site = credentials["id_site"] as? String
        self.id_site_organization = credentials["id_site_organization"] as? String
        self.id_site_organization_type = credentials["id_site_organization_type"] as? String
        // Create user in API
        
        let url = "https://sync.paybook.com/v1/credentials"

        var data = [String: AnyObject]()
        
        if session == nil && id_user == nil{
            if completionHandler != nil {
                completionHandler!(nil,PaybookError(code: 401, message: "Unauthorized", response: nil, status: false))
            }
        }else{
            
            data = [
                "id_site" : id_site,
                "credentials" : credentials
            ]
            
            if session != nil{
                data.update(["token" : session!.token])
            }
            
            if id_user != nil{
                data.update(["id_user": id_user!])
            }
            
            
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

        
        
        
        
        
    }
    
    
    
    
    
    
    // Credential
    convenience init (dict: NSDictionary){
        self.init()
        
        self.id_site = dict["id_site"] as? String
        self.id_site_organization = dict["id_site_organization"] as? String
        self.id_site_organization_type = dict["id_site_organization_type"] as? String
        self.id_credential = dict["id_credential"] as? String
        self.username = dict["username"] as? String
        self.ws = dict["ws"] as? String
        self.status = dict["status"] as? String
        self.twofa = dict["twofa"] as? String
    }
    
    // ** MARK Instance Methods
    
   
    
    // [NSDictionary]
    public func get_status( session : Session?,id_user : String?, completionHandler: (([NSDictionary]?, PaybookError?) -> ())? ){
        
        let url = self.status
        var data = [String: AnyObject]()
        
        if session == nil && id_user == nil{
            if completionHandler != nil {
                completionHandler!(nil,PaybookError(code: 401, message: "Unauthorized", response: nil, status: false))
            }
        }else{
            
            
            if session != nil{
                data.update(["token" : session!.token])
            }
            
            if id_user != nil{
                data.update(["id_user": id_user!])
            }
            
            Paybook.call("GET", endpoint: url, parameters: data, completionHandler: {
                response, error in
                
                if response != nil {
                    
                    if let responseObject = response!["response"] as? [NSDictionary]{
                        
                        if completionHandler != nil {
                            completionHandler!(responseObject,nil)
                        }
                    }else{
                        if completionHandler != nil {
                            completionHandler!(nil,error)
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
    
    // Bool
    public func set_twofa( session : Session?,id_user : String?,params: NSDictionary ,completionHandler: ((Bool?, PaybookError?) -> ())? ){
        
        let url = self.twofa
        
        var data = [String: AnyObject]()
        
        if session == nil && id_user == nil{
            if completionHandler != nil {
                completionHandler!(nil,PaybookError(code: 401, message: "Unauthorized", response: nil, status: false))
            }
        }else{
            data =  [
                "twofa": params
            ]
            
            if session != nil{
                data.update(["token" : session!.token])
            }
            
            if id_user != nil{
                data.update(["id_user": id_user!])
            }
            
            Paybook.call("POST", endpoint: url, parameters: data, completionHandler: {
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
    
    
    // ** MARK Class Methods
    
    // Bool deleted
    public class func delete( session : Session?,id_user : String? ,id_credential: String, completionHandler: ((Bool?, PaybookError?) -> ())?){
        
        let url = "https://sync.paybook.com/v1/credentials/\(id_credential)"
        var data = [String: AnyObject]()
        
        if session == nil && id_user == nil{
            if completionHandler != nil {
                completionHandler!(nil,PaybookError(code: 401, message: "Unauthorized", response: nil, status: false))
            }
        }else{
            
            
            if session != nil{
                data.update(["token" : session!.token])
            }
            
            if id_user != nil{
                data.update(["id_user": id_user!])
            }
            
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

    }
    
    
    
    
    // Return [Credentials] in completionHandler
    /** Example
     Credentials.get(mySession, id_user: nil, completionHandler: {
        response, error in
        print(" \(response), \(error)")
     })
     */
    public class func get(session: Session?,id_user: String?, completionHandler: (([Credentials]?, PaybookError?) -> ())?){
        
        let url = "https://sync.paybook.com/v1/credentials"
        var data = [String: AnyObject]()
        
        if session == nil && id_user == nil{
            if completionHandler != nil {
                completionHandler!(nil,PaybookError(code: 401, message: "Unauthorized", response: nil, status: false))
            }
        }else{
            
            
            if session != nil{
                data.update(["token" : session!.token])
            }
            
            if id_user != nil{
                data.update(["id_user": id_user!])
            }
            
            self.call("GET", endpoint: url, parameters: data, completionHandler: {
                response, error in
                
                if response != nil {
                    var array = [Credentials]()
                    
                    if let responseArray = response!["response"] as? NSArray{
                        
                        for (value) in responseArray{
                            array.append(Credentials(dict: value as! NSDictionary))
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