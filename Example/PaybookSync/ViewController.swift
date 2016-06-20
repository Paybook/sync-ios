//
//  ViewController.swift
//  PaybookSync
//
//  Created by Gabriel Villarreal on 06/06/2016.
//  Copyright (c) 2016 Gabriel Villarreal. All rights reserved.
//

import UIKit
import PaybookSync

class ViewController: UIViewController, UITextViewDelegate {

    
    var vartest : Session!
    
    
    @IBOutlet weak var username: UITextField!
    
    @IBOutlet weak var password: UITextField!
    
    @IBAction func Test(sender: AnyObject) {
        Paybook.api_key = username.text!
        User.get() {
            responseArray , error in
            if responseArray != nil{
                for user in responseArray!{
                    print(user.id_user)
                }
            }
            
            return
        }
       
     
    }
    
    @IBAction func SecondTest(sender: AnyObject) {
       
        _ = Session(id_user: password.text!, completionHandler: {
            session , error in
            print("Session created in API = \(session?.token); error = \(error)")
            
            if session != nil{
                
                Transaction.get(session!, id_user: nil, completionHandler: {
                    response, error in
                    print("array: \(response), \(error)")
                })
            }
            
        })
    }
    
    
    func textViewDidEndEditing(textView: UITextView) {
        textView.endEditing(true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        
        
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

