//
//  AuthService.swift
//  Yorumluo
//
//  Created by Bilgihan Köse on 18.09.2020.
//

import UIKit
import Firebase


struct AuthCredentials {
    let email: String
    let password: String
    let fullname: String
    let username: String
}

struct AuthService {
    static let shared = AuthService()
    
    
    func logUserIn(withEmail email: String, password: String, completion: AuthDataResultCallback?){
        Auth.auth().signIn(withEmail: email, password: password, completion: completion)
    }
    
    func registerUser(credentials: AuthCredentials, completion: @escaping(Error?, DatabaseReference) -> Void) {
        
        let email = credentials.email
        let password = credentials.password
        let fullname = credentials.fullname
        let username = credentials.username
        
        Auth.auth().createUser(withEmail: email, password: password) { (result, error) in
            if let error = error {
                print("DEBUG: Error is \(error.localizedDescription)")
                return
            }
            
            guard let uid = result?.user.uid else { return }
            
            let values = ["email": email, "username": username, "fullname": fullname]
            
          
            REF_USER.child(uid).updateChildValues(values, withCompletionBlock: completion)
            }
        }
    }

