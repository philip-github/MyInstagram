//
//  RegistrationViewController.swift
//  Instagram
//
//  Created by Philip Twal on 8/13/22.
//

import FirebaseAuth
import UIKit

class RegistrationViewController: UIViewController {
    
    struct Constants {
        static var cornerRadius = 8.0
    }
    
    private let usernameField: UITextField = {
        let field = UITextField()
        field.placeholder = "Username"
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
    
    private let emailField: UITextField = {
        let field = UITextField()
        field.placeholder = "Email"
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
        field.returnKeyType = .next
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
    
    private let registerButton: UIButton = {
        let button = UIButton()
        button.setTitle("Sign up", for: .normal)
        button.layer.masksToBounds = true
        button.layer.cornerRadius = Constants.cornerRadius
        button.backgroundColor = .systemGreen
        button.setTitleColor(.white, for: .normal)
        button.addTarget(self, action: #selector(registerButtonTapped), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        // Do any additional setup after loading the view.
        usernameField.delegate = self
        emailField.delegate = self
        passwordField.delegate = self
        addSubviews()
    }
    
    override func viewDidLayoutSubviews() {
        
        usernameField.frame = CGRect(x: 25,
                                     y: view.safeAreaInsets.top + 35,
                                     width: view.width - 50,
                                     height: 50)
        
        emailField.frame = CGRect(x: 25,
                                  y: usernameField.bottom + 10,
                                  width: view.width - 50,
                                  height: 50)
        
        passwordField.frame = CGRect(x: 25,
                                     y: emailField.bottom + 10,
                                     width: view.width - 50,
                                     height: 50)
        
        registerButton.frame = CGRect(x: 25,
                                      y: passwordField.bottom + 10,
                                      width: view.width - 50,
                                      height: 50)
    }
    
    func addSubviews(){
        view.addSubview(usernameField)
        view.addSubview(emailField)
        view.addSubview(passwordField)
        view.addSubview(registerButton)
    }
    
    @objc func registerButtonTapped(){
        usernameField.resignFirstResponder()
        emailField.resignFirstResponder()
        passwordField.resignFirstResponder()
        
        guard let username = usernameField.text, !username.isEmpty, let email = emailField.text, !email.isEmpty, let password = passwordField.text, !password.isEmpty, password.count >= 8 else { return }
        
        //register
        AuthManager.shared.registerUser(username: username, email: email, password: password) { [weak self] result in
            DispatchQueue.main.async {
                if result {
                   print(result)
                    self?.dismiss(animated: true, completion: nil)
                }else{
                    let alert = UIAlertController(title: "Error", message: "Failed To Create Account!", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "Dismiss", style: .cancel, handler: nil))
                    self?.present(alert, animated: true)
                    print(result)
                }
            }
        }
    }
}


extension RegistrationViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == usernameField {
            emailField.becomeFirstResponder()
        }
        else if textField == emailField{
            passwordField.becomeFirstResponder()
        }
        else{
            registerButtonTapped()
        }
        return true
    }
}
