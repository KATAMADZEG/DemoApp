//
//  RegistrationVC.swift
//  DemoApp
//
//  Created by Giorgi Katamadze on 18.02.23.
//

import UIKit
import Firebase

class RegistrationVC: UIViewController {

    //MARK: - Properties
    private var viewModel = RegistrationViewModel()
    private var profileImage : UIImage?
    
    
    private let mailTextField : UITextField = {
        let tf = CustomTextField(placeholder: "Email")
        return tf
    }()

    private let ageTextField = CustomTextField(placeholder: "Age",keyboardType: .numberPad)
    
    
    private let passwordErrorLabel : UILabel = {
        let label = UILabel()
     
        return label
    }()
    
    private let mailErrorLabel : UILabel = {
        let label = UILabel()
       
        return label
    }()
    
    private let ageErroLabel : UILabel = {
        let label = UILabel()
     
        return label
    }()
    
    private let passwordTextField : UITextField = {
        let tf = CustomTextField(placeholder: "Password")
        
        tf.isSecureTextEntry = true
        return tf
    }()
    
    private lazy var signUpButton : UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Sign Up", for: .normal)
        button.setTitleColor(UIColor.white.withAlphaComponent(0.67), for: .normal)
        button.layer.cornerRadius = 5
        button.backgroundColor = .clear
        
        button.snp.makeConstraints { make in
            make.height.equalTo(50)
        }
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        button.addTarget(self, action: #selector(handleSignUpBtn), for: .touchUpInside)
        return button
    }()
    private lazy var  alreadyHaveAccButton : UIButton = {
        let button = UIButton(type: .system)
        button.attributedTitle(firstPart: "Already have an account" , secondPart: " Sign Up")
        button.addTarget(self, action: #selector(handleBackLoginPage), for: .touchUpInside)
        return button
    }()
    
    //MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        configureNotificationObserver()
        viewModel.outputs = self
    }
    //MARK: - Actions
    @objc private func handleSignUpBtn() {
        
        if !viewModel.mailIsValid! {
            mailErrorLabel.text = "ელ.ფოსტა არ არის ვალიდური"
            return
        }
        
        if !viewModel.passwordIsVlid! {
            passwordErrorLabel.text = "აკრიბეთ მინ. 6 და მაქ. 12 სიმბოლო"
            return
        }
        
        if !viewModel.ageIsValid! {
            ageErroLabel.text = "ასაკი უნდა იყოს 18 დან 99 მდე"
            return
        }
        
        guard let email = mailTextField.text,
              let password  = passwordTextField.text,
              let age = ageTextField.text
        else {return}
        
        let credential = AuthCredentials(email: email, password: password, age: age)
        
        viewModel.inputs.registerUser(with: credential)
    }
    
    @objc private func handleBackLoginPage(){
        navigationController?.popViewController(animated: true)
    }
    @objc private func textDidChange(sender:UITextField){
        print("\(sender.text) sadas")
        if sender == mailTextField {
            viewModel.email = sender.text
        }else if sender == passwordTextField {
            viewModel.password = sender.text
        }else{
            viewModel.age = sender.text
        }
        updateForm()
    }

    //MARK: - Helpers

    private func configureUI(){
        view.backgroundColor = .white
        configureGradientLayer()
        let stackView = UIStackView(arrangedSubviews: [mailTextField,mailErrorLabel,passwordTextField,passwordErrorLabel,ageTextField,ageErroLabel,signUpButton])
        stackView.axis = .vertical
        stackView.spacing = 10
        view.addSubview(stackView)
        stackView.snp.makeConstraints { make in
            make.top.equalTo(self.view.snp_topMargin).offset(32)
            make.left.equalTo(view.snp_leftMargin).inset(32)
            make.right.equalTo(view.snp_rightMargin).inset(32)
        }
        view.addSubview(alreadyHaveAccButton)
        alreadyHaveAccButton.snp.makeConstraints { make in
            make.centerX.equalTo(view)
            make.bottom.equalTo(view.snp_bottomMargin).inset(20)
        }
    }
    private func configureNotificationObserver(){
        mailTextField.addTarget(self, action: #selector(textDidChange), for: .editingChanged)
        passwordTextField.addTarget(self, action: #selector(textDidChange), for: .editingChanged)
        ageTextField.addTarget(self, action: #selector(textDidChange), for: .editingChanged)
    }
}

extension RegistrationVC : FormViewModel {
    func updateForm() {
        signUpButton.backgroundColor = viewModel.buttonBackgroundColor
        signUpButton.setTitleColor(viewModel.buttonTitleColor, for: .normal)
        signUpButton.isEnabled = viewModel.formIsValid
    }
}

//MARK: - RegistrationViewModelOutputs
extension RegistrationVC : RegistrationViewModelOutputs {
    func userRegistrationResponse(result: AuthDataResult?, error: Error?) {
        if let error = error {
            print(error.localizedDescription)
            return
        }
        
        let vc = MainPageVC()
        view.window?.rootViewController = UINavigationController(rootViewController: vc)

    }
}
