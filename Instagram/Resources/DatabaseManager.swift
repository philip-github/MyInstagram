//
//  DatabaseManager.swift
//  Instagram
//
//  Created by Philip Twal on 8/14/22.
//
import FirebaseDatabase
import Foundation

public class DatabaseManager {
    static let shared = DatabaseManager()
    private init(){}
    
    private let database = Database.database().reference()
    
    struct DatabaseConstants {
        static let username = "username"
    }
    
    //MARK: Public
    
    /// Check if username and email are available
    ///  - Parameters
    ///      username: String representing username
    ///      email: String representing email
    public func canCreateUser(username: String, email:String, completion: (Bool) -> Void){
        completion(true)
    }
    

    /// Save User to Database
    ///  - Parameters
    ///      username: String representing username
    ///      email: String representing email
    ///      completion: Async return true value if user account got inserted successfully
    public func insertNewUser(with email: String, username: String, completion: @escaping (Bool) -> Void) {
        database.child(email.safeEmail()).setValue([DatabaseConstants.username: username]) { error, _ in
            if error == nil {
                completion(true)
            }else{
                print(error?.localizedDescription ?? "Failed to insert user account in database")
                completion(false)
            }
        }
    }
}
