//
//  LoginViewController.swift
//  Instagram
//
//  Created by Philip Twal on 8/13/22.
//

import SafariServices
import UIKit

class LoginViewController: UIViewController {
    
    struct Constants {
        static let cornerRadius = 8.0
    }
    
    private let headerView: UIView = {
        let view = UIView()
        view.clipsToBounds = true
        let imageView = UIImageView(image: UIImage(named: "gradient"))
        view.addSubview(imageView)
        return view
    }()
    
    private let usernameField: UITextField = {
        let field = UITextField()
        field.placeholder = "Username or Email"
        field.returnKeyType = .next
        field.leftViewMode = .always
        field.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 0))
        field.autocapitalizationType = .none
        field.autocorrectionType = .no
        field.layer.masksToBounds = true
        field.layer.cornerRadius = Constants.cornerRadius
        field.backgroundColor = .secondarySystemBackground
        field.layer.borderWidth = 1.0
        field.layer.borderColor = UIColor.secondaryLabel.cgColor
        return field
    }()
    
    private let passwordField: UITextField = {
        let field = UITextField()
        field.placeholder = "Password"
        field.autocapitalizationType = .none
        field.returnKeyType = .continue
        field.leftViewMode = .always
        field.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 0))
        field.autocorrectionType = .no
        field.layer.masksToBounds = true
        field.isSecureTextEntry = true
        field.layer.cornerRadius = Constants.cornerRadius
        field.backgroundColor = .secondarySystemBackground
        field.layer.borderWidth = 1.0
        field.layer.borderColor = UIColor.secondaryLabel.cgColor
        return field
    }()
    
    private let loginButton: UIButton = {
        let button = UIButton()
        button.setTitle("Log in", for: .normal)
        button.layer.masksToBounds = true
        button.layer.cornerRadius = Constants.cornerRadius
        button.backgroundColor = .systemBlue
        button.setTitleColor(.white, for: .normal)
        button.addTarget(self, action: #selector(loginButtonTapped), for: .touchUpInside)
        return button
    }()
    
    private let createAccountButton: UIButton = {
        let button = UIButton()
        button.setTitleColor(.label, for: .normal)
        button.setTitle("New User? Create an Account", for: .normal)
        button.setTitleColor(.systemBlue, for: .normal)
        button.addTarget(self, action: #selector(creatAccountButtonTapped), for: .touchUpInside)
        return button
    }()
    
    private let termsButton: UIButton = {
        let button = UIButton()
        button.setTitle("Terms of Use", for: .normal)
        button.setTitleColor(.secondaryLabel, for: .normal)
        button.addTarget(self, action: #selector(termsButtonTapped), for: .touchUpInside)
        return button
    }()
    
    private let privacyButton: UIButton = {
        let button = UIButton()
        button.setTitle("Privacy Policy", for: .normal)
        button.setTitleColor(.secondaryLabel, for: .normal)
        button.addTarget(self, action: #selector(privacyButtonTapped), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        view.backgroundColor = .systemBackground
        usernameField.delegate = self
        passwordField.delegate = self
        addSubview()
    }
    
    func addSubview() {
        view.addSubview(headerView)
        view.addSubview(usernameField)
        view.addSubview(passwordField)
        view.addSubview(loginButton)
        view.addSubview(createAccountButton)
        view.addSubview(termsButton)
        view.addSubview(privacyButton)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        headerView.frame = CGRect(x: 0,
                                  y: 0,
                                  width: view.width,
                                  height: view.height/3)
        
        configureHeaderView()
        
        usernameField.frame = CGRect(x: 25,
                                     y: headerView.bottom + 40,
                                     width: view.width - 50,
                                     height: 52)
        
        passwordField.frame = CGRect(x: 25,
                                     y: usernameField.bottom + 10,
                                     width: view.width - 50,
                                     height: 52)
        
        loginButton.frame = CGRect(x: 25,
                                   y: passwordField.bottom + 20,
                                   width: view.width - 50,
                                   height: 52)
        
        createAccountButton.frame = CGRect(x: 25,
                                           y: loginButton.bottom + 10,
                                           width: view.width - 50,
                                           height: 52)
        
        privacyButton.frame = CGRect(x: 10,
                                     y: view.height-view.safeAreaInsets.bottom-50,
                                     width: view.width-20,
                                     height: 50)
        
        termsButton.frame = CGRect(x: 10,
                                   y: view.height-view.safeAreaInsets.bottom-100,
                                   width: view.width-20,
                                   height: 50)
    }
    
    
    func configureHeaderView(){
        guard headerView.subviews.count == 1 else { return }
        guard let backgroundView = headerView.subviews.first else { return }
        backgroundView.frame = headerView.bounds
        let LogoImageView = UIImageView(image: UIImage(named: "insta-logo"))
        headerView.addSubview(LogoImageView)
        LogoImageView.contentMode = .scaleAspectFit
        
        LogoImageView.frame = CGRect(x: headerView.width/4.0,
                                     y: headerView.safeAreaInsets.top,
                                     width: headerView.width/2.0,
                                     height: headerView.height - headerView.safeAreaInsets.top)
    }
    
    @objc func loginButtonTapped() {
        passwordField.resignFirstResponder()
        usernameField.resignFirstResponder()
        
        guard let usernameEmail = usernameField.text, !usernameEmail.isEmpty, let password = passwordField.text, !password.isEmpty, password.count >= 8 else { return }
        
        // login
        DispatchQueue.main.async {
            var username: String?
            var email: String?
            
            if usernameEmail.contains("@"), usernameEmail.contains("."){
                email = usernameEmail
            }
            else{
                username = usernameEmail
            }
            
            AuthManager.shared.loginUser(username: username, email: email, password: password) { authResult in
                if authResult{
                    self.dismiss(animated: true, completion: nil)
                }else{
                    let alert = UIAlertController(title: "Login Failed", message: "We were unable to log you in", preferredStyle: .alert)
                    
                    alert.addAction(UIAlertAction(title: "Dismiss", style: .cancel, handler: nil))
                    self.present(alert, animated: true)
                }
            }
        }
    }
    
    @objc func creatAccountButtonTapped() {
        let vc = RegistrationViewController()
        vc.title = "Create Account"
        present(UINavigationController(rootViewController: vc), animated: true)
    }
    
    @objc func privacyButtonTapped() {
        guard let url = URL(string: "https://www.instagram.com/terms/accept/?hl=en") else { return}
        let vc = SFSafariViewController(url: url)
        present(vc, animated: true)
    }
    
    @objc func termsButtonTapped() {
        guard let url = URL(string: "https://help.instagram.com/581066165581870") else { return}
        let vc = SFSafariViewController(url: url)
        present(vc, animated: true)
    }
}


extension LoginViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == usernameField {
            passwordField.becomeFirstResponder()
        }
        if textField == passwordField{
            loginButtonTapped()
        }
        return true
    }
}
