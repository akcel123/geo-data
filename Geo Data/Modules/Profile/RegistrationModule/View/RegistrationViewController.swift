//
//  RegistrationViewController.swift
//  Geo Data
//
//  Created by Денис Павлов on 27.03.2023.
//

import UIKit

class RegistrationViewController: UIViewController {

    var presenter: RegistrationPresenterDelegate?
    
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
        textField.layer.cornerRadius = 8
        return textField
    }()
    
    private lazy var emailTextField: UITextField = {
        let textField = UITextField()
        textField.backgroundColor = .secondarySystemBackground
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.delegate = self
        textField.borderStyle = .roundedRect
        textField.placeholder = "E-mail"
        textField.returnKeyType = .next
        textField.clearButtonMode = .whileEditing
        textField.tag = 2
        textField.textContentType = .emailAddress
        textField.keyboardType = .emailAddress
        textField.layer.cornerRadius = 8
        return textField
    }()
    
    private lazy var passwordTextField: UITextField = {
        let textField = UITextField()
        textField.backgroundColor = .secondarySystemBackground
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.delegate = self
        textField.borderStyle = .roundedRect
        textField.placeholder = "Password"
        textField.returnKeyType = .next
        textField.autocorrectionType = .no
        textField.clearButtonMode = .whileEditing
        textField.textContentType = .username
        //textField.textContentType = .password
        textField.isSecureTextEntry = true
        textField.tag = 3
        textField.layer.cornerRadius = 8
        return textField
    }()
    
    private lazy var conformPasswordTextField: UITextField = {
        let textField = UITextField()
        textField.backgroundColor = .secondarySystemBackground
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.delegate = self
        textField.borderStyle = .roundedRect
        textField.placeholder = "Conform Password"
        textField.returnKeyType = .go
        textField.autocorrectionType = .no
        textField.clearButtonMode = .whileEditing
        textField.textContentType = .username
        //textField.textContentType = .password
        textField.isSecureTextEntry = true
        textField.tag = 4
        textField.layer.cornerRadius = 8
        return textField
    }()
    
    private let registrationLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Регистрация"
        label.font = UIFont.systemFont(ofSize: 18)
        label.textAlignment = .center
        return label
    }()
    
    private lazy var loginIsEmptyLabel: UILabel = createEmptyTextFieldLabel(text: "Введите логин")
    private lazy var emailIsEmptyLabel: UILabel = createEmptyTextFieldLabel(text: "Введите E-mail")
    private lazy var passwordIsEmptyLabel: UILabel = createEmptyTextFieldLabel(text: "Введите пароль")
    private lazy var passwordNotConformLabel: UILabel = createEmptyTextFieldLabel(text: "Пароли не совпадают")
    
    private let registrationButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = CGFloat(8)
        button.setTitle("Зарегестрироваться", for: .normal)
        button.backgroundColor = UIElementsParameters.Color.mainColor
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

// MARK: - RegistrationViewPresenter
extension RegistrationViewController: RegistrationViewPresenter {
    func showRegistrationError(error: Error) {
        activiryIndicator.removeFromSuperview()
        let alert = UIAlertController(title: "Ошибка регистрации",
                                      message: "Ошибка: " + error.localizedDescription, preferredStyle: .alert)
        let cancelActionButton = UIAlertAction(title: "OK", style: .cancel)
//        let alertActionButton = UIAlertAction(title: "OK", style: .default) { [weak self] action in
//            self?.navigationController?.popViewController(animated: true)
//        }
//        alert.addAction(alertActionButton)
        alert.addAction(cancelActionButton)
        self.present(alert, animated: true)
    }
    
}

// MARK: - UITextFieldDelegate
extension RegistrationViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        let nextTag: NSInteger = textField.tag + 1
        guard let nextResponder = textField.superview?.viewWithTag(nextTag) else {
            textField.resignFirstResponder()
            registerButtonTapped()
            return false
        }
        nextResponder.becomeFirstResponder()
        return false
    }
    
    
}


// MARK: - setting views
private extension RegistrationViewController {
    
    func setupNavBar() {
        self.title = "Регистрация"
        view.backgroundColor = .systemBackground
    }
    
    func setupViews() {
        registrationButton.addTarget(self, action: #selector(registerButtonTapped), for: .touchUpInside)
        
        view.addSubviews(subviews: [userNameTextField, passwordTextField, emailTextField, conformPasswordTextField])
        view.addSubviews(subviews: [registrationLabel, loginIsEmptyLabel, emailIsEmptyLabel, passwordIsEmptyLabel, passwordNotConformLabel])
        view.addSubview(registrationButton)
    }
    
    
    func createEmptyTextFieldLabel(text: String) -> UILabel {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.alpha = 0
        label.text = text
        label.font = UIFont.systemFont(ofSize: 12)
        return label
    }
    
    @objc func registerButtonTapped() {
        let userName = userNameTextField.text ?? ""
        let password = passwordTextField.text ?? ""
        let email = emailTextField.text ?? ""
        let conformPassword = conformPasswordTextField.text ?? ""
        
        guard userName != "", email != "", password != "" else {
            loginIsEmptyLabel.alpha = userNameTextField.text == "" ? 1 : 0
            passwordIsEmptyLabel.alpha = passwordTextField.text == "" ? 1 : 0
            emailIsEmptyLabel.alpha = emailTextField.text == "" ? 1 : 0
            passwordNotConformLabel.alpha = conformPassword != password ? 1 : 0
            return
        }
        
        guard conformPassword == password else {
            passwordNotConformLabel.alpha = 1
            return
        }
        passwordNotConformLabel.alpha = 0
        activiryIndicator.center = view.center
        activiryIndicator.startAnimating()
        view.addSubview(activiryIndicator)
        presenter?.register(userName: userName, email: email, password: password)
        
    }
    
    
}

// MARK: - constraints
private extension RegistrationViewController {
    func setupConstraints() {
        NSLayoutConstraint.activate([
        
            // TODO: Добавить констрейты для лейбла registrationLabel
            
            registrationLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 32),
            registrationLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -32),
            registrationLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 32),
            
            userNameTextField.topAnchor.constraint(equalTo: registrationLabel.bottomAnchor, constant: 8),
            userNameTextField.trailingAnchor.constraint(equalTo: registrationLabel.trailingAnchor),
            userNameTextField.leadingAnchor.constraint(equalTo: registrationLabel.leadingAnchor),
            userNameTextField.heightAnchor.constraint(equalToConstant: UIElementsParameters.heigh),
            
            loginIsEmptyLabel.topAnchor.constraint(equalTo: userNameTextField.bottomAnchor, constant: 2),
            loginIsEmptyLabel.trailingAnchor.constraint(equalTo: registrationLabel.trailingAnchor),
            loginIsEmptyLabel.leadingAnchor.constraint(equalTo: registrationLabel.leadingAnchor),
            
            emailTextField.topAnchor.constraint(equalTo: loginIsEmptyLabel.bottomAnchor, constant: 4),
            emailTextField.trailingAnchor.constraint(equalTo: registrationLabel.trailingAnchor),
            emailTextField.leadingAnchor.constraint(equalTo: registrationLabel.leadingAnchor),
            emailTextField.heightAnchor.constraint(equalToConstant: UIElementsParameters.heigh),
            
            emailIsEmptyLabel.topAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: 2),
            emailIsEmptyLabel.trailingAnchor.constraint(equalTo: registrationLabel.trailingAnchor),
            emailIsEmptyLabel.leadingAnchor.constraint(equalTo: registrationLabel.leadingAnchor),
            
            passwordTextField.topAnchor.constraint(equalTo: emailIsEmptyLabel.bottomAnchor, constant: 4),
            passwordTextField.trailingAnchor.constraint(equalTo: registrationLabel.trailingAnchor),
            passwordTextField.leadingAnchor.constraint(equalTo: registrationLabel.leadingAnchor),
            passwordTextField.heightAnchor.constraint(equalToConstant: UIElementsParameters.heigh),
            
            passwordIsEmptyLabel.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 2),
            passwordIsEmptyLabel.trailingAnchor.constraint(equalTo: registrationLabel.trailingAnchor),
            passwordIsEmptyLabel.leadingAnchor.constraint(equalTo: registrationLabel.leadingAnchor),
            
            conformPasswordTextField.topAnchor.constraint(equalTo: passwordIsEmptyLabel.bottomAnchor, constant: 4),
            conformPasswordTextField.trailingAnchor.constraint(equalTo: registrationLabel.trailingAnchor),
            conformPasswordTextField.leadingAnchor.constraint(equalTo: registrationLabel.leadingAnchor),
            conformPasswordTextField.heightAnchor.constraint(equalToConstant: UIElementsParameters.heigh),
            
            passwordNotConformLabel.topAnchor.constraint(equalTo: conformPasswordTextField.bottomAnchor, constant: 2),
            passwordNotConformLabel.trailingAnchor.constraint(equalTo: registrationLabel.trailingAnchor),
            passwordNotConformLabel.leadingAnchor.constraint(equalTo: registrationLabel.leadingAnchor),
        
            registrationButton.topAnchor.constraint(equalTo: passwordNotConformLabel.bottomAnchor, constant: 8),
            registrationButton.trailingAnchor.constraint(equalTo: registrationLabel.trailingAnchor),
            registrationButton.leadingAnchor.constraint(equalTo: registrationLabel.leadingAnchor),
            registrationButton.heightAnchor.constraint(equalToConstant: UIElementsParameters.heigh)
        
        ])
    }
}

