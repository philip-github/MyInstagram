//
//  StorageManager.swift
//  Instagram
//
//  Created by Philip Twal on 8/14/22.
//

import FirebaseStorage

public class StorageManager {
    
    static let shared = StorageManager()
    private init(){}
    
    private let bucket = Storage.storage().reference()
    
    enum StorageErrorManager: Error {
        case failedToDownloadImage
        case failedToUploadUserPost
    }
    
    func uploadUserPost(userPost: UserPost, completionHandler: @escaping (Result<URL, StorageErrorManager>) -> Void){
        
    }
    
    func downloadImage(with refrence: String, completion: @escaping (Result<URL, StorageErrorManager>) -> Void) {
        bucket.child(refrence).downloadURL { url, error in
            guard let url = url , error == nil else { return completion(.failure(.failedToDownloadImage)) }
            completion(.success(url))
        }
    }
}
