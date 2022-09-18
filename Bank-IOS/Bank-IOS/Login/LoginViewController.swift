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
    
    var leadingEdgeOnScreen:CGFloat = 16
    var leadingEdgeOffScreen:CGFloat = -1000
    
    var titleLeadingAnchor: NSLayoutConstraint? //set the constrain as variable so we can animate it
    var titleTopAnchor: NSLayoutConstraint?
    var topAnchorOffDescript: CGFloat = 16
    var topAnchorOnDescript: CGFloat = 32
    var descriptLeadingAnchor: NSLayoutConstraint?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        style()
        layout()
        //MARK: - To Be Deleted
        loginView.usernameTextField.text = "A"
        loginView.passwordTextField.text = "b"
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        animate()
    }
    override func viewDidDisappear(_ animated: Bool) {
        signInbotton.configuration?.showsActivityIndicator = false
        loginView.usernameTextField.text = ""
        loginView.passwordTextField.text = ""
    }
    
    
}

extension LoginViewController {
    private func style() {        bankeyLabel.translatesAutoresizingMaskIntoConstraints = false
        bankeyLabel.text = "Bankey"
        bankeyLabel.font = .boldSystemFont(ofSize: 60)
        bankeyLabel.alpha = 0
        
        descriptLabel.translatesAutoresizingMaskIntoConstraints = false
        descriptLabel.text = "Your premium source for all things banking"
        descriptLabel.numberOfLines = 0
        descriptLabel.alpha = 0
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.spacing = 16
        stackView.axis = .vertical
        loginView.translatesAutoresizingMaskIntoConstraints = false
        
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
        view.addSubview(bankeyLabel)
        view.addSubview(descriptLabel)
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
        //BankeyLabel
        NSLayoutConstraint.activate([
            bankeyLabel.trailingAnchor.constraint(equalTo: stackView.trailingAnchor)
//            descriptLabel.topAnchor.constraint(equalToSystemSpacingBelow: bankeyLabel.bottomAnchor, multiplier: 4),
            
        ])
        titleTopAnchor = descriptLabel.topAnchor.constraint(equalTo: bankeyLabel.bottomAnchor, constant: topAnchorOffDescript)
        titleTopAnchor?.isActive = true
        titleLeadingAnchor = bankeyLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: leadingEdgeOffScreen)
        titleLeadingAnchor?.isActive = true
        bankeyLabel.textAlignment = .center
        NSLayoutConstraint.activate([
//            descriptLabel.leadingAnchor.constraint(equalToSystemSpacingAfter: stackView.leadingAnchor, multiplier: 3 ),
            stackView.trailingAnchor.constraint(equalToSystemSpacingAfter: descriptLabel.trailingAnchor, multiplier: 3),
            stackView.topAnchor.constraint(equalToSystemSpacingBelow: descriptLabel.bottomAnchor, multiplier: 4)
        ])
        descriptLeadingAnchor = descriptLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: leadingEdgeOffScreen)
        descriptLeadingAnchor?.isActive = true
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

//MARK: - Animations
extension LoginViewController {
    private func animate() {
        let duration = 1.0
    
        let animator1 = UIViewPropertyAnimator(duration: duration, curve: .easeInOut) {
            self.titleLeadingAnchor?.constant = self.leadingEdgeOnScreen
            self.view.layoutIfNeeded() //must add else it will not animate
        }
        animator1.startAnimation()
        let animator2 = UIViewPropertyAnimator(duration: duration, curve: .easeInOut) {
            self.descriptLeadingAnchor?.constant = self.leadingEdgeOnScreen
            self.view.layoutIfNeeded()
        }
        animator2.startAnimation(afterDelay: duration/4)
        let animator3 = UIViewPropertyAnimator(duration: duration*2, curve: .easeInOut) {
            self.bankeyLabel.alpha = 1
            self.descriptLabel.alpha = 1
            self.titleTopAnchor?.constant = self.topAnchorOnDescript
            self.view.layoutIfNeeded()
        }
        animator3.startAnimation()
    }
}

