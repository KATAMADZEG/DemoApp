//
//  AuthService.swift
//  DemoApp
//
//  Created by Giorgi Katamadze on 18.02.23.
//

import UIKit
import FirebaseAuth
import Firebase

struct AuthCredentials {
    let email           :String
    let password        :String
    let age             :String

}

struct AuthService {
    static func logInUser(withEmail email: String, password: String, completion: @escaping(AuthDataResult?, Error?) -> Void) {
        
        Auth.auth().signIn(withEmail: email, password: password, completion: completion)
        
    }
    
    static func registerUser(withCredential:AuthCredentials,complition: @escaping(AuthDataResult?, Error?) -> Void){
        Auth.auth().createUser(withEmail: withCredential.email, password: withCredential.password, completion: complition)
    }
}
