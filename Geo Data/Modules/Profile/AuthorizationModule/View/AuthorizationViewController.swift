//
//  AuthorizationViewController.swift
//  Geo Data
//
//  Created by Денис Павлов on 27.03.2023.
//

import UIKit

// TODO: необходимо добавить элемент, показывающий процесс авторизации!!!!!!!!!!!


class AuthorizationViewController: UIViewController {

    var presenter: AuthorizationPresenterDelegate?
    
    private lazy var userNameTextField: UITextField = {
        let textField = UITextField()
        textField.backgroundColor = .secondarySystemBackground
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.delegate = self
        textField.borderStyle = .roundedRect
        textField.placeholder = "Login"
        textField.returnKeyType = .next
        textField.clearButtonMode = .whileEditing
        textField.tag = 1
        textField.textContentType = .username
        return textField
    }()
    
    private lazy var passwordTextField: UITextField = {
        let textField = UITextField()
        textField.backgroundColor = .secondarySystemBackground
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.delegate = self
        textField.borderStyle = .roundedRect
        textField.placeholder = "Password"
        textField.returnKeyType = .join
        textField.autocorrectionType = .no
        textField.clearButtonMode = .whileEditing
        textField.textContentType = .password
        textField.isSecureTextEntry = true
        textField.tag = 2
        return textField
    }()
    
    private let authLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Авторизация"
        label.font = UIFont.systemFont(ofSize: 18)
        label.textAlignment = .center
        return label
    }()
    
    private lazy var loginIsEmptyLabel: UILabel = createEmptyTextFieldLabel(text: "Введите логин")
    private lazy var passwordIsEmptyLabel: UILabel = createEmptyTextFieldLabel(text: "Введите пароль")
    
    private let logInButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Войти", for: .normal)
        button.backgroundColor = .systemGreen
        return button
    }()
    
    private let registrationButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Зарегестрироватсья", for: .normal)
        button.backgroundColor = .systemCyan
        return button
    }()
    
    let activiryIndicator = UIActivityIndicatorView(style: .large)
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupNavBar()
        setupViews()
        setupConstraints()
        
    }
    


}

// MARK: - AuthorizationViewPresenter
extension AuthorizationViewController: AuthorizationViewPresenter {
    func showLogInError(error: Error) {
        activiryIndicator.removeFromSuperview()
        
        loginIsEmptyLabel.alpha = 0
        passwordIsEmptyLabel.alpha = 0
       
        let alert = UIAlertController(title: "Ошибка авторизации",
                                      message: "Ошибка: " + error.localizedDescription, preferredStyle: .alert)
        let cancelActionButton = UIAlertAction(title: "OK", style: .cancel)

        alert.addAction(cancelActionButton)
        self.present(alert, animated: true)
    }
    
    
}

// MARK: - UITextFieldDelegate
extension AuthorizationViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        let nextTag: NSInteger = textField.tag + 1
        guard let nextResponder = textField.superview?.viewWithTag(nextTag) else {
            textField.resignFirstResponder()
            logInButtonTapped()
            return false
        }
        nextResponder.becomeFirstResponder()
        return false
    }
    
    
}


// MARK: - setting views
private extension AuthorizationViewController {
    
    func setupNavBar() {
        view.backgroundColor = .systemBackground
    }
    
    func setupViews() {
        logInButton.addTarget(self, action: #selector(logInButtonTapped), for: .touchUpInside)
        registrationButton.addTarget(self, action: #selector(registerButtonTapped), for: .touchUpInside)

        view.addSubviews(subviews: [userNameTextField, passwordTextField])
        view.addSubviews(subviews: [authLabel, loginIsEmptyLabel, passwordIsEmptyLabel])
        view.addSubview(logInButton)
        view.addSubview(registrationButton)

    }
    
    
    func createEmptyTextFieldLabel(text: String) -> UILabel {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.alpha = 0
        label.text = text
        
        label.font = UIFont.systemFont(ofSize: 6)
        return label
    }
    
    @objc func logInButtonTapped() {
        let userName = userNameTextField.text ?? ""
        let password = passwordTextField.text ?? ""
        guard userName != "", password != "" else {
            loginIsEmptyLabel.alpha = userNameTextField.text == "" ? 1 : 0
            passwordIsEmptyLabel.alpha = passwordTextField.text == "" ? 1 : 0
            return
        }
        
        activiryIndicator.center = view.center
        activiryIndicator.startAnimating()
        view.addSubview(activiryIndicator)
        
        presenter?.logIn(userName: userName, password: password)
    }
    
    @objc func registerButtonTapped() {
        presenter?.register()
    }
    
    
}

// MARK: - constraints
private extension AuthorizationViewController {
    func setupConstraints() {
        NSLayoutConstraint.activate([
        
            
            
            authLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 32),
            authLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -32),
            authLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 32),
            
            userNameTextField.topAnchor.constraint(equalTo: authLabel.bottomAnchor, constant: 8),
            userNameTextField.trailingAnchor.constraint(equalTo: authLabel.trailingAnchor),
            userNameTextField.leadingAnchor.constraint(equalTo: authLabel.leadingAnchor),
            
            loginIsEmptyLabel.topAnchor.constraint(equalTo: userNameTextField.bottomAnchor, constant: 2),
            loginIsEmptyLabel.trailingAnchor.constraint(equalTo: authLabel.trailingAnchor),
            loginIsEmptyLabel.leadingAnchor.constraint(equalTo: authLabel.leadingAnchor),
            
            passwordTextField.topAnchor.constraint(equalTo: loginIsEmptyLabel.bottomAnchor, constant: 4),
            passwordTextField.trailingAnchor.constraint(equalTo: authLabel.trailingAnchor),
            passwordTextField.leadingAnchor.constraint(equalTo: authLabel.leadingAnchor),
            
            passwordIsEmptyLabel.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 2),
            passwordIsEmptyLabel.trailingAnchor.constraint(equalTo: authLabel.trailingAnchor),
            passwordIsEmptyLabel.leadingAnchor.constraint(equalTo: authLabel.leadingAnchor),
            
        
            logInButton.topAnchor.constraint(equalTo: passwordIsEmptyLabel.bottomAnchor, constant: 8),
            logInButton.trailingAnchor.constraint(equalTo: authLabel.trailingAnchor),
            logInButton.leadingAnchor.constraint(equalTo: authLabel.leadingAnchor),
            
            registrationButton.topAnchor.constraint(equalTo: logInButton.bottomAnchor, constant: 8),
            registrationButton.trailingAnchor.constraint(equalTo: authLabel.trailingAnchor),
            registrationButton.leadingAnchor.constraint(equalTo: authLabel.leadingAnchor)
        
        ])
    }
}

