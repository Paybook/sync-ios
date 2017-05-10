//
//  Paybook.swift
//  Pods
//
//  Created by Gabriel Villarreal on 10/06/16.
//
//

import Foundation
import Alamofire

open class Paybook {
    
    open static var api_key = "[your_API_key]"
    static let baseURLString = "https://sync.paybook.com/v1/"
    
    
    public init(){
        
    }
    

    // ** MARK Class Methods
    
    open class func call (_ method: String, endpoint: String, parameters: [String:AnyObject]?,authenticate: [String:String]?,completionHandler: ((NSDictionary?, PaybookError?) -> ())?){
        
       
        var headers : [String:String] = [
            "Authorization" : "API_KEY api_key=\(api_key)",
            "Content-Type": "application/json; charset=utf-8"
        ]
        
        if(authenticate != nil){
            if authenticate!["token"] != nil {
                
                headers = [
                    "Authorization" : "TOKEN token=\(authenticate!["token"]!)",
                    "Content-Type": "application/json; charset=utf-8"
                ]
                
                
            }else if authenticate!["id_user"] != nil {
                headers = [
                    "Authorization" : "API_KEY api_key=\(api_key),id_user=\(authenticate!["id_user"]!)",
                    "Content-Type": "application/json; charset=utf-8"
                ]
                
            }
        }
        
        let url = endpoint
        let data = parameters
        
        
        
        switch method {
        case "GET" :
           
            
            Alamofire.request(url, method: .get, parameters: data, encoding: JSONEncoding.default , headers: headers).responseJSON { response in
                switch response.result {
                case .success(let value):
                    
                    let resp = value as AnyObject
                    
                    if resp.value(forKey: "code") as! Int == 200 {
                        
                        if(completionHandler != nil){
                            completionHandler!(value as? NSDictionary, nil)
                        }
                    }else{
                        if(completionHandler != nil){
                            let error = PaybookError(code: resp.value(forKey: "code") as! Int, message: resp.value(forKey: "message") as? String, response: resp.value(forKey: "response") as? NSDictionary, status: resp.value(forKey: "status") as! Bool)
                            completionHandler!(nil, error)
                        }
                    }
                    
                case .failure(let error):
                    
                    let perror = PaybookError(code: 400, message: error.localizedDescription, response:nil, status: false)
                    if(completionHandler != nil){
                        completionHandler!(nil, perror)
                    }
                }
                
                }

            
            break
        case "POST" :
            
            
            Alamofire.request(url, method: .post, parameters: data, encoding: JSONEncoding.default , headers: headers).responseJSON { response in
                switch response.result {
                case .success(let value):
                    
                    let resp = value as AnyObject
                    
                    if resp.value(forKey: "code") as! Int == 200 {
                        
                        if(completionHandler != nil){
                            completionHandler!(value as? NSDictionary, nil)
                        }
                    }else{
                        if(completionHandler != nil){
                            let error = PaybookError(code: resp.value(forKey: "code") as! Int, message: resp.value(forKey: "message") as? String, response: resp.value(forKey: "response") as? NSDictionary, status: resp.value(forKey: "status") as! Bool)
                            completionHandler!(nil, error)
                        }
                    }
                    
                case .failure(let error):
                    
                    let perror = PaybookError(code: 400, message: error.localizedDescription, response:nil, status: false)
                    if(completionHandler != nil){
                        completionHandler!(nil, perror)
                    }
                }
                
            }
            
            break
        case "DELETE" :
            Alamofire.request(url, method: .delete, parameters: data, encoding: JSONEncoding.default , headers: headers).responseJSON { response in
                switch response.result {
                case .success(let value):
                    
                    let resp = value as AnyObject
                    
                    if resp.value(forKey: "code") as! Int == 200 {
                        
                        if(completionHandler != nil){
                            completionHandler!(value as? NSDictionary, nil)
                        }
                    }else{
                        if(completionHandler != nil){
                            let error = PaybookError(code: resp.value(forKey: "code") as! Int, message: resp.value(forKey: "message") as? String, response: resp.value(forKey: "response") as? NSDictionary, status: resp.value(forKey: "status") as! Bool)
                            completionHandler!(nil, error)
                        }
                    }
                case .failure(let error):
                    
                    let perror = PaybookError(code: 400, message: error.localizedDescription, response:nil, status: false)
                    if(completionHandler != nil){
                        completionHandler!(nil, perror)
                    }
                }
                
            }
            break
        default :
            break
        }
        
        
        
        
    }
    
    /*
    open class func get_file (_ method: String, endpoint: String, parameters: NSDictionary?,authenticate: NSDictionary?, completionHandler: ((NSDictionary?, PaybookError?) -> ())?){
        var data = [String: AnyObject]()
        
        
        var headers : [String:String] = [
            "Authorization" : "API_KEY api_key=\(api_key)",
            "Content-Type": "application/json; charset=utf-8"
        ]
        
        if(authenticate != nil){
            if authenticate!["token"] != nil {
                
                headers = [
                    "Authorization" : "TOKEN token=\(authenticate!["token"]!)",
                    "Content-Type": "application/json; charset=utf-8"
                ]
                
                
            }else if authenticate!["id_user"] != nil {
                headers = [
                    "Authorization" : "API_KEY api_key=\(api_key),id_user=\(authenticate!["id_user"]!)",
                    "Content-Type": "application/json; charset=utf-8"
                ]
                
            }
        }
        let url = endpoint
        
        switch method {
        case "GET" :
           
            var localPath: URL?
            
            Alamofire.request(url, method: .post, parameters: data, encoding: JSONEncoding.default , headers: headers).responseJSON { response in
                switch response.result {
                case .success(let value):
                    
                    if(completionHandler != nil){
                        completionHandler!(value as? NSDictionary, nil)
                    }
                    
                case .failure(let error):
                    
                    let perror = PaybookError(code: 400, message: error.localizedDescription, response:nil, status: false)
                    if(completionHandler != nil){
                        completionHandler!(nil, perror)
                    }
                }
                
            }
            Alamofire.request(url, method: .get, parameters: data, encoding: JSONEncoding.default , headers: headers).response { request, response, _, error in
                
                if response?.statusCode == 200 {
                    
                    
                    Alamofire.download(.GET, url,parameters: data, destination: { (temporaryURL, response) in
                        let directoryURL = NSFileManager.defaultManager().URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask)[0]
                        let pathComponent = response.suggestedFilename
                        
                        localPath = directoryURL.URLByAppendingPathComponent(pathComponent!)
                        return localPath!
                    }).validate().response { (request, response, _, error) in
                        
                        
                        
                        if response?.statusCode >=  200 && response?.statusCode < 300 {
                            if let mime = response?.MIMEType {
                                if(completionHandler != nil){
                                    completionHandler!(
                                        ["destination": localPath!,"mime": mime], nil)
                                }
                            }else{
                                if(completionHandler != nil){
                                    completionHandler!(
                                        ["destination": localPath!], nil)
                                }
                            }
                            
                            
                        }else{
                            
                            if(completionHandler != nil){
                                let paybookError = PaybookError(code: (response?.statusCode)!, message: error?.description, response: nil, status: false)
                                completionHandler!(nil, paybookError)
                            }
                        }
                        
                        
                    }
                }else{
                    
                    if(completionHandler != nil){
                        let paybookError = PaybookError(code: (response?.statusCode)!, message: error?.description, response: nil, status: false)
                        completionHandler!(nil, paybookError)
                    }
                }
                
            
                
            }
 
           
            
            break
        case "POST" :
            var localPath: URL?
            Alamofire.request(.POST, url, parameters: data, encoding: .JSON,headers: headers).response { request, response, _, error in
                
                if response?.statusCode == 200 {
                    Alamofire.download(.POST, url,parameters: data, destination: { (temporaryURL, response) in
                        let directoryURL = NSFileManager.defaultManager().URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask)[0]
                        let pathComponent = response.suggestedFilename
                        
                        localPath = directoryURL.URLByAppendingPathComponent(pathComponent!)
                        return localPath!
                    }).validate().response { (request, response, _, error) in
                     
                        if response?.statusCode >=  200 && response?.statusCode < 300 {
                            if let mime = response?.MIMEType {
                                if(completionHandler != nil){
                                    completionHandler!(
                                        ["destination": localPath!,"mime": mime], nil)
                                }
                            }else{
                                if(completionHandler != nil){
                                    completionHandler!(
                                        ["destination": localPath!], nil)
                                }
                            }
                        }else{
                            
                            if(completionHandler != nil){
                                let paybookError = PaybookError(code: (response?.statusCode)!, message: error?.description, response: nil, status: false)
                                completionHandler!(nil, paybookError)
                            }
                        }
                        
                        
                    }
                }else{
                    
                    if(completionHandler != nil){
                        let paybookError = PaybookError(code: (response?.statusCode)!, message: error?.description, response: nil, status: false)
                        completionHandler!(nil, paybookError)
                    }
                }
                
            }
            
            
            break
        default :
            break
        }
        
        
        
        
    }
 
 */
    
}




extension Dictionary {
    mutating func update(_ other:Dictionary) {
        for (key,value) in other {
            self.updateValue(value, forKey:key)
        }
    }

}

