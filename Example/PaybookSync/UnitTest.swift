//
//  UnitTest.swift
//  Paybook
//
//  Created by Gabriel Villarreal on 22/06/16.
//  Copyright © 2016 Paybook.Inc. All rights reserved.
//

import Foundation
import Paybook

open class UnitTest: NSObject {
    
    static var api_key : String!
    static var id_user : String!
    static var session_test : Session!
    static var site_test : Site!
    static var site_SAT : Site!
    static var cred_test : Credentials!
    static var timer = Timer()
    
    open class func test_library(_ api_key: String){
        
        UnitTest.api_key = api_key
        
        testInitialization()
        //delete()
        
    }
    
    
    /*** Test Initialization
     1. Start Library with incorrect API_KEY
     2. Perfom a call to the library (execute some method that uses the API_KEY) -> it should return error
     3. Start Library with correct API_KEY
    */

    class func testInitialization(){
        Paybook.api_key = "API_key_invalid"
        print("#1 Success")
        User.get({
            response, error in
            print("response",response,"error",error)
            if error != nil {
                print("#2 Success")
                Paybook.api_key = UnitTest.api_key
                User.get({
                    response, error in
                    if response != nil {
                        print("#3 Success")
                        for value in response! {
                            print("\(value.name) \(value.id_user)")
                        }
                        // Continue with testUser
                        testUser()
                    }else{
                        print("#3 Fail")
                    }
                })
            }else{
                print("#2 Fail")
            }
        })
        
        
    }
    
    
    
    /*** Test User
     4. Get users
     5. Creates a new user (creates an instance of a new user)
     6. Get users (it should return 1 user more than step 4)
     7. Delete the created user
     8. Get users (it should be equal to step 4)
     9. Creates a new user again (store its id_user it should be used in future steps)
    */
    class func testUser(){
        Paybook.api_key = UnitTest.api_key
        User.get() {
            responseArray , error in
            if (responseArray != nil) {
                print("\n#4 Success Get users")
                let user_count = responseArray?.count
                
                _ = User(username: "UserTest",id_user: nil, completionHandler: {
                    user , error in
                    if user != nil {
                        print("#5 Success Creates a new user")
                        User.get() {
                            responseArray , error in
                            if (responseArray != nil) {
                                
                                if (responseArray?.count)! > user_count! {
                                    print("#6 Success Creates a new user")
                                    User.delete((user?.id_user)!, completionHandler: {
                                        response, error in
                                        if (response != nil && response == true) {
                                            print("#7 Success Delete the created user")
                                            User.get({
                                                response , error in
                                                if response != nil && response?.count == user_count{
                                                    print("#8 Success")
                                                    _ = User(username: "UserTest", id_user: nil, completionHandler: {
                                                        user, error in
                                                        if user != nil{
                                                            print("#9 Success")
                                                            id_user = user?.id_user
                                                            // Continue with testSession
                                                            testSession()
                                                        }else{
                                                            print("#9 Fail")
                                                        }
                                                        
                                                    })
                                                }else{
                                                    print("#8 Fail")
                                                }
                                            })
                                        }else{
                                            print("#7 Fail Delete the created user: \(error?.message)")
                                        }
                                    })
                                }else{
                                    print("#6 Fail (it should return 1 user more than step 4): ")
                                }
                            }
                            return
                        }
                    }else{
                        print("#5 Fail Creates a new user: \(error)")
                    }
                })
            }else{
                print("#4 Fail Get users: \(error?.message)")
            }
            
            return
        }
    }
    
    
    /*** Test Session
     10. Creates a new user (using the id_user stored in step 9, this creates an instance of an existing user)
     11. Creates a new session of the user created in step 10
     12. Verify session
     13. Delete session
     14. Verify session -> it should return error because session does not exist, it was deleted
     15. Creates a new session again
    */
    class func testSession(){
        
        _ = User(username: "", id_user: id_user, completionHandler: {
            user, error in
            
            if user != nil{
                print("\n#10 Success")
                
                _ = Session(id_user: user!.id_user, completionHandler: {
                    session , error in
                    
                    if session != nil{
                        print("#11 Success \(session!.token)")
                        
                        session?.validate({
                            response, error in
                            if response != nil && response == true{
                               print("#12 Success ")
                                Session.delete(session!.token, completionHandler: {
                                    response, error in
                                    if response != nil && response == true {
                                        print("#13 Success")
                                        session?.validate({
                                            response, error in
                                            
                                            if response != nil && response == false{
                                                print("#14 Success ")
                                                
                                                _ = Session(id_user: id_user, completionHandler: {
                                                    session, error in
                                                    if session != nil {
                                                        session_test = session
                                                        print("#15 Success ")
                                                        testCatalogues()
                                                    }else{
                                                        print("#15 Fail \(error?.message) ")
                                                        finish()
                                                        return
                                                    }
                                                })
                                                
                                                
                                            }else{
                                                print("#14 Fail \(error?.message)")
                                                finish()
                                                return
                                            }
                                        })
                                    }else{
                                        print("#13 Fail \(error?.message)")
                                        finish()
                                        return
                                    }
                                })
                                
                            }else{
                               print("#12 Fail \(error?.message)")
                                finish()
                                return
                            }
                        })
                        
                    }else{
                        print("#11 Fail \(error?.message)")
                        finish()
                        return
                    }
                })
            }else{
                print("#10 Fail \(error?.message)")
                finish()
                return
            }
        })
        
    }
    
    
    /*** Test Catalogues
     
     16. Get account types
     17. Get attachment types
     18. Get countries
     19. Get site types
     20. Get test site types (store the test title which nama is "Token" it will be used in future steps
     21. Get site organization types
     22. Get the SAT/CIEC site, you must get sites and extract it from the array by iterating it (store it, it will be used in future steps)
     */
    
    class func testCatalogues(){
        Catalogues.get_account_types(session_test, id_user: nil, completionHandler: {
            response, error in
            if response != nil {
                print("\n#16 Success")
                Catalogues.get_attachment_types(session_test, id_user: nil, completionHandler: {
                    response, error in
                    if response != nil {
                        print("#17 Success")
                        Catalogues.get_countries(session_test, id_user: nil, completionHandler: {
                            response, error in
                            if response != nil {
                                print("#18 Success")
                                
                                Catalogues.get_sites(session_test, id_user: nil,is_test: false, completionHandler: {
                                    response, error in
                                    if response != nil {
                                        print("#19 Success")
                                        for site in response!{
                                            // Get SAT Site
                                            if site.id_site_organization == "56cf4ff5784806152c8b4568"{
                                                site_SAT = site
                                                print("#22 Success \(site)")
                                            }
                                        }
                                        Catalogues.get_sites(session_test, id_user: nil,is_test: true, completionHandler: {
                                            response, error in
                                            if response != nil {
                                                for site in response!{
                                                    // Get Token Test Site
                                                    if site.name == "Token"{
                                                        print("#20 Success")
                                                        print("site: \(site)")
                                                        site_test = site
                                                    }
                                                }
                                                
                                                if site_test != nil{
                                                    Catalogues.get_site_organizations(session_test, id_user: nil, completionHandler: {
                                                        response, error in
                                                        if response != nil {
                                                            print("#21 Success")
                                                            
                                                            testCredentials()
                                                        }else{
                                                            print("#21 Fail \(error?.message)")
                                                            finish()
                                                            return
                                                        }
                                                    })
                                                }else{
                                                    print("#20 Fail")
                                                    finish()
                                                    return
                                                }
                                                
                                            }else{
                                                print("#20 Fail")
                                                finish()
                                                return
                                            }
                                        })

                                        
                                    }else{
                                        print("#19 Fail")
                                        finish()
                                        return
                                    }
                                })
                            }else{
                                print("#18 Fail")
                                finish()
                                return
                            }
                        })
                    }else{
                        print("#17 Fail")
                        finish()
                        return
                    }
                })
            }else{
                print("#16 Fail")
                finish()
                return
            }
        })
    }
    
    
    
    /*** Test Credentials
     23. Get credentials
     24. Creates credentials params for SAT/CIEC site using its configuration structure (you should use the site obtained in step 22)
     25. Creates credentials for SAT/CIEC site (you should use the site obtained in step 22)
     26. Get credentials (it should return 1 user more than step 23)
     27. Delete credentials created in step 25
     28. Get credentials (they should be equal to step 23)
     29. Creates credentials for SAT/CIEC site again (you should use the site obtained in step 22)
     30. Creates credentials for Token test site (you should use the site obtained in step 20)
     31. Check status and wait for status 410
     32. Send token using set_twofa method
     */
    
    class func testCredentials(){
        Credentials.get(session_test, id_user: nil, completionHandler: {
            response, error in
            if response != nil {
                print("\n#23 Success you have \(response!.count) Credentials")
                let credentials_count = response?.count
                var params = [String:String]()
                
                
                if let credentials = site_SAT.credentials as? [AnyObject]{
                    
                    for value in credentials{
                        params[value.value(forKey: "name")as? String ?? ""] = "test"
                    }
                    print("#24 Success params : \(params)")
                    
                    _ = Credentials(session: session_test, id_user: nil, id_site: site_SAT.id_site, credentials: params as NSDictionary, completionHandler: {
                        credential, error in
                        if credential != nil{
                            print("#25 Success ")
                            Credentials.get(session_test, id_user: nil, completionHandler: {
                                response, error in
                                if response != nil && (response?.count)! > credentials_count!{
                                    print("#26 Success you have \(response!.count) credentials")
                                    
                                    Credentials.delete(session_test, id_user: nil, id_credential: credential!.id_credential, completionHandler: {
                                        response, error in
                                        if response != nil && response == true{
                                            print("#27 Success ")
                                            Credentials.get(session_test, id_user: nil, completionHandler: {
                                                response, error in
                                                if response != nil && response?.count == credentials_count{
                                                    print("#28 Success ")
                                                    _ = Credentials(session: session_test, id_user: nil, id_site: site_SAT.id_site, credentials: params as NSDictionary, completionHandler: {
                                                        response, error in
                                                        if response != nil {
                                                            print("#29 Success ")
                                                            var params = [String:String]()
                                                            
                                                            for value in site_test.credentials as [AnyObject]{
                                                                params[value.value(forKey: "name")as? String ?? ""] = "test"
                                                            }
                                                            
                                                            _ = Credentials(session: nil, id_user: session_test.id_user, id_site: site_test.id_site, credentials: params as NSDictionary, completionHandler: {
                                                                response, error in
                                                                
                                                                if response != nil{
                                                                    print("#30 Success ")
                                                                    cred_test = response
                                                                    self.timer = Timer.scheduledTimer(timeInterval: 3.0, target: self, selector: #selector(self.checkStatus), userInfo: nil, repeats: true)
                                                                }else{
                                                                    print("#29 Fail ")
                                                                    finish()
                                                                }
                                                                
                                                            })
                                                            
                                                        }else{
                                                            print("#29 Fail ")
                                                            finish()
                                                        }
                                                        
                                                    })
                                                }else{
                                                    print("#28 Fail \(error?.message)")
                                                    finish()
                                                }
                                            })
                                        }else{
                                            print("#27 Fail \(error?.message)")
                                            finish()
                                        }
                                        
                                    })
                                    
                                }else{
                                    print("#26 Fail \(error?.message)")
                                    finish()
                                }
                                
                            })
                            
                        }else{
                            print("#25 Fail \(error?.message)")
                        }
                        
                        /*
                         if response != nil{
                         print("#25 Success : \(response)")
                         response?.get_status(session_test, id_user: nil, completionHandler: {
                         response, error in
                         print(response,error)
                         
                         })
                         cred_test = response
                         
                         }
                         
                         */
                        
                    })
                    

                }
                
            }else{
                print("#23 Fail")
                finish()
            }
            
        })
        
    }
    
    class func checkStatus(){
        cred_test.get_status(session_test, id_user: nil, completionHandler: {
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
                    testAccounts()
                    break
                case 401,405,406,411:
                    print("User Error \(status["code"])")
                    self.timer.invalidate()
                    break
                case 410:
                    print("Waiting for two-fa \(status["code"])")
                    self.timer.invalidate()
                    var params = [String:String]()
                    
                    for param in status["twofa"] as! [NSDictionary]{
                        params[param["name"] as! String] = "test"
                    }
                    cred_test.set_twofa(session_test, id_user: nil, params: params as NSDictionary, completionHandler: {
                        response, error in
                        if response != nil && response == true{
                            print("32 Success")
                            testAccounts()
                        }else{
                            print("32 Fail \(error?.message)")
                        }
                    })

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
    
    
    /*** Test Accounts
     34. Get accounts
    */
    class func testAccounts(){
        Account.get(session_test, id_user: nil, completionHandler: {
            response, error in
            if response != nil {
                print("\n#34 Success")
                print("\nAccounts:")
                for i in response!{
                    print(i.name,i.id_account,i.id_site_organization)
                }
                testTransactions()
            }else{
                print("#34 Fail")
                finish()
                return
            }
        })
    }
    
    
    
    /*** Test Transactions
     35. Get transactions count
     36. Get transactions
    */
    class func testTransactions(){
        Transaction.get_count(session_test, id_user: nil, completionHandler: {
            response, error in
            if response != nil {
                print("\n#35 Success transaction count: \(response)")
                Transaction.get(session_test, id_user: nil, completionHandler: {
                    response, error in
                    if response != nil {
                        print("#36 Success ")
                        testAttachments()
                    }else{
                        print("#36 Fail")
                        finish()
                        return
                    }
                    
                })
            }else{
                print("#35 Fail")
                finish()
                return
            }
            
        })
        
    }
    
    
    
    
    
    /*** Test Attachments
     37. Get attachments count
     38. Get attachments
    */
    class func testAttachments(){
        
        print(session_test.token)
        Attachments.get_count(session_test, id_user: nil, completionHandler: {
            response, error in
            if response != nil {
                print("\n#37 Success Attachments count: \(response)")
                
                Attachments.get(session_test, id_user: nil, completionHandler: {
                    response, error in
                    if response != nil {
                        print("#38 Success ")
                       
                        finish()
                        return
                    }else{
                        print("#38 Fail")
                        finish()
                        return
                    }
                })
            }else{
                print("#37 Fail code \(error?.code), \(error?.message)")
                finish()
                return
            }
            
        })

    }
    
    
    
    
    class func finish(){
        User.delete(id_user, completionHandler: {
            response, error in
            if (response != nil) {
                print("Finish Test")
            }
        })
    }
    
    class func delete(){
        Paybook.api_key = UnitTest.api_key

        User.delete("589e096c0c212aa4348b458a", completionHandler: {
            response, error in
            print(response)
        })
        User.delete("589e0ee80b212aa12c8b4579", completionHandler: {
            response, error in
            print(response)
        })
        User.delete("589e11e40c212ab7348b4589", completionHandler: {
            response, error in
            print(response)
        })
        User.delete("589e13ca0c212ac7348b458a", completionHandler: {
            response, error in
            print(response)
        })
        User.delete("589e172f0c212ada348b4589", completionHandler: {
            response, error in
            print(response)
        })
        User.delete("589e1a530b212a682c8b457c", completionHandler: {
            response, error in
            print(response)
        })
        User.delete("589e21220b212aa02c8b457d", completionHandler: {
            response, error in
            print(response)
        })
        User.delete("590b925a0b212a3f208b780e", completionHandler: {
            response, error in
            print(response)
        })
        User.delete("590b97900b212a00208b7862", completionHandler: {
            response, error in
            print(response)
        })
        User.delete("590b98cc0c212a47678b97ef", completionHandler: {
            response, error in
            print(response)
        })
        User.delete("5910eeee0c212a8f678bd366", completionHandler: {
            response, error in
            print(response)
        })
        User.delete("5910f1410b212a64208bb053", completionHandler: {
            response, error in
            print(response)
        })
        User.delete("589cf4590b212aac058ba23c", completionHandler: {
            response, error in
            print(response)
        })
        User.delete("589cf8d90b212a51058ba225", completionHandler: {
            response, error in
            print(response)
        })
        User.delete("589d01490c212a6a048bad7f", completionHandler: {
            response, error in
            print(response)
        })
        User.delete("589de9f10b212a612c8b4575", completionHandler: {
            response, error in
            print(response)
        })
        User.delete("589dedad0c212acb348b4580", completionHandler: {
            response, error in
            print(response)
        })
    }
    
}
