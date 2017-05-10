//
//  Attachments.swift
//  Pods
//
//  Created by Gabriel Villarreal on 22/06/16.
//
//

import Foundation

open class Attachments : Paybook {
    
    open var id_attachment : String!
    open var id_account : String!
    open var id_external : String!
    open var id_user : String!
    open var id_attachment_type : String!
    open var id_transaction : String!
    open var is_valid : Bool!
    open var file : String!
    open var extra : String!
    open var url : String!
    open var mime : String!
    open var dt_refresh : Int!
   
    
    // Attachments
    convenience init (dict: NSDictionary){
        self.init()
        self.id_attachment = dict["id_attachment"] as? String
        self.id_account = dict["id_transaction"] as? String
        self.mime = dict["mime"] as? String
        self.is_valid = dict["is_valid"] as? Bool
        self.id_external = dict["id_external"] as? String
        self.id_user = dict["id_user"] as? String
        self.id_attachment_type = dict["id_attachment_type"] as? String
        self.id_transaction = dict["id_transaction"] as? String
        self.file = dict["file"] as? String
        self.extra = dict["extra"] as? String
        self.url = dict["url"] as? String
        self.dt_refresh = dict["dt_refresh"] as? Int
        
    }
    
    
    
    
    // ** MARK Class Methods
    
    // Return (Int) # Attachments in completionHandler
    /** Example to get number of Attachments
     
     Attachments.get_count([mySession], id_user: nil, completionHandler: {
     response, error in
     print("# transaction: \(response), \(error)")
     })
     */
    
    open class func get_count( _ session : Session?,id_user : String? , completionHandler: ((Int?, PaybookError?) -> ())?){
        
        let url = "https://sync.paybook.com/v1/attachments/count"
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
            
            
            self.call("GET", endpoint: url, parameters: data, authenticate: authenticate, completionHandler: {
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
    
    
    
    
    
    // Return ([Attachments]) # Attachments in completionHandler
    /** Example to get Attachments
     
     Attachments.get([mySession], id_user: nil, completionHandler: {
     response, error in
     print("array: \(response), \(error)")
     })
     */
    
    open class func get(_ session: Session?,id_user: String?, completionHandler: (([Attachments]?, PaybookError?) -> ())?){
        
        
        let url = "https://sync.paybook.com/v1/attachments"
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
            
            self.call("GET", endpoint: url, parameters: data, authenticate: authenticate, completionHandler: {
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
    
    
    
    
    
    // Return ([Attachments]) # Attachments in completionHandler
    /** Example to get Attachments
     
     Attachments.get([mySession], id_user: nil, completionHandler: {
     response, error in
     print("array: \(response), \(error)")
     })
     */
    
    open class func get(_ session: Session?,id_user: String?,options: [String:AnyObject] ,completionHandler: (([Attachments]?, PaybookError?) -> ())?){
        
        
        let url = "https://sync.paybook.com/v1/attachments"
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
    

    
    
    
    
    
    // Return (NSDictionary) in completionHandler
    /** Example to get Attachments
     
     Attachments.get([mySession], id_user: nil,id_attachment: [id_attachment] completionHandler: {
        response, error in
        print("array: \(response), \(error)")
     })
     
     
     Example response: 
     
     response = [
        destination     : "file_path",
        mime            : "application/pdf"
     ]
     */
    open class func get(_ session: Session?,id_user: String?, id_attachment: String ,completionHandler: ((NSDictionary?, PaybookError?) -> ())?){
        
        
        let url = "https://sync.paybook.com/v1/attachments/\(id_attachment)"
        
        var data = ["id_attachment": id_attachment,
                    "token": ["token" : session!.token]
        ] as [String : Any]
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
            
            
            
            
            self.call("GET", endpoint: url, parameters: nil, authenticate: authenticate,completionHandler: {
                response, error in
                if response != nil {
                    if completionHandler != nil {
                        completionHandler!(response!,error)
                    }
                }else{
                    if completionHandler != nil {
                        completionHandler!(nil,error)
                    }
                }


            })
            
        }
        
        
    }

    open class func get(_ session: Session?,id_user: String?, id_attachment: String, extra: Bool ,completionHandler: ((NSDictionary?, PaybookError?) -> ())?){
        
        
        let url = "https://sync.paybook.com/v1/attachments/\(id_attachment)/extra"
        var data = ["id_attachment": id_attachment,
                    "token": ["token" : session!.token]
                    ] as [String : Any]
        
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
            
            /*
            self.get_file("GET", endpoint: url, parameters: data, authenticate: authenticate, completionHandler: { (response, error) in
                
            })
            */
            
            self.call("GET", endpoint: url, parameters: nil, authenticate: authenticate,completionHandler: {
                response, error in
                if response != nil {
                    if completionHandler != nil {
                        completionHandler!(response!["response"] as? NSDictionary,error)
                    }
                }else{
                    if completionHandler != nil {
                        completionHandler!(nil,error)
                    }
                }
                
                
            })
            
        }
        
        
    }
    
    
    
    
    
    
    
    
    
    
    // Return (Dictionary [String:AnyObject])
    /** Example to get options
     
     var dict = Attachments.get_options()
     
     //Example response:
     dict = [
        "id_account" :	"String"                    //Filters by account ID.
        "id_attachment_type" :	"String"            //Attachment Type ID.
        "id_credential" : "String"                  //Credential ID.
        "id_transaction" :	"String"                //Transaction ID.
        "is_valid" : "Number"                       //Is attachment valid.
        "dt_refresh_from" :	"Timestamp"             //Filters by transaction refresh date, expected UNIX timestamp.
        "dt_refresh_to" :	"Timestamp"             //Filters by transaction refresh date, expected UNIX timestamp.
        "fields" :	"String"                        //Select fields to be returned.
        "limit" :	"Number"                        //Limit the number of rows to be returned.
        "skip" :	"Number"                        //Skip rows to be returned.
        "order" :	"String"                        //Order the rows to be returned.
     ]
     */

    open class func get_options() -> [String:String]{
        
        let dict  = [
            "id_account" :	"String",                   //Filters by account ID.
            "id_attachment_type" :	"String",           //Attachment Type ID.
            "id_credential" : "String",                 //Credential ID.
            "id_transaction" :	"String" ,               //Transaction ID.
            "is_valid" : "Number",                      //Is attachment valid.
            "dt_refresh_from" :	"Timestamp",            //Filters by transaction refresh date, expected UNIX timestamp.
            "dt_refresh_to" :	"Timestamp",            //Filters by transaction refresh date, expected UNIX timestamp.
            "fields" :	"String",                       //Select fields to be returned.
            "limit" :	"Number",                       //Limit the number of rows to be returned.
            "skip" :	"Number",                       //Skip rows to be returned.
            "order" :	"String"                        //Order the rows to be returned.
        ]
        
        return dict
    }
    
    
}
