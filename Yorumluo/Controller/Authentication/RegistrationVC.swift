//
//  RegistrationVC.swift
//  Yorumluo
//
//  Created by Bilgihan Köse on 17.09.2020.
//

import UIKit
import Firebase

class RegistrationVC: UIViewController {
   
    
    //MARK: -UI Elements
    
    private let imagePicker  = UIImagePickerController()
    
    private let registrationButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Sign Up", for: .normal)
        button.setTitleColor(.twitterBlue, for: .normal)
        button.backgroundColor = .white
        button.heightAnchor.constraint(lessThanOrEqualToConstant: 50).isActive = true
        button.layer.cornerRadius = 5
        button.titleLabel?.font = .boldSystemFont(ofSize: 20)
        button.addTarget(self, action: #selector(handleRegister), for: .touchUpInside)
        return button
    }()
    
    
    private let plusPhotoButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(named: "plus_photo"), for: .normal)
        button.tintColor = .white
        button.addTarget(self, action: #selector(handleAddProfilePhoto), for: .touchUpInside)
        
        return button
    }()
    
    private let alreadyHaveAccountButton: UIButton = {
        let button = Utilities().attributedButton("Already have an account? ", "Sign In")
        button.addTarget(self, action: #selector(handleShowLogin), for: .touchUpInside)
        return button
    }()
    
    
    lazy var emailContainerView: UIView = {
        
        let view = Utilities().inputContainerView(with: #imageLiteral(resourceName: "ic_mail_outline_white_2x-1"), textField: emailTextFiled)
        
        return view
    }()
    
    
    lazy var passwordContainerView: UIView = {
     
        let view = Utilities().inputContainerView(with: #imageLiteral(resourceName: "ic_lock_outline_white_2x"), textField: passwordTextFiled)
        
        return view
    }()
    
    lazy var fullnameContainerView: UIView = {
        
        let view = Utilities().inputContainerView(with: #imageLiteral(resourceName: "ic_person_outline_white_2x"), textField: fullnameTextFiled)
        
        return view
    }()
    
    
    lazy var usernameContainerView: UIView = {
     
        let view = Utilities().inputContainerView(with: #imageLiteral(resourceName: "ic_person_outline_white_2x"), textField: usernameTextFiled)
        
        return view
    }()
    
    private let emailTextFiled: UITextField = {
        let tf = Utilities().textField(with: "Email")
        tf.keyboardType = .emailAddress
        return tf
    }()
    
    private let passwordTextFiled: UITextField = {
        let tf = Utilities().textField(with: "Password")
        tf.isSecureTextEntry = true
        return tf
    }()
    
    private let fullnameTextFiled: UITextField = {
        let tf = Utilities().textField(with: "Full Name")
        tf.keyboardType = .emailAddress
        return tf
    }()
    
    private let usernameTextFiled: UITextField = {
        let tf = Utilities().textField(with: "Username")
        return tf
    }()
    
    
    //MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

        configureUI()
        
    }
    
    
    //MARK: - Button Targets
    
    @objc func handleShowLogin(){
        navigationController?.popViewController(animated: true)
    }
    
    @objc func handleAddProfilePhoto(){
        present(imagePicker, animated: true, completion: nil)
        
    }

    @objc func  handleRegister(){
        guard let email = emailTextFiled.text else { return }
        guard let password = passwordTextFiled.text else { return }
        guard let fullname = fullnameTextFiled.text else { return }
        guard let username = usernameTextFiled.text else { return }
         print("selam")
        let credentials = AuthCredentials(email: email, password: password, fullname: fullname, username: username)
        
        AuthService.shared.registerUser(credentials: credentials) { (error, ref) in
            guard let window = UIApplication.shared.windows.first(where: { $0.isKeyWindow }) else { return }

            guard let tab = UIApplication.shared.keyWindow?.rootViewController as? MainTabController else { return }
            tab.authUserAndConfigureUI()
            
            self.dismiss(animated: true, completion: nil)
        }
        

        
    }
    
    //MARK: - ConfigureUI
    
    func configureUI(){
        view.backgroundColor = .twitterBlue
        
        imagePicker.delegate = self
        
        view.addSubview(plusPhotoButton)
        plusPhotoButton.centerX(inView: view, topAnchor: view.safeAreaLayoutGuide.topAnchor)
        plusPhotoButton.setDimensions(width: 150, height: 150)
        
        
        let stack = UIStackView(arrangedSubviews: [emailContainerView, passwordContainerView, fullnameContainerView, usernameContainerView, registrationButton])
        stack.axis = .vertical
        stack.spacing = 20
        stack.distribution = .fillEqually
        view.addSubview(stack)
        stack.anchor(top: plusPhotoButton.bottomAnchor, left: view.leftAnchor, right: view.rightAnchor, paddingLeft: 32, paddingRight: 32)
        
        
        
        view.addSubview(alreadyHaveAccountButton)
        alreadyHaveAccountButton.anchor(left: view.leftAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, right: view.rightAnchor, paddingLeft: 40, paddingRight: 40)
        
    }
}


extension RegistrationVC: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let profileImage = info[.editedImage] as? UIImage else {return}
        
        
        plusPhotoButton.layer.cornerRadius = 128 / 2
        plusPhotoButton.layer.masksToBounds = true
        plusPhotoButton.imageView?.contentMode = .scaleAspectFill
        plusPhotoButton.imageView?.clipsToBounds = true
        plusPhotoButton.layer.borderColor = UIColor.white.cgColor
        
        
        self.plusPhotoButton.setImage(profileImage.withRenderingMode(.alwaysOriginal), for: .normal)
        
        dismiss(animated: true, completion: nil)
    }
    
}
