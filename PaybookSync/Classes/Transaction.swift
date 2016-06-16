//
//  Transaction.swift
//  Pods
//
//  Created by Gabriel Villarreal on 10/06/16.
//
//

import Foundation


class Transaction : Paybook {
    
    var id_transaction : String!
    var id_user : String!
    var id_external : String!
    var id_site : String!
    var id_site_organization : String!
    var id_site_organization_type : String!
    var id_account : String!
    var id_account_type : String!
    var is_disable : String!
    var description : String!
    var amount : Double = 0.0
    var dt_transaction : String!
    var dt_refresh : String!
    
    
    
    
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
        self.is_disable = dict["is_disable"] as? String
        self.description = dict["description"] as? String
        self.amount = dict["amount"] as! Double
        self.dt_transaction = dict["dt_transaction"] as? String
        self.dt_refresh = dict["dt_refresh"] as? String
    }
    
    
    
    
    // ** MARK Class Methods
    
    // # transactions Integer
    public class func get_count( session : Session,id_user : String ,id_credential: String){
        
    }
    
    // [Transaction]
    public class func get(session: Session,id_user: String){
        
    }
    
    
    
    
}