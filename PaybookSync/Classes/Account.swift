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
    public var dt_refresh : String!
    
    
    
    
    
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
        self.balance = dict["balance"] as! Double
        self.site = dict["site"] as? String
        self.dt_refresh = dict["dt_refresh"] as? String
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
    
    
    
    
}