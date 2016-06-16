//
//  Catalogues.swift
//  Pods
//
//  Created by Gabriel Villarreal on 16/06/16.
//
//

import Foundation

// ** MARK Class Structures


struct Account_type {
    var id_account_type : String
    var name : String
}

struct Attachment_type {
    var id_attachment_type : String
    var name : String
}

struct Country {
    var id_country : String
    var name : String
    var code : String
}

struct Site {
    var id_site : String
    var id_site_organization : String
    var id_site_organization_type : String
    var name : String
    var credentials : NSArray
}

struct Credential_structure {
    var name : String
    var type : String
    var label : String
    var required : Bool
    var username : String
}

struct Site_organization {
    var id_site_organization : String
    var id_site_organization_type : String
    var id_country : String
    var name : String
    var avatar : String
    var small_cover : String
    var cover : String
}



class Catalogues : Paybook {
    
    
    
    // ** MARK Class Methods
    
    
    // [Account_type]
    public class func get_account_types(session: Session,id_user: String){
        
    }

    // [Attachment_type]
    public class func get_attachment_types(session: Session,id_user: String){
        
    }
    
    // [Country]
    public class func get_countries(session: Session,id_user: String){
        
    }
    
    // [Site]
    public class func get_sites(session: Session,id_user: String){
        
    }
    
    // [Site_organization]
    public class func get_site_organizations(session: Session,id_user: String){
        
    }
    
    
    
    
}