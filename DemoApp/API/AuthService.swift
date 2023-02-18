//
//  AuthService.swift
//  DemoApp
//
//  Created by Giorgi Katamadze on 18.02.23.
//

import UIKit
import FirebaseAuth
import FirebaseCore

struct AuthCredentials {
    let email           :String
    let password        :String
    let age             :String

}

struct AuthService {
    static func logUserIn( with email:String,password: String , completion:@escaping AuthDataResultCallback) {
        Auth.auth().signIn(withEmail: email, password: password, completion: completion)
    }
    
    static func registerUser(withCredential:AuthCredentials,complition:@escaping (Error?) -> Void){
            Auth.auth().createUser(withEmail: withCredential.email, password: withCredential.password) { result, error in
                if let error = error {
                    print(error.localizedDescription)
                    return
                }
                guard let uid = result?.user.uid else {return}
                let data : [String:Any] = ["email":withCredential.email,
                                           "password":withCredential.password,
                                           "age":withCredential.age,
                                           "uid":uid]
                COLLECATION_USERS.document(uid).setData(data, merge: true , completion: complition)
            }
    }
}
