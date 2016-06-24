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
    
    public class func test_library(api_key: String){
        // This is an example of a functional test case.
        /*
         Initialization
         
         1. Start Library with incorrect API_KEY
         2. Perfom a call to the library (execute some method that uses the API_KEY) -> it should return error
         3. Start Library with incorrect API_KEY
         
         Users
         
         4. Get users
         5. Creates a new user (creates an instance of a new user)
         6. Get users (it should return 1 user more than step 4)
         7. Delete the created user
         8. Get users (it should be equal to step 4)
         9. Creates a new user again (store its id_user it should be used in future steps)
         
         Sessions
         
         10. Creates a new user (using the id_user stored in step 9, this creates an instance of an existing user)
         11. Creates a new session of the user created in step 10
         12. Verify session
         13. Delete session
         14. Verify session -> it should return error because session does not exist, it was deleted
         15. Creates a new session again
         
         Catalogues
         
         16. Get account types
         17. Get attachment types
         18. Get countries
         19. Get site types
         20. Get test site types (store the test title which nama is "Token" it will be used in future steps
         21. Get site organization types
         22. Get the SAT/CIEC site, you must get sites and extract it from the array by iterating it (store it, it will be used in future steps)
         
         Credentials
         
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
         
         Accounts
         
         34. Get accounts
         
         Transactions
         
         35. Get transactions count
         36. Get transactions
         
         Attachments
         
         37. Get attachments count
         38. Get attachments
         */
        
        
        Paybook.api_key = api_key
        
        
        
        User.get() {
            responseArray , error in
            if (responseArray != nil) {
                print("#4 Success Get users")
                let user_count = responseArray?.count
                
                _ = User(username: "UserTest", completionHandler: {
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
                                                if response != nil{
                                                    for value in response! {
                                                        print(value.id_user)
                                                    }
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
    
}