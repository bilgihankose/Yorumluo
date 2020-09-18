//
//  LoginVC.swift
//  Yorumluo
//
//  Created by Bilgihan Köse on 17.09.2020.
//

import UIKit

class LoginVC: UIViewController {
    
    //MARK: -UI Elements
    
    let logoImageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFit
        iv.clipsToBounds = true
        iv.image = #imageLiteral(resourceName: "TwitterLogo")
       return iv
    }()
    
    
    lazy var emailContainerView: UIView = {
        
        let view = Utilities().inputContainerView(with: #imageLiteral(resourceName: "ic_mail_outline_white_2x-1"), textField: emailTextFiled)
        
        return view
    }()
    
    
    lazy var passwordContainerView: UIView = {
     
        let view = Utilities().inputContainerView(with: #imageLiteral(resourceName: "ic_lock_outline_white_2x"), textField: passwordTextFiled)
        
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
    
    
    
    
    private let loginButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Log In", for: .normal)
        button.setTitleColor(.twitterBlue, for: .normal)
        button.backgroundColor = .white
        button.heightAnchor.constraint(lessThanOrEqualToConstant: 50).isActive = true
        button.layer.cornerRadius = 5
        button.titleLabel?.font = .boldSystemFont(ofSize: 20)
        button.addTarget(self, action: #selector(handleLogin), for: .touchUpInside)
        return button
    }()
    
    
    private let dontHaveAccountButton: UIButton = {
        let button = Utilities().attributedButton("Don't have an account? ", "Sign Up")
        button.addTarget(self, action: #selector(handleSignUp), for: .touchUpInside)
        return button
    }()
    
    
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configureUI()
        
    }
    
    
    
    //MARK: - Button Targets
    
    @objc func handleLogin(){
         
        guard let email = emailTextFiled.text else { return }
        guard let password = passwordTextFiled.text else { return }
        
        AuthService.shared.logUserIn(withEmail: email, password: password) { (result, error) in
            if let error = error {
                print(error.localizedDescription)
            }
            
            guard let window = UIApplication.shared.windows.first(where: { $0.isKeyWindow }) else { return }

            guard let tab = UIApplication.shared.keyWindow?.rootViewController as? MainTabController else { return }
            tab.authUserAndConfigureUI()
            
            self.dismiss(animated: true, completion: nil)
            
        }
    }
    
    
    @objc func handleSignUp(){
        let controller = RegistrationVC()
        navigationController?.pushViewController(controller, animated: true)
    }
    
    
    
//MARK: - Configure UI
    
    func configureUI(){
        view.backgroundColor = .twitterBlue
        navigationController?.navigationBar.barStyle = .black
        navigationController?.navigationBar.isHidden = true
        
        view.addSubview(logoImageView)
        logoImageView.centerX(inView: view, topAnchor: view.safeAreaLayoutGuide.topAnchor)
        logoImageView.setDimensions(width: 150, height: 150)
        
        
        let stack = UIStackView(arrangedSubviews: [emailContainerView, passwordContainerView, loginButton])
        stack.axis = .vertical
        stack.spacing = 20
        stack.distribution = .fillEqually
        view.addSubview(stack)
        stack.anchor(top: logoImageView.bottomAnchor, left: view.leftAnchor, right: view.rightAnchor, paddingLeft: 32, paddingRight: 32)
        
        view.addSubview(dontHaveAccountButton)
        dontHaveAccountButton.anchor(left: view.leftAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, right: view.rightAnchor, paddingLeft: 40, paddingRight: 40)
        
        
    }

}
