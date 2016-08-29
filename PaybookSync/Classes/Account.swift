//
//  Account.swift
//  Pods
//
//  Created by Gabriel Villarreal on 10/06/16.
//
//

import Foundation


public class Account : Paybook {
    
    public var id_account : String!
    public var id_external : String!
    public var id_user : String!
    public var id_credential : String!
    public var id_site : String!
    public var id_site_organization : String!
    public var name : String!
    public var number : String!
    public var balance : Double = 0.0
    public var site : String!
    public var dt_refresh : Int!
    
    
    
    
    
    // ** MARK Convenince Init
    
    convenience init (dict: NSDictionary){
        self.init()
        self.id_account = dict["id_account"] as? String
        self.id_external = dict["id_external"] as? String
        self.id_user = dict["id_user"] as? String
        self.id_credential = dict["id_credential"] as? String
        self.id_site = dict["id_site"] as? String
        self.id_site_organization = dict["id_site_organization"] as? String
        self.name = dict["name"] as? String
        self.number = dict["number"] as? String
        
        self.site = dict["site"] as? String
        self.dt_refresh = dict["dt_refresh"] as? Int
        
        if let balance = dict["balance"] as? Double{
            self.balance = balance
        }else{
            self.balance = 0
        }
    }
    
    
    
    // ** MARK Class Methods
    
    
    // Return ([Account],NSError) in completionHandler 
    /** Example to get accounts
     
     Account.get([mySession], id_user: nil, completionHandler: {
        response, error in
        print("\(response), \(error)")
     })
     */
    
    public class func get(session: Session?,id_user: String?, completionHandler: (([Account]?, PaybookError?) -> ())?){
        
        let url = "https://sync.paybook.com/v1/accounts"
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
                    var array = [Account]()
                    
                    if let responseArray = response!["response"] as? NSArray{
                        
                        for (value) in responseArray{
                            array.append(Account(dict: value as! NSDictionary))
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
    
    
    
    // ** MARK Class Methods
    
    
    // Return ([Account],NSError) in completionHandler
    /** Example to get accounts
     
     Account.get(<mySession>, id_user: nil,options: <account_options> ,completionHandler: {
     response, error in
     print("\(response), \(error)")
     })
     */
    
    public class func get(session: Session?,id_user: String?,options: [String:AnyObject],completionHandler: (([Account]?, PaybookError?) -> ())?){
        
        let url = "https://sync.paybook.com/v1/accounts"
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
            
            
            data.update(options)
            
            
            self.call("GET", endpoint: url, parameters: data, completionHandler: {
                response, error in
                
                if response != nil {
                    var array = [Account]()
                    
                    if let responseArray = response!["response"] as? NSArray{
                        
                        for (value) in responseArray{
                            array.append(Account(dict: value as! NSDictionary))
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
    
    
    
   
    
    public class func get_options() -> [String:AnyObject]{
        
        
        let dict : [String:AnyObject] = [
            "id_account" :	"String",               //Account ID.
            "id_credential" :	"String",           //Credentials ID.
            "id_site" :	"String",                   //Site ID.
            "id_site_organization" : "String",      //Site Organization ID.
            "id_site_organization_type" : "String", //Site Organization Type ID.
            "fields" :	"String",                   //Select fields to be returned.
            "limit" : "Int",                        //Limit the number of rows to be returned.
            "skip" : "Int",                         //Skip rows to be returned.
            "order" : "String"                      //Order the rows to be returned.
        ]
 
        return dict
    }
    
    
}