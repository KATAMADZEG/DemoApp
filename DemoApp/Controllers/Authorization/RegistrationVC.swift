//
//  RegistrationVC.swift
//  DemoApp
//
//  Created by Giorgi Katamadze on 18.02.23.
//

import UIKit

class RegistrationVC: UIViewController {

    //MARK: - Properties
    private var viewModel = RegistrationViewModel()
    private var profileImage : UIImage?
    weak var delegate : AuthenticationDelegate?
    
    
    private let mailTextField : UITextField = {
        let tf = CustomTextField(placeholder: "Email")
        return tf
    }()
    private let passwordTextField : UITextField = {
        let tf = CustomTextField(placeholder: "Password")
        tf.isSecureTextEntry = true
        return tf
    }()
    private let ageTextField = CustomTextField(placeholder: "Age")
    
    
    private lazy var signUpButton : UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Sign Up", for: .normal)
        button.setTitleColor(UIColor.white, for: .normal)
        button.layer.cornerRadius = 5
        button.backgroundColor = .purple
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
    }
    //MARK: - Actions
    @objc private func handleSignUpBtn() {
        
        guard let email = mailTextField.text,
              let password  = passwordTextField.text,
              let age = ageTextField.text
        else {return}
        let credential = AuthCredentials(email: email, password: password, age: age)
        
        AuthService.registerUser(withCredential: credential) { error in
            if let error = error {
                print(error.localizedDescription)
                return
            }
            self.delegate?.authenticationComplete()
        }
    }
    
    @objc private func handleBackLoginPage(){
        navigationController?.popViewController(animated: true)
    }
    @objc private func textDidChange(sender:UITextField){
        switch true {
        case sender == mailTextField:
            viewModel.email = sender.text
        case sender == passwordTextField:
            viewModel.password = sender.text
        case sender == ageTextField:
            viewModel.age = sender.text
        default:
            break
        }
        updateForm()
    }

    //MARK: - Helpers

    private func configureUI(){
        view.backgroundColor = .white
        configureGradientLayer()
        let stackView = UIStackView(arrangedSubviews: [mailTextField,passwordTextField,ageTextField,signUpButton])
        stackView.axis = .vertical
        stackView.spacing = 20
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
        signUpButton.titleLabel?.textColor = viewModel.buttonTitleColor
        signUpButton.isEnabled = viewModel.formIsValid
    }
}
