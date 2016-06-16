//
//  Account.swift
//  Pods
//
//  Created by Gabriel Villarreal on 10/06/16.
//
//

import Foundation



class Transaction : Paybook {
    
    var id_account : String
    var id_external : String
    var id_user : String
    var id_credential : String!
    var id_site : String
    var id_site_organization : String!
    var name : String!
    var number : String!
    var balance : float
    var site : String!
    var dt_refresh : String!
    
    
    
    
    
    // Account
    convenience init (dict: NSDictionary){
        self.id_account = dict["id_account"]
        self.id_external = dict["id_external"]
        self.id_user = dict["id_user"]
        self.id_credential = dict["id_credential"]
        self.id_site = dict["id_site"]
        self.id_site_organization = dict["id_site_organization"]
        self.name = dict["name"]
        self.number = dict["number"]
        self.balance = dict["balance"]
        self.site = dict["site"]
        self.dt_refresh = dict["dt_refresh"]
    }
    
    
    
    // ** MARK Class Methods
    
    
    // [Transaction]
    public class func get(session: Session,id_user: String){
        
    }
    
    
    
    
}