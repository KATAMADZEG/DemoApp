//
//  AuthenticationViewModel.swift
//  DemoApp
//
//  Created by Giorgi Katamadze on 18.02.23.
//

import UIKit

protocol  FormViewModel {
    func updateForm()
}

protocol AuthenticationViewModel {
    var formIsValid : Bool { get  }
    var buttonBackgroundColor : UIColor { get  }
    var buttonTitleColor : UIColor { get  }
}

struct LoginViewModel:AuthenticationViewModel {
    
    var email : String?
    var password : String?
    
    var formIsValid : Bool {
        return email?.isEmpty == false && password?.isEmpty == false
    }
    var buttonBackgroundColor : UIColor {
        return formIsValid ? .purple : .clear
    }
    var buttonTitleColor : UIColor {
        return formIsValid ? .white : .red
    }
}

struct RegistrationViewModel:AuthenticationViewModel {
    var email           :String?
    var password        :String?
    var age             :String?
    
    
    var formIsValid: Bool {
        return email?.isEmpty == false && password?.isEmpty == false && age?.isEmpty == false
    }
    var buttonBackgroundColor: UIColor {
        return formIsValid ? .purple : .clear
    }
    var buttonTitleColor: UIColor{
        return formIsValid ? .white : .red
    }
}
