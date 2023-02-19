//
//  LoginVC.swift
//  DemoApp
//
//  Created by Giorgi Katamadze on 18.02.23.
//

import UIKit
//import Firebase

protocol AuthenticationDelegate: AnyObject {
    func authenticationComplete()
}

class LoginVC: UIViewController {

    //MARK: - Properties
    
    private var viewModel = LoginViewModel()
    
    weak var delegate:AuthenticationDelegate?
    
    
    
    private lazy var tap = UITapGestureRecognizer(target: self, action: #selector(handleTap))

    
    private let iconImage:UIImageView = {
        let iv = UIImageView()
        return iv
    }()
    private let mailTextField : UITextField = {
        let tf = CustomTextField(placeholder: "Email")
        return tf
    }()
    private let passwordTextField : UITextField = {
        let tf = CustomTextField(placeholder: "Password")
        tf.isSecureTextEntry = true
        return tf
    }()
    private lazy var loginButton : UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Log In", for: .normal)
        button.setTitleColor(UIColor.white.withAlphaComponent(0.67), for: .normal)
        button.layer.cornerRadius = 5
        button.backgroundColor = .clear
        button.isEnabled  = false
        button.snp.makeConstraints { make in
            make.height.equalTo(50)
        }
        button.addTarget(self, action: #selector(handleLogIn), for: .touchUpInside)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        return button
    }()
    private lazy var dontHaveAccButton : UIButton = {
        let button = UIButton(type: .system)
        button.attributedTitle(firstPart: "Don't have an account" , secondPart: " Sign Up")
        button.addTarget(self, action: #selector(handleShowSignUp), for: .touchUpInside)
        return button
    }()
    
    
    //MARK: - LifeCycle

    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        configureNotificationObserver()
        viewModel.outputs  = self
        self.view.addGestureRecognizer(tap)
        
    }
    //MARK: - Actions
    
    @objc func handleTap(_ sender: UITapGestureRecognizer? = nil) {
        self.view.endEditing(true)
    }
    
    @objc private func handleLogIn() {
        guard let email = mailTextField.text,
              let password = passwordTextField.text else {return}
        viewModel.inputs.logIn(with: email, with: password)
    }
    @objc private func handleShowSignUp(){
        let vc = RegistrationVC()
        vc.delegate = delegate
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc private func textDidChange(sender:UITextField) {
        if sender == mailTextField {
            viewModel.email = sender.text
        }else{
            viewModel.password = sender.text
        }
        updateForm()
    }
    
    //MARK: - Helpers
    private func configureUI(){
        view.backgroundColor = .white
        navigationController?.navigationBar.barStyle = .black
        configureGradientLayer()
        
        view.addSubview(iconImage)
        iconImage.snp.makeConstraints { make in
            make.centerX.equalTo(view)
            make.top.equalTo(view.safeAreaLayoutGuide).offset(-28)
            make.height.equalTo(80)
            make.width.equalTo(200)
        }
        
        let stackView = UIStackView(arrangedSubviews: [mailTextField,passwordTextField,loginButton])
        stackView.axis = .vertical
        stackView.spacing = 20
        view.addSubview(stackView)
        stackView.snp.makeConstraints { make in
            make.top.equalTo(iconImage.snp_bottomMargin).offset(32)
            make.left.equalTo(view.snp_leftMargin).inset(32)
            make.right.equalTo(view.snp_rightMargin).inset(32)
        }
        view.addSubview(dontHaveAccButton)
        dontHaveAccButton.snp.makeConstraints { make in
            make.centerX.equalTo(view)
            make.bottom.equalTo(view.snp_bottomMargin).inset(20)
        }
    }
    
    private func configureNotificationObserver(){
        mailTextField.addTarget(self, action: #selector(textDidChange), for: .editingChanged)
        passwordTextField.addTarget(self, action: #selector(textDidChange), for: .editingChanged)
    }
}

//MARK: - FormViewModel
extension LoginVC : FormViewModel {
    func updateForm() {
        loginButton.backgroundColor = viewModel.buttonBackgroundColor
        loginButton.setTitleColor(viewModel.buttonTitleColor, for: .normal)
        loginButton.isEnabled = viewModel.formIsValid
    }
}

//MARK: - LoginViewModelOutputs
extension LoginVC : LoginViewModelOutputs {
    func userLogInResponse(result: AuthDataResult?,error:Error?) {
        
        if let error = error {
            print(error.localizedDescription)
            return
        }
        self.delegate?.authenticationComplete()
        self.dismiss(animated: true, completion: nil)
    }
}
