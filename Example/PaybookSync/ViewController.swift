//
//  ViewController.swift
//  PaybookSync
//
//  Created by Gabriel Villarreal on 06/06/2016.
//  Copyright (c) 2016 Gabriel Villarreal. All rights reserved.
//

import UIKit
import Paybook
import Pods_Paybook_Tests



class ViewController: UIViewController, UITextViewDelegate {

    
    var vartest : Session!
    
    
    @IBOutlet weak var imputText: UITextField!
    
    
    @IBAction func Test(sender: AnyObject) {
    
        UnitTest.test_library(imputText.text!)
     
    }
    
    
    @IBAction func testStatus(sender: AnyObject) {
        UnitTest.checkStatus()
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

