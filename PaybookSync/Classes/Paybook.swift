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
    
    public class func call (method: String, endpoint: String, parameters: NSDictionary?, completionHandler: ((NSDictionary?, PaybookError?) -> ())?){
        var data : [String: AnyObject] = ["api_key" : api_key]
        
        if(parameters != nil){
            // Add parameters in request data
            data.update(parameters as! Dictionary<String, AnyObject>)
        }
        
        
        //let url = "\(baseURLString)\(endpoint)"
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
    
    
    
}


extension Dictionary {
    mutating func update(other:Dictionary) {
        for (key,value) in other {
            self.updateValue(value, forKey:key)
        }
    }
}

