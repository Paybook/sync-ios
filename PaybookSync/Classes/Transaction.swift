//
//  Transaction.swift
//  Pods
//
//  Created by Gabriel Villarreal on 10/06/16.
//
//

import Foundation


class Transaction : Paybook {
    
    var id_transaction : String
    var id_user : String
    var id_external : String
    var id_site : String
    var id_site_organization : String!
    var id_site_organization_type : String!
    var id_account : String!
    var id_account_type : String!
    var is_disable : String!
    var description : String!
    var amount : float
    var dt_transaction : String!
    var dt_refresh : String!
    
    
    
    
    // Transaction
    convenience init (dict: NSDictionary){
        self.id_transaction = dict["id_transaction"]
        self.id_user = dict["id_transaction"]
        self.id_external = dict["id_transaction"]
        self.id_site = dict["id_transaction"]
        self.id_site_organization = dict["id_transaction"]
        self.id_site_organization_type = dict["id_transaction"]
        self.id_account = dict["id_transaction"]
        self.id_account_type = dict["id_transaction"]
        self.is_disable = dict["id_transaction"]
        self.description = dict["id_transaction"]
        self.amount = dict["id_transaction"]
        self.dt_transaction = dict["id_transaction"]
        self.dt_refresh = dict["id_transaction"]
    }
    
    
    
    
    // ** MARK Class Methods
    
    // # transactions Integer
    public class func get_count( session : Session,id_user : String ,id_credential: String){
        
    }
    
    // [Transaction]
    public class func get(session: Session,id_user: String){
        
    }
    
    
    
    
}