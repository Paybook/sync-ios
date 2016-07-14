//
//  Quickstart_sat_ViewController.swift
//
//  Created by Gabriel Villarreal on 30/06/16.
//  Copyright © 2016 Paybook.Inc. All rights reserved.
//

import UIKit
import Paybook

class Quickstart_sat_ViewController: UIViewController {

    var timer : NSTimer!
    var count = 1
    
    
    var user : User!
    var session : Session!
    var site : Site!
    var credential : Credentials!
    
    
    @IBOutlet weak var webview: UIWebView!
    
    
    
    func createUser(){
        _ = User(username: "MY_USER", id_user: nil, completionHandler: {
            user_response, error in
            if user_response != nil{
                self.user = user_response!
                print("User : \(user_response?.name)")
                self.getUsers()
            }else{
                print("No se pudo crear el usuario: \(error?.message)")
            }
        })

    
    }
    
    func getUsers(){
        User.get(){
            response,error in
            if response != nil {
                print("\nUsers: ")
                for user in response!{
                    print("\(user.name)")
                }
            }
            
            self.createSession()
        }
        
        
    }
    
    func createSession(){
        
        self.session = Session(id_user: self.user.id_user, completionHandler: {
            session_response, error in
            
            if session_response != nil {
                self.session = session_response
                self.getCatalogueSite()
            }else{
                print("No se pudo crear la session: \(error?.message)")
            }
        })
        
    }
    
    func getCatalogueSite(){
        Catalogues.get_sites(self.session, id_user: nil, is_test: nil, completionHandler: {
            sites_array, error in
            
            if sites_array != nil{
                
                print("\nCatalago de Sites:")
                for site in sites_array!{
                    
                    if site.name == "CIEC" {
                        print ("SAT site: \(site.name) \(site.id_site)")
                        self.site = site
                    }else{
                        print(site.name)
                    }
                    
                }
                
                if self.site != nil{
                    self.createCredential()
                }
                
            }
            
        })
        
        
    }
    
    
    func createCredential(){
        let data = [
            "rfc" : "YOUR_RFC",
            "password" : "YOUR_CIEC"
        ]
        
        _ = Credentials(session: self.session, id_user: nil, id_site: site.id_site, credentials: data, completionHandler: {
            credential_response , error in
            if credential_response != nil {
                
                self.credential = credential_response
                print("\nCheck Status:")
                self.timer = NSTimer.scheduledTimerWithTimeInterval(3.0, target: self, selector: #selector(self.checkStatus), userInfo: nil, repeats: true)
                
                
            }else{
                print("No se pudo crear las credenciales: \(error?.message)")
            }
            
        })
    }
    
    
    func checkStatus(){
        
        credential.get_status(self.session, id_user: nil, completionHandler: {
            response, error in
            if response != nil{
                
                let status = response![response!.count-1]
                
                switch status["code"] as! Int{
                case 100,101,102:
                    print("Processing...\(status["code"])")
                    break
                case 200,201,202,203:
                    print("Success...\(status["code"])")
                    self.timer.invalidate()
                    self.getTransactions()
                    break
                case 401,405,406,411:
                    print("User Error \(status["code"])")
                    self.timer.invalidate()
                    break
                case 410:
                    print("Waiting for two-fa \(status["code"])")
                    self.timer.invalidate()
                    break
                case 500,501,504,505:
                    print("System Error \(status["code"])")
                    self.timer.invalidate()
                    break
                default :
                    break
                }
            }else{
                print("Fail: \(error?.message)")
                
            }
            
            
        })
        
    }

    
    func getTransactions(){
        Transaction.get(self.session, id_user: nil, completionHandler: {
            transaction_array, error in
            if transaction_array != nil {
                print("\nTransactions: ")
                for transaction in transaction_array! {
                    print("$\(transaction.amount), \(transaction.description) ")
                }
                self.getAttachments()
                
            }else{
                print("Problemas al consultar las transacciones: \(error?.message)")
            }
            
        })
    }
    
    func getAttachments(){
        Attachments.get(session, id_user: nil, completionHandler: {
            attachments_array, error in
            if attachments_array != nil {
                print("\nAttachments: ")
                for attachment in attachments_array! {
                    print("Attachment type : \(attachment.id_attachment), id_transaction: \(attachment.id_transaction) ")
                }
                
                print("\nAttachment id: \(attachments_array![0].id_attachment)")
                Attachments.get(self.session, id_user: nil, id_attachment: attachments_array![0].id_attachment, completionHandler: {
                    response, error in
                    
                    if response != nil{
                        print("Charging file...")
                        self.loadAttachment(response!["destination"] as! NSURL)
                        
                    }else{
                        print("error:" , error?.code)
                        
                    }
                    
                    
                    
                })
                
            }else{
                print("Problemas al consultar los attachments: \(error?.message)")
            }
        })
    }
    
    func loadAttachment(path: NSURL) {
        
        let url = path
        let urlRequest = NSURLRequest(URL: url)
        webview.loadRequest(urlRequest)
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        Paybook.api_key = "YOUR_API_KEY"
        createUser()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

   

}
