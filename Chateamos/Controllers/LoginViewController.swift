//
//  LoginViewController.swift
//  Chateamos
//
//  Created by Kirk Abbott on 12/1/22.
//

import Foundation

import UIKit
//import FirebaseCore
import FirebaseAuth
import Firebase


class LoginViewController: UIViewController {
    
    lazy var mainTitle : UILabel = {
        let mTitle = UILabel(frame: .zero)
        mTitle.text = "CHATEAMOS"
        mTitle.translatesAutoresizingMaskIntoConstraints = false
        mTitle.backgroundColor = .black
        mTitle.numberOfLines = 1
        mTitle.textColor = .systemBlue
        mTitle.textAlignment = .center
        
        return mTitle
    }()

    lazy var emailTextField: UITextField = {
        let email = UITextField(frame: .zero)
        email.translatesAutoresizingMaskIntoConstraints = false
        email.text = "kirkabbott1@gmail.com"
        email.backgroundColor = .systemGray6
        email.clearsOnInsertion = true

        
        return email
    }()
    
    lazy var passwordTextField: UITextField = {
        let pass = UITextField(frame: .zero)
        pass.translatesAutoresizingMaskIntoConstraints = false
        pass.text = "kirk12345"
        pass.backgroundColor = .white
        pass.clearsOnInsertion = true
        pass.isSecureTextEntry = true
        
        return pass
    }()
    
    lazy var signInButton: UIButton = {
        let inBtn = UIButton(frame: .zero)
        inBtn.translatesAutoresizingMaskIntoConstraints = false
        inBtn.setTitle("Sign in", for: .normal)
        inBtn.backgroundColor = .blue
        inBtn.addTarget(self, action: #selector(MessageBtnPress), for: .touchUpInside)
        
        
        
        return inBtn
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        createUI()
    }

    func createUI() {
        self.view.addSubview(mainTitle)
        self.view.addSubview(emailTextField)
        self.view.addSubview(passwordTextField)
        self.view.addSubview(signInButton)
        
        self.mainTitle.heightAnchor.constraint(equalToConstant: 64).isActive = true
        self.mainTitle.widthAnchor.constraint(equalToConstant: 84).isActive = true
        self.mainTitle.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 8).isActive = true
        self.mainTitle.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 8).isActive = true
        self.mainTitle.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -8).isActive = true
        self.mainTitle.centerXAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.centerXAnchor).isActive = true

        self.emailTextField.heightAnchor.constraint(equalToConstant: 44).isActive = true
        self.emailTextField.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 8).isActive = true
        self.emailTextField.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: 8).isActive = true
        self.emailTextField.centerXAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.centerXAnchor).isActive = true
        self.emailTextField.centerYAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.centerYAnchor, constant: -26).isActive = true
        
        self.passwordTextField.heightAnchor.constraint(equalToConstant: 44).isActive = true
        self.passwordTextField.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 8).isActive = true
        self.passwordTextField.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: 8).isActive = true
        self.passwordTextField.centerXAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.centerXAnchor).isActive = true
        self.passwordTextField.centerYAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.centerYAnchor, constant: 26).isActive = true
        
        
        self.signInButton.heightAnchor.constraint(equalToConstant: 44).isActive = true
        self.signInButton.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 8).isActive = true
        self.signInButton.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: 8).isActive = true
        self.signInButton.centerXAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.centerXAnchor).isActive = true
        self.signInButton.topAnchor.constraint(equalTo: self.passwordTextField.bottomAnchor, constant: 8).isActive = true
            }
    
    @objc
    func MessageBtnPress() {
        guard let email = emailTextField.text?.lowercased() else {return}
        guard let password = passwordTextField.text?.lowercased() else {return}
        
        Auth.auth().signIn(withEmail: email, password: password) { result, error in
            if let err = error {
                print("error signing in: \(err)")
            } else {
                let navVC = MessageViewController()
                self.navigationController?.pushViewController(navVC, animated: false)
            }
        }
    }

}
