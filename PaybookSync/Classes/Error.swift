//
//  Error.swift
//  Pods
//
//  Created by Gabriel Villarreal on 23/06/16.
//
//

import Foundation


open class PaybookError: NSObject {
    
    open var code : Int
    open var message : String!
    open var response : NSDictionary!
    open var status : Bool
    
    
    
    public init?(code : Int, message: String?, response: NSDictionary?, status: Bool ) {
        self.code = code
        self.message = message
        self.response = response
        self.status = status
    }
    
    override open var description : String {
        return "**** Error: [\n   code : \(self.code),\n  status : \(self.status),\n  message : \(self.message)]"
    }
    
    override open var debugDescription : String {
        return  "**** Error: [\n   code : \(self.code),\n  status : \(self.status),\n  message : \(self.message)]"
    }
   
    
}

