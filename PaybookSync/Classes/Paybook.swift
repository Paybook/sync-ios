//
//  Paybook.swift
//  Pods
//
//  Created by Gabriel Villarreal on 10/06/16.
//
//

import Foundation
import Alamofire

public class Paybook {
    
    public static var api_key = "[your_API_key]"
    static let baseURLString = "https://sync.paybook.com/v1/"
    
    
    public init(){
        
    }
    

    // ** MARK Class Methods
    
    public class func call (method: String, endpoint: String, parameters: NSDictionary?,completionHandler: ((NSDictionary?, PaybookError?) -> ())?){
        var data = [String: AnyObject]()
        if(parameters != nil){
            if parameters!["token"] != nil {
                data = (parameters as? [String: AnyObject])!
            }else{
                data = ["api_key" : api_key]
                // Add parameters in request data
                data.update(parameters as! Dictionary<String, AnyObject>)
            }
        }else{
            data = ["api_key" : api_key]
        }
        
        let url = endpoint
        
        switch method {
        case "GET" :
            
            
            Alamofire.request(.GET, url, parameters: data, encoding: .JSON , headers: ["Content-Type": "application/json; charset=utf-8"]).responseJSON { response in
                switch response.result {
                case .Success(let value):
                    
                    if value["code"] as! Int == 200 {
                        
                        if(completionHandler != nil){
                            completionHandler!(value as? NSDictionary, nil)
                        }
                    }else{
                        if(completionHandler != nil){
                            let error = PaybookError(code: value["code"] as! Int, message: value["message"] as? String, response: value["status"] as? NSDictionary, status: value["status"] as! Bool)
                            completionHandler!(nil, error)
                        }
                    }
                    
                case .Failure(let error):
                    let perror = PaybookError(code: error.code, message: error.description, response:nil, status: false)
                    if(completionHandler != nil){
                        completionHandler!(nil, perror)
                    }
                }
                
                }

            
            break
        case "POST" :
            Alamofire.request(.POST, url, parameters: data, encoding: .JSON , headers: ["Content-Type": "application/json; charset=utf-8"]).responseJSON { response in
                switch response.result {
                case .Success(let value):
                    
                    if value["code"] as! Int == 200 {
                        
                        if(completionHandler != nil){
                            completionHandler!(value as? NSDictionary, nil)
                        }
                    }else{
                        if(completionHandler != nil){
                            let error = PaybookError(code: value["code"] as! Int, message: value["message"] as? String, response: value["status"] as? NSDictionary, status: value["status"] as! Bool)
                            completionHandler!(nil, error)
                        }
                    }
                    
                case .Failure(let error):
                    let perror = PaybookError(code: error.code, message: error.description, response:nil, status: false)
                    if(completionHandler != nil){
                        completionHandler!(nil, perror)
                    }
                }
            }
            break
        case "DELETE" :
            Alamofire.request(.DELETE, url, parameters: data, encoding: .JSON , headers: ["Content-Type": "application/json; charset=utf-8"]).responseJSON { response in
                switch response.result {
                case .Success(let value):
                    
                    if value["code"] as! Int == 200 {
                        
                        if(completionHandler != nil){
                            completionHandler!(value as? NSDictionary, nil)
                        }
                    }else{
                        if(completionHandler != nil){
                            let error = PaybookError(code: value["code"] as! Int, message: value["message"] as? String, response: value["status"] as? NSDictionary, status: value["status"] as! Bool)
                            completionHandler!(nil, error)
                        }
                    }
                    
                case .Failure(let error):
                    let perror = PaybookError(code: error.code, message: error.description, response:nil, status: false)
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
    
    
    public class func get_file (method: String, endpoint: String, parameters: NSDictionary?,completionHandler: ((NSDictionary?, PaybookError?) -> ())?){
        var data = [String: AnyObject]()
        if(parameters != nil){
            if parameters!["token"] != nil {
                data = (parameters as? [String: AnyObject])!
            }else{
                data = ["api_key" : api_key]
                // Add parameters in request data
                data.update(parameters as! Dictionary<String, AnyObject>)
            }
        }else{
            data = ["api_key" : api_key]
        }
        
        let url = endpoint
        
        switch method {
        case "GET" :
           
            var localPath: NSURL?
            
            Alamofire.request(.GET, url, parameters: data, encoding: .JSON).response { request, response, _, error in
                
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
            var localPath: NSURL?
            Alamofire.request(.POST, url, parameters: data, encoding: .JSON).response { request, response, _, error in
                
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
    
}




extension Dictionary {
    mutating func update(other:Dictionary) {
        for (key,value) in other {
            self.updateValue(value, forKey:key)
        }
    }

}

