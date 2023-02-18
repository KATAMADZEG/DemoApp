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
    
    lazy var plusPhotoButton : UIButton = {
        let button = UIButton(type: .system)
        button.setImage(#imageLiteral(resourceName: "plus_photo"), for: .normal)
        button.tintColor = .white
        button.addTarget(self, action: #selector(handleSetProfilePhoto), for: .touchUpInside)
        return button
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
    private let fullNameTextField = CustomTextField(placeholder: "Fullname")
    private let UserNameTextField = CustomTextField(placeholder: "Username")
    
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
              let username = UserNameTextField.text,
              let fullname = fullNameTextField.text,
              let profileImage = profileImage
        else {return}
        let credential = AuthCredentials(email: email,
                                         password: password,
                                         fullname: fullname,
                                         username: username,
                                         profileImage: profileImage)
        
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
        case sender == UserNameTextField:
            viewModel.username = sender.text
        case sender == fullNameTextField:
            viewModel.fullname = sender.text
        default:
            break
        }
        updateForm()
    }
    @objc private func handleSetProfilePhoto () {
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.allowsEditing = true
        present(picker, animated: true, completion: nil)
    }
    //MARK: - Helpers

    private func configureUI(){
        view.backgroundColor = .white
        configureGradientLayer()
        view.addSubview(plusPhotoButton)
        plusPhotoButton.snp.makeConstraints { make in
            make.width.height.equalTo(140)
            make.centerX.equalTo(view)
            make.top.equalTo(view.safeAreaLayoutGuide).inset(32)
        }
        let stackView = UIStackView(arrangedSubviews: [mailTextField,passwordTextField,fullNameTextField,UserNameTextField,signUpButton])
        stackView.axis = .vertical
        stackView.spacing = 20
        view.addSubview(stackView)
        stackView.snp.makeConstraints { make in
            make.centerX.equalTo(plusPhotoButton)
            make.top.equalTo(plusPhotoButton.snp_bottomMargin).offset(32)
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
        UserNameTextField.addTarget(self, action: #selector(textDidChange), for: .editingChanged)
        fullNameTextField.addTarget(self, action: #selector(textDidChange), for: .editingChanged)
    }
}

extension RegistrationVC : FormViewModel {
    func updateForm() {
        signUpButton.backgroundColor = viewModel.buttonBackgroundColor
        signUpButton.titleLabel?.textColor = viewModel.buttonTitleColor
        signUpButton.isEnabled = viewModel.formIsValid
    }
}

extension RegistrationVC : UIImagePickerControllerDelegate,UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let selectedPhoto = info[.editedImage] as? UIImage else {return}
        profileImage = selectedPhoto
        plusPhotoButton.setImage(selectedPhoto.withRenderingMode(.alwaysOriginal), for: .normal)
        plusPhotoButton.layer.cornerRadius = plusPhotoButton.frame.height/2
        plusPhotoButton.clipsToBounds = true
        plusPhotoButton.layer.borderColor = UIColor.white.cgColor
        plusPhotoButton.layer.borderWidth = 2
        dismiss(animated: true, completion: nil)
    }
}
