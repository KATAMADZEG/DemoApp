//
//  AuthenticationViewModel.swift
//  DemoApp
//
//  Created by Giorgi Katamadze on 18.02.23.
//

import UIKit
//import Firebase

protocol  FormViewModel {
    func updateForm()
}

protocol AuthenticationViewModel {
    var formIsValid : Bool { get  }
    var buttonBackgroundColor : UIColor { get  }
    var buttonTitleColor : UIColor { get  }
}

protocol LoginViewModelInputs {
    func logIn(with email:String,with password:String)
   
}

protocol LoginViewModelOutputs {
    func userLogInResponse(result:AuthDataResult?,error:Error?)
  
}

protocol LoginViewModelModelType {
    var inputs: LoginViewModelInputs { get }
    var outputs: LoginViewModelOutputs? { get }
}


protocol RegistrationViewModelInputs {
    func registerUser(with credential :AuthCredentials)
}
protocol RegistrationViewModelOutputs {
    func userRegistrationResponse(error:Error?)
}
protocol RegistrationViewModelModelType {
    var inputs: RegistrationViewModelInputs { get }
    var outputs: RegistrationViewModelOutputs? { get }
}


struct LoginViewModel:AuthenticationViewModel,LoginViewModelModelType {
    var inputs  : LoginViewModelInputs { return self }
    var outputs : LoginViewModelOutputs?

    var email : String?
    var password : String?
    
    var formIsValid : Bool {
        return email?.isEmpty == false && password?.isEmpty == false
    }
    var buttonBackgroundColor : UIColor {
        return formIsValid ? .purple : .clear
    }
    var buttonTitleColor : UIColor {
        return formIsValid ? .white : .white.withAlphaComponent(0.67)
    }
  
}

struct RegistrationViewModel:AuthenticationViewModel,RegistrationViewModelModelType {
    var inputs: RegistrationViewModelInputs {self}
    var outputs: RegistrationViewModelOutputs?
    
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
        return formIsValid ? .white :  .white.withAlphaComponent(0.67)
    }
}

 


//MARK: - LoginViewModelInputs
extension LoginViewModel : LoginViewModelInputs {
    func logIn(with email: String, with password: String) {
        print("logIn")
        AuthService.logInUser(withEmail: email, password: password) { result, error in
            self.outputs?.userLogInResponse(result: result,error: error)
        }
    }
}

//MARK: - RegistrationViewModelInputs
extension RegistrationViewModel : RegistrationViewModelInputs {
    func registerUser(with credential: AuthCredentials) {
        
        print("register")
        AuthService.registerUser(withCredential: credential) { error in
            
            self.outputs?.userRegistrationResponse(error: error)
        }
    }
}
