//
//  Error.swift
//  Pods
//
//  Created by Gabriel Villarreal on 23/06/16.
//
//

import Foundation


public class PaybookError {
    
    public var code : Int
    public var message : String!
    public var response : NSDictionary!
    public var status : Bool
    
    
    
    public init?(code : Int, message: String?, response: NSDictionary?, status: Bool ) {
        self.code = code
        self.message = message
        self.response = response
        self.status = status
    }
   
    
}

