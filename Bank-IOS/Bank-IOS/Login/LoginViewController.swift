//
//  ViewController.swift
//  Bank-IOS
//
//  Created by Huang Yan on 9/3/22.
//

import UIKit

protocol logoutDelegate: AnyObject {
    func didLogout()
}

protocol LoginViewControllerDelegate: AnyObject {
    func didLogin(_ sender: LoginViewController) // pass data
}


class LoginViewController: UIViewController {
    weak var delegate: LoginViewControllerDelegate?
    let bankeyLabel = UILabel()
    let descriptLabel = UILabel()
    let stackView = UIStackView()
    let loginView = LoginView() //username & password
    let signInbotton = UIButton(type: .system)
    let errorMessageLabel = UILabel()
    
    var username: String? {
        return loginView.usernameTextField.text
    }
    var password: String? {
        return loginView.passwordTextField.text
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        style()
        layout()
        
    }
    override func viewDidDisappear(_ animated: Bool) {
        signInbotton.configuration?.showsActivityIndicator = false
        loginView.usernameTextField.text = ""
        loginView.passwordTextField.text = ""
    }
    
    
}

extension LoginViewController {
    private func style() {
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.spacing = 16
        stackView.axis = .vertical
        loginView.translatesAutoresizingMaskIntoConstraints = false
        
        bankeyLabel.translatesAutoresizingMaskIntoConstraints = false
        bankeyLabel.text = "Bankey"
        bankeyLabel.font = .boldSystemFont(ofSize: 60)
        
        
        descriptLabel.translatesAutoresizingMaskIntoConstraints = false
        descriptLabel.text = "Your premium source for all things banking"
        descriptLabel.numberOfLines = 0
        
        signInbotton.translatesAutoresizingMaskIntoConstraints = false
        signInbotton.configuration = .filled()
        signInbotton.configuration?.imagePadding = 8
        signInbotton.setTitle("Sign In", for: [])
        signInbotton.addTarget(self, action: #selector(signInTapped), for: .primaryActionTriggered)
        
        errorMessageLabel.translatesAutoresizingMaskIntoConstraints = false
        errorMessageLabel.textColor = .systemRed
        errorMessageLabel.textAlignment = .center
        errorMessageLabel.numberOfLines = 0
    }
    private func layout() {
        stackView.addSubview(bankeyLabel)
        stackView.addSubview(descriptLabel)
        view.addSubview(stackView)
        view.addSubview(errorMessageLabel)
        stackView.addArrangedSubview(loginView)
        stackView.addArrangedSubview(signInbotton)
        //stackView
        NSLayoutConstraint.activate([
            //stackView constains
            stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            stackView.leadingAnchor.constraint(equalToSystemSpacingAfter: view.leadingAnchor, multiplier: 2),//eight points after
            view.trailingAnchor.constraint(equalToSystemSpacingAfter: stackView.trailingAnchor, multiplier: 2),//reverse order
            
        ])
        //errorLabel
        NSLayoutConstraint.activate([
            errorMessageLabel.topAnchor.constraint(equalToSystemSpacingBelow: stackView.bottomAnchor, multiplier: 2),
            errorMessageLabel.leadingAnchor.constraint(equalTo: stackView.leadingAnchor),
            errorMessageLabel.trailingAnchor.constraint(equalTo: stackView.trailingAnchor)
        ])
        NSLayoutConstraint.activate([
            bankeyLabel.leadingAnchor.constraint(equalTo: stackView.leadingAnchor),
            bankeyLabel.trailingAnchor.constraint(equalTo: stackView.trailingAnchor),
            descriptLabel.topAnchor.constraint(equalToSystemSpacingBelow: bankeyLabel.bottomAnchor, multiplier: 4),
            
        ])
        bankeyLabel.textAlignment = .center
        NSLayoutConstraint.activate([

            descriptLabel.leadingAnchor.constraint(equalToSystemSpacingAfter: stackView.leadingAnchor, multiplier: 3 ),
            stackView.trailingAnchor.constraint(equalToSystemSpacingAfter: descriptLabel.trailingAnchor, multiplier: 3),
            stackView.topAnchor.constraint(equalToSystemSpacingBelow: descriptLabel.bottomAnchor, multiplier: 2)
        ])
        descriptLabel.textAlignment = .center
    }
}

//MARK: - Actions
extension LoginViewController {
    @objc func signInTapped() {
        login()
    }
    private func login() {
        guard let username = username, let password = password else {
            assertionFailure("Username/Password should never be nil") // a bug in development site
            return
        }
        if username.isEmpty || password.isEmpty {
            configureView(withMessage: "Username/Password can not be blank")
            return
        }
        if username == "A" && password == "b" {
            errorMessageLabel.text = ""
            signInbotton.configuration?.showsActivityIndicator = true
            delegate?.didLogin(self)
        } else {
            configureView(withMessage: "Incorrect Username/Password")
        }
        
    }
    private func configureView(withMessage message: String) {
        errorMessageLabel.text = message
        errorMessageLabel.isHidden = false
    }
}



