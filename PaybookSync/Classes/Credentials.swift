//
//  Credentials.swift
//  Pods
//
//  Created by Gabriel Villarreal on 10/06/16.
//
//

import Foundation


open class Credentials : Paybook {
    
    open var id_credential : String!
    open var id_site : String!
    open var username : String!
    open var id_site_organization : String!
    open var id_site_organization_type : String!
    open var ws : String!
    open var status : String!
    open var twofa : String!
    
    
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
                "id_site" : id_site as AnyObject,
                "credentials" : credentials
            ]
            
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
            
            
            
            Paybook.call("POST", endpoint: url, parameters: data, authenticate: authenticate, completionHandler: {
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
    open func get_status( _ session : Session?,id_user : String?, completionHandler: (([NSDictionary]?, PaybookError?) -> ())? ){
        
        let url = self.status
        var data = [String: AnyObject]()
        
        if session == nil && id_user == nil{
            if completionHandler != nil {
                completionHandler!(nil,PaybookError(code: 401, message: "Unauthorized", response: nil, status: false))
            }
        }else if url != nil{
            
            var authenticate : [String:String] = [:]
            if session != nil{
                authenticate.update(["token" : session!.token])
            }
            
            if id_user != nil{
                authenticate.update(["id_user": id_user!])
            }
            
            
            Paybook.call("GET", endpoint: url!, parameters: data, authenticate: authenticate,completionHandler: {
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
    open func set_twofa( _ session : Session?,id_user : String?,params: NSDictionary ,completionHandler: ((Bool?, PaybookError?) -> ())? ){
        
        let url = self.twofa
        
        var data = [String: AnyObject]()
        
        if session == nil && id_user == nil{
            if completionHandler != nil {
                completionHandler!(nil,PaybookError(code: 401, message: "Unauthorized", response: nil, status: false))
            }
        }else if url != nil{
            data =  [
                "twofa": params
            ]
            
            var authenticate : [String:String] = [:]
            if session != nil{
                authenticate.update(["token" : session!.token])
            }
            
            if id_user != nil{
                authenticate.update(["id_user": id_user!])
            }
            
            
            Paybook.call("POST", endpoint: url!, parameters: data, authenticate: authenticate,completionHandler: {
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
    open class func delete( _ session : Session?,id_user : String? ,id_credential: String, completionHandler: ((Bool?, PaybookError?) -> ())?){
        
        let url = "https://sync.paybook.com/v1/credentials/\(id_credential)"
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
            
            self.call("DELETE", endpoint: url, parameters: data, authenticate: authenticate,completionHandler: {
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
    open class func get(_ session: Session?,id_user: String?, completionHandler: (([Credentials]?, PaybookError?) -> ())?){
        
        let url = "https://sync.paybook.com/v1/credentials"
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
            
            self.call("GET", endpoint: url, parameters: data, authenticate: authenticate,completionHandler: {
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
