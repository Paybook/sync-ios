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
        
        _ = Session(id_user: username.text!, completionHandler: {
            session , error in
            self.vartest = session
            print("Session created in API = \(session?.token); error = \(error)")
        })
     
    }
    
    @IBAction func SecondTest(sender: AnyObject) {
       
        
        
    }
    
    
    func textViewDidEndEditing(textView: UITextView) {
        textView.endEditing(true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        User.get() {
            userArray , error in
            
            if userArray != nil{
                for value in userArray!{
                    print("\(value.name) : \(value.id_user)")
                }
            }
            
            
            
            return
        }
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

