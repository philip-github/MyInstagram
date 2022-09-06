//
//  AuthManager .swift
//  Instagram
//
//  Created by Philip Twal on 8/14/22.
//

import FirebaseAuth
import Foundation

public class AuthManager {
    
    static let shared = AuthManager()
    private init(){}
    
    
    public func registerUser(username: String, email: String, password: String, completion: @escaping (Bool) -> Void) {
        // check for email
        // check for username
        DatabaseManager.shared.canCreateUser(username: username, email: email) { canCreate in
            if canCreate {
                // regitser user
                Auth.auth().createUser(withEmail: email, password: password) { result, error in
                    guard result != nil, error == nil else {
                        // Firebase couldn't create account
                        completion(false)
                        return
                    }
                    // save account to database
                    DatabaseManager.shared.insertNewUser(with: email, username: username) { inserted in
                        if inserted{
                            // success
                            completion(true)
                        }else{
                            // failed to insert user
                            completion(false)
                        }
                    }
                }
            }else{
                completion(false)
            }
        }
    }
    
    
    
    public func loginUser(username: String?, email: String?, password: String, completionHandler: @escaping (Bool) -> Void){
        if let email = email {
            Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
                if error != nil {
                    completionHandler(false)
                }
                if authResult != nil && error == nil {
                    completionHandler(true)
                }
                
            }
        }
        else if let username = username {
            // login with username
            print(username)
        }
    }
    
    public func logOut(completion: (Bool) -> Void) {
        do{
            try Auth.auth().signOut()
            completion(true)
        }catch{
            completion(false)
        }
    }
}
