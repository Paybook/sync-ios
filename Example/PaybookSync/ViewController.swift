//
//  ViewController.swift
//  PaybookSync
//
//  Created by Gabriel Villarreal on 06/06/2016.
//  Copyright © 2016 Paybook.Inc. All rights reserved.
//

import UIKit
import Paybook


class ViewController: UIViewController, UITextViewDelegate {

    
    var vartest : Session!
    
    
    @IBOutlet weak var imputText: UITextField!
    
    
    @IBAction func Test(sender: AnyObject) {
        UnitTest.test_library(imputText.text!)
    }
    
    
    
    func textViewDidEndEditing(textView: UITextView) {
        textView.endEditing(true)
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        self.view.endEditing(true)
        Test(self)
        
        return false
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

