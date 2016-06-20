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
    
    static let api_key = "[your_API_key]"
    static let baseURLString = "https://sync.paybook.com/v1/"
    
    public init(){
        
    }
    
    convenience public init(api_key: String){
        self.init()
    }
    
    
    
    
    // ** MARK Class Methods
    
    public class func call (method: String, endpoint: String, parameters: NSDictionary?, completionHandler: ((NSDictionary?, NSError?) -> ())?){
        var data : [String: AnyObject] = ["api_key" : api_key]
        
        if(parameters != nil){
            // Add parameters in request data
            data.update(parameters as! Dictionary<String, AnyObject>)
        }
        print(data)
        
        
        let url = "\(baseURLString)\(endpoint)"
        
        
        switch method {
        case "GET" :
            Alamofire.request(.GET, url, parameters: data, encoding: .JSON , headers: ["Content-Type": "application/json; charset=utf-8"]).responseJSON { response in
                switch response.result {
                case .Success(let value):
                    if(completionHandler != nil){
                        completionHandler!(value as? NSDictionary, nil)
                    }
                case .Failure(let error):
                    if(completionHandler != nil){
                        completionHandler!(nil, error)
                    }
                }
            }
            
            break
        case "POST" :
            Alamofire.request(.POST, url, parameters: data, encoding: .JSON , headers: ["Content-Type": "application/json; charset=utf-8"]).responseJSON { response in
                switch response.result {
                case .Success(let value):
                    if(completionHandler != nil){
                        completionHandler!(value as? NSDictionary, nil)
                    }
                case .Failure(let error):
                    if(completionHandler != nil){
                        completionHandler!(nil, error)
                    }
                }
            }
            break
        case "DELETE" :
            Alamofire.request(.DELETE, url, parameters: data, encoding: .JSON , headers: ["Content-Type": "application/json; charset=utf-8"]).responseJSON { response in
                switch response.result {
                case .Success(let value):
                    if(completionHandler != nil){
                        completionHandler!(value as? NSDictionary, nil)
                    }
                case .Failure(let error):
                    if(completionHandler != nil){
                        completionHandler!(nil, error)
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

