//
//  Transaction.swift
//  Pods
//
//  Created by Gabriel Villarreal on 10/06/16.
//
//

import Foundation


open class Transaction : Paybook {
    
    open var id_transaction : String!
    open var id_user : String!
    open var id_external : String!
    open var id_site : String!
    open var id_site_organization : String!
    open var id_site_organization_type : String!
    open var id_account : String!
    open var id_account_type : String!
    open var is_disable : Bool!
    open var description : String!
    open var amount : Double = 0.0
    open var dt_transaction : Int!
    open var dt_refresh : Int!
    
    
    
    
    // Transaction
    convenience init (dict: NSDictionary){
        self.init()
        self.id_transaction = dict["id_transaction"] as? String
        self.id_user = dict["id_user"] as? String
        self.id_external = dict["id_external"] as? String
        self.id_site = dict["id_site"] as? String
        self.id_site_organization = dict["id_site_organization"] as? String
        self.id_site_organization_type = dict["id_site_organization_type"] as? String
        self.id_account = dict["id_account"] as? String
        self.id_account_type = dict["id_account_type"] as? String
        self.is_disable = dict["is_disable"] as? Bool
        self.description = dict["description"] as? String
        self.amount = dict["amount"] as! Double
        self.dt_transaction = dict["dt_transaction"] as! Int
        self.dt_refresh = dict["dt_refresh"] as! Int
    }
    
    
    
    
    // ** MARK Class Methods
    
    // Return (Int) # transactions in completionHandler
    /** Example to get number of transactions
     
     Transaction.get_count([mySession], id_user: nil, completionHandler: {
        response, error in
        print("# transaction: \(response), \(error)")
     })
     */
    
    open class func get_count( _ session : Session?,id_user : String? , completionHandler: ((Int?, PaybookError?) -> ())?){
        
        let url = "https://sync.paybook.com/v1/transactions/count"
        var data = [String: AnyObject]()
        
        if session == nil && id_user == nil{
            if completionHandler != nil {
                completionHandler!(nil,PaybookError(code: 401, message: "Unauthorized", response: nil, status: false))
            }
        }else{
            
            
            var authenticate : [String:String] = [:]
            if session != nil{
                authenticate.update(["token" : session!.token])
            }
            
            if id_user != nil{
                authenticate.update(["id_user": id_user!])
            }
            self.call("GET", endpoint: url, parameters: data,authenticate: authenticate, completionHandler: {
                response, error in
                
                if response != nil {
                    
                    if let responseObject = response!["response"] as? NSDictionary{
                        
                        if completionHandler != nil {
                            completionHandler!(responseObject["count"] as? Int,nil)
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
    
    // Return ([Transaction]) # transactions in completionHandler
    /** Example to get transactions
     
     Transaction.get([mySession], id_user: nil, completionHandler: {
        response, error in
        print("array: \(response), \(error)")
     })
     */
    
    open class func get(_ session: Session?,id_user: String?, completionHandler: (([Transaction]?, PaybookError?) -> ())?){
        
        
        let url = "https://sync.paybook.com/v1/transactions"
        var data = [String: AnyObject]()
        
        if session == nil && id_user == nil{
            if completionHandler != nil {
                completionHandler!(nil,PaybookError(code: 401, message: "Unauthorized", response: nil, status: false))
            }
        }else{
            
            
            var authenticate : [String:String] = [:]
            if session != nil{
                authenticate.update(["token" : session!.token])
            }
            
            if id_user != nil{
                authenticate.update(["id_user": id_user!])
            }
            
            self.call("GET", endpoint: url, parameters: data,authenticate: authenticate ,completionHandler: {
                response, error in
                
                if response != nil {
                    var array = [Transaction]()
                    
                    if let responseArray = response!["response"] as? NSArray{
                        
                        for (value) in responseArray{
                            array.append(Transaction(dict: value as! NSDictionary))
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
    
    
    open class func get(_ session: Session?,id_user: String?, options: [String:AnyObject],completionHandler: (([Transaction]?, PaybookError?) -> ())?){
        
        
        let url = "https://sync.paybook.com/v1/transactions"
        var data = [String: AnyObject]()
        
        if session == nil && id_user == nil{
            if completionHandler != nil {
                completionHandler!(nil,PaybookError(code: 401, message: "Unauthorized", response: nil, status: false))
            }
        }else{
            
            var authenticate : [String:String] = [:]
            if session != nil{
                authenticate.update(["token" : session!.token])
            }
            
            if id_user != nil{
                authenticate.update(["id_user": id_user!])
            }
            data.update(options)
            self.call("GET", endpoint: url, parameters: data, authenticate: authenticate,completionHandler: {
                response, error in
                
                if response != nil {
                    var array = [Transaction]()
                    
                    if let responseArray = response!["response"] as? NSArray{
                        
                        for (value) in responseArray{
                            array.append(Transaction(dict: value as! NSDictionary))
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

    
    open class func get_options() -> [String:String]{
        
        let dict  = [
            "id_account" :	"String" ,                   //Filters by account ID.
            "id_credential" :	"String" ,               //Credentials ID.
            "id_site" :	"String",                       //Filters by site ID.
            "id_site_organization" : "String",       //Filters by site organization ID.
            "id_site_organization_type" :	"String",   //Filters by site organization type ID.
            "is_disable" :	"Number",                   //Filters by disable transaction.
            "dt_refresh_from" :	"Timestamp",            //Filters by transaction refresh date, expected UNIX timestamp.
            "dt_refresh_to" :	"Timestamp",            //Filters by transaction refresh date, expected UNIX timestamp.
            "dt_transaction_from" :	"Timestamp",        //Filters by transaction date, expected UNIX timestamp.
            "dt_transaction_to" :	"Timestamp"         //Filters by transaction date, expected UNIX timestamp.
        ]
        
        return dict
    }
    
    
}
