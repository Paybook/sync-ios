//
//  Attachments.swift
//  Pods
//
//  Created by Gabriel Villarreal on 22/06/16.
//
//

import Foundation

public class Attachments : Paybook {
    
    public var id_account : String!
    public var id_external : String!
    public var id_user : String!
    public var id_attachment_type : String!
    public var id_transaction : String!
    public var file : String!
    public var extra : String!
    public var url : String!
    public var dt_refresh : String!
   
    
    // Attachments
    convenience init (dict: NSDictionary){
        self.init()
        
        self.id_account = dict["id_transaction"] as? String
        self.id_external = dict["id_external"] as? String
        self.id_user = dict["id_user"] as? String
        self.id_attachment_type = dict["id_attachment_type"] as? String
        self.id_transaction = dict["id_transaction"] as? String
        self.file = dict["file"] as? String
        self.extra = dict["extra"] as? String
        self.url = dict["url"] as? String
        self.dt_refresh = dict["dt_refresh"] as? String
        
    }
    
    
    
    
    // ** MARK Class Methods
    
    // Return (Int) # Attachments in completionHandler
    /** Example to get number of Attachments
     
     Attachments.get_count([mySession], id_user: nil, completionHandler: {
     response, error in
     print("# transaction: \(response), \(error)")
     })
     */
    
    public class func get_count( session : Session,id_user : String? , completionHandler: ((Int?, PaybookError?) -> ())?){
        
        let url = "https://sync.paybook.com/v1/attachments/count"
        let data = [
            "token" : session.token
        ]
        
        self.call("GET", endpoint: url, parameters: data, completionHandler: {
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
    
    // Return ([Attachments]) # Attachments in completionHandler
    /** Example to get Attachments
     
     Attachments.get([mySession], id_user: nil, completionHandler: {
     response, error in
     print("array: \(response), \(error)")
     })
     */
    
    public class func get(session: Session,id_user: String?, completionHandler: (([Attachments]?, PaybookError?) -> ())?){
        
        
        let url = "https://sync.paybook.com/v1/attachments"
        let data = [
            "token" : session.token
        ]
        
        self.call("GET", endpoint: url, parameters: data, completionHandler: {
            response, error in
            
            if response != nil {
                var array = [Attachments]()
                
                if let responseArray = response!["response"] as? NSArray{
                    
                    for (value) in responseArray{
                        array.append(Attachments(dict: value as! NSDictionary))
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