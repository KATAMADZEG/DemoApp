//
//  LoginVC.swift
//  DemoApp
//
//  Created by Giorgi Katamadze on 18.02.23.
//

import UIKit
import Firebase


class LoginVC: UIViewController {


    //MARK: - Properties
    
    private var viewModel = LoginViewModel()
    
    private lazy var tap = UITapGestureRecognizer(target: self, action: #selector(handleTap))


    private let mailTextField : UITextField = {
        let tf = CustomTextField(placeholder: "Email")
        return tf
    }()
    

    private let passwordErrorLabel : UILabel = {
        let label = UILabel()
     
        return label
    }()
    
    private let mailErrorLabel : UILabel = {
        let label = UILabel()
       
        return label
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
        
        if !viewModel.mailIsValid! {
            mailErrorLabel.text = "ელ.ფოსტა არ არის ვალიდური"
            return
        }
    
        
        if !viewModel.passwordIsVlid! {
            passwordErrorLabel.text = "აკრიბეთ მინ. 6 და მაქ. 12 სიმბოლო"
            return
        }
        

        viewModel.inputs.logIn(with: email, with: password)
    }
    @objc private func handleShowSignUp(){
        let vc = RegistrationVC()
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
        
        let stackView = UIStackView(arrangedSubviews: [mailTextField,mailErrorLabel,passwordTextField,passwordErrorLabel,loginButton])
        stackView.axis = .vertical
        stackView.spacing = 10
        view.addSubview(stackView)
        stackView.snp.makeConstraints { make in
            make.top.equalTo(view.snp_topMargin).offset(100)
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
        let vc = MainPageVC()
        view.window?.rootViewController = UINavigationController(rootViewController: vc)
    }
}

