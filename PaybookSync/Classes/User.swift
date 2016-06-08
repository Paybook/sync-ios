//
//  User.swift
//  Pods
//
//  Created by Gabriel Villarreal on 06/06/16.
//
//

import Foundation

public class PaybookUser {
    
    public var id_user : String
    public var id_external : String!
    public var name : String
    public var dt_create : NSDate!
    public var dt_modify : NSDate!
    
    public init (id_user : String, id_external: String?, name: String, dt_create: NSDate, dt_modify: NSDate){
       
        self.id_user = id_user
        self.id_external = id_external
        self.name = name
        self.dt_create = dt_create
        self.dt_modify = dt_modify
        
        
    }
    
}



public class ListItem {
    
    // Public properties.
    public var text: String
    public var isComplete: Bool
    
    // Readable throughout the module, but only writeable from within this file.
    private(set) var UUID: NSUUID
    
    public init(text: String, completed: Bool, UUID: NSUUID) {
        self.text = text
        self.isComplete = completed
        self.UUID = UUID
    }
    
    // Usable within the framework target, but not by other targets.
    func refreshIdentity() {
        self.UUID = NSUUID()
    }
    
    
}