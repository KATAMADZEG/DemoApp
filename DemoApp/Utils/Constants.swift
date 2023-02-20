//
//  Constants.swift
//  DemoApp
//
//  Created by Giorgi Katamadze on 18.02.23.
//

import UIKit
import Firebase
import FirebaseAnalytics

let screenHeight = UIScreen.main.bounds.height
let screenWidth = UIScreen.main.bounds.width

let COLLECATION_USERS = Firestore.firestore().collection("users")


class URLs {
    
     let apiKey = "33746605-73283ab96dd4e97e686a209b5"
     var components  = URLComponents()
    
    init() {
        components.scheme = "https"
        components.host =  "pixabay.com"
    }
    
     func main() -> String {
         
        let parameters = [
            "key" : apiKey.description ,
            "q"  : "yellow",
        ]
         
         components.path  = "/api/"
         
         components.queryItems = parameters.map {key , value in
            return URLQueryItem(name: key, value: value)
        }
        
        return "\(components.url!)"
    }
    
    func detail(id:String) -> String {
        let parameters = [
            "key" : apiKey.description ,
            "q"  : "yellow",
            "id" : id
        ]
        components.path  = "/api/"
        components.queryItems = parameters.map {key , value in
           return URLQueryItem(name: key, value: value)
       }
        return "\(components.url!)"
    }
}

