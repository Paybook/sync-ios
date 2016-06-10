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

    @IBOutlet weak var username: UITextField!
    
    @IBOutlet weak var password: UITextField!
    
    @IBAction func Test(sender: AnyObject) {
        var mySession = Session(id_user: username.text!)
        
        mySession.create() {
            responseObject , error in
            print("responseObject = \(responseObject); error = \(error)")
            return
        }
       
    }
    
    func textViewDidEndEditing(textView: UITextView) {
        textView.endEditing(true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        User.get_all() {
            responseObject , error in
            print("responseObject = \(responseObject); error = \(error)")
            return
        }
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

