//
//  UnitTest.swift
//  Paybook
//
//  Created by Gabriel Villarreal on 22/06/16.
//  Copyright © 2016 CocoaPods. All rights reserved.
//

import Foundation
import Paybook

public class UnitTest {
    
    static var api_key : String!
    static var id_user : String!
    static var session_test : Session!
    
    public class func test_library(api_key: String){
        
        UnitTest.api_key = api_key
        
        //delete()
        testInitialization()
        
        
        
        
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
            if error != nil {
                print("#2 Success")
                Paybook.api_key = UnitTest.api_key
                User.get({
                    response, error in
                    if response != nil {
                        print("#3 Success")
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
                print("#4 Success Get users")
                let user_count = responseArray?.count
                
                _ = User(username: "UserTest",id_user: nil, completionHandler: {
                    user , error in
                    if user != nil {
                        print("#5 Success Creates a new user")
                        User.get() {
                            responseArray , error in
                            if (responseArray != nil) {
                                for value in responseArray! {
                                    print(value.id_user)
                                }
                                if responseArray?.count > user_count {
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
                        print("#5 Fail Creates a new user: \(error?.message)")
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
                print("#10 Success")
                
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
                                                        print("#15 Fail \(error.debugDescription) ")
                                                        finish()
                                                        return
                                                    }
                                                })
                                                
                                                
                                            }else{
                                                print("#14 Fail\(error.debugDescription)")
                                                finish()
                                                return
                                            }
                                        })
                                    }else{
                                        print("#13 Fail")
                                        finish()
                                        return
                                    }
                                })
                                
                            }else{
                               print("#12 Fail ")
                                finish()
                                return
                            }
                        })
                        
                    }else{
                        print("#11 Fail ")
                        finish()
                        return
                    }
                })
            }else{
                print("#10 Fail")
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
                print("#16 Success")
                Catalogues.get_attachment_types(session_test, id_user: nil, completionHandler: {
                    response, error in
                    if response != nil {
                        print("#17 Success")
                        Catalogues.get_countries(session_test, id_user: nil, completionHandler: {
                            response, error in
                            if response != nil {
                                print("#18 Success")
                                Catalogues.get_sites(session_test, id_user: nil, completionHandler: {
                                    response, error in
                                    if response != nil {
                                        print("#19 Success")
                                        testAccounts()
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
     32. Check status and wait for status 410
     33. Send token using set_twofa method
     */
    
    class func testCredentials(){
    
    
    }

    
    
    
    /*** Test Accounts
     34. Get accounts
    */
    class func testAccounts(){
        Account.get(session_test, id_user: nil, completionHandler: {
            response, error in
            if response != nil {
                print("#34 Success")
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
                print("#35 Success transaction count: \(response)")
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
                print("#37 Success Attachments count: \(response)")
                
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
                print("#37 Fail, \(error?.message)")
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
        
        User.delete("id", completionHandler: {
            response, error in
            print(response)
        })
        
    }
    
}