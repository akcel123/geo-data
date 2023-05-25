//
//  AuthorizationViewController.swift
//  Geo Data
//
//  Created by Денис Павлов on 27.03.2023.
//

import UIKit

// FIXME: При авторизации или выходе из профиля, если мы открыли заранее редактирование события, оно не закроется, надо исправить!!!!!!!!!!!!!


class AuthorizationViewController: UIViewController {

    var presenter: AuthorizationPresenterDelegate?
    

    private lazy var userNameTextField: UITextField = {
        let textField = ProfileTextField(image: "ProfileItem", color: UIElementsParameters.Color.mainColor, placeholder: "Имя пользователя")
        textField.delegate = self
        textField.returnKeyType = .next
        textField.tag = 1
        textField.textContentType = .username
        return textField
    }()
    
    private lazy var passwordTextField: UITextField = {
       let textField = ProfileTextField(image: "PasswordTextFieldIcon", color: UIElementsParameters.Color.mainColor, placeholder: "Пароль")
        textField.returnKeyType = .join
        textField.isSecureTextEntry = true
        textField.tag = 2
        textField.textContentType = .username
        textField.delegate = self
        return textField
    }()

    
    private let authLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Авторизация"
        label.font = UIFont.systemFont(ofSize: 36)
        label.textAlignment = .center
        label.textColor = UIElementsParameters.Color.mainColor
        return label
    }()
    
    private lazy var loginIsEmptyLabel = UILabel().createEmptyTextFieldLabel(text: "Введите имя пользователя")
    private lazy var passwordIsEmptyLabel = UILabel().createEmptyTextFieldLabel(text: "Введите пароль")
    
    private let logInButton = UIButton().createButtonWithTitle("Войти", backgroundColor: UIElementsParameters.Color.mainColor)
    private let registrationButton =  UIButton().createButtonWithTitle("Регистрация", backgroundColor: UIElementsParameters.Color.semiMainColor)
        
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
        
            
            
            authLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 30),
            authLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -27),
            authLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 27),
            
            userNameTextField.topAnchor.constraint(equalTo: authLabel.bottomAnchor, constant: 23),
            userNameTextField.trailingAnchor.constraint(equalTo: authLabel.trailingAnchor),
            userNameTextField.leadingAnchor.constraint(equalTo: authLabel.leadingAnchor),
            userNameTextField.heightAnchor.constraint(equalToConstant: UIElementsParameters.heigh),
            
            loginIsEmptyLabel.topAnchor.constraint(equalTo: userNameTextField.bottomAnchor),
            loginIsEmptyLabel.trailingAnchor.constraint(equalTo: userNameTextField.trailingAnchor),
            loginIsEmptyLabel.leadingAnchor.constraint(equalTo: authLabel.leadingAnchor, constant: UIElementsParameters.heigh / 2),
            
            passwordTextField.topAnchor.constraint(equalTo: loginIsEmptyLabel.bottomAnchor, constant: 4),
            passwordTextField.trailingAnchor.constraint(equalTo: authLabel.trailingAnchor),
            passwordTextField.leadingAnchor.constraint(equalTo: authLabel.leadingAnchor),
            passwordTextField.heightAnchor.constraint(equalToConstant: UIElementsParameters.heigh),
            
            passwordIsEmptyLabel.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor),
            passwordIsEmptyLabel.trailingAnchor.constraint(equalTo: passwordTextField.trailingAnchor),
            passwordIsEmptyLabel.leadingAnchor.constraint(equalTo: authLabel.leadingAnchor, constant: UIElementsParameters.heigh / 2),
            
        
            logInButton.topAnchor.constraint(equalTo: passwordIsEmptyLabel.bottomAnchor, constant: 22),
            logInButton.trailingAnchor.constraint(equalTo: authLabel.trailingAnchor),
            logInButton.leadingAnchor.constraint(equalTo: authLabel.leadingAnchor),
            logInButton.heightAnchor.constraint(equalToConstant: UIElementsParameters.heigh),
            
            registrationButton.topAnchor.constraint(equalTo: logInButton.bottomAnchor, constant: 16),
            registrationButton.trailingAnchor.constraint(equalTo: authLabel.trailingAnchor),
            registrationButton.leadingAnchor.constraint(equalTo: authLabel.leadingAnchor),
            registrationButton.heightAnchor.constraint(equalToConstant: UIElementsParameters.heigh)
        
        ])
    }
}

