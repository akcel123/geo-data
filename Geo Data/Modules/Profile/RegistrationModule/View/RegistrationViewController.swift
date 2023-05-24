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
        let textField = ProfileTextField(image: "ProfileItem", color: UIElementsParameters.Color.semiMainColor, placeholder: "Имя пользователя")
        textField.delegate = self
        textField.returnKeyType = .next
        textField.tag = 1
        textField.textContentType = .username
        textField.autocorrectionType = .no
        return textField
    }()

    private lazy var emailTextField: UITextField = {
        let textField = ProfileTextField(image: "EmailTextFieldIcon", color: UIElementsParameters.Color.semiMainColor, placeholder: "E-mail")
        textField.delegate = self
        textField.returnKeyType = .next
        textField.tag = 2
        textField.textContentType = .emailAddress
        textField.keyboardType = .emailAddress
        textField.autocorrectionType = .no
        return textField
    }()
    

    private lazy var passwordTextField: UITextField = {
       let textField = ProfileTextField(image: "PasswordTextFieldIcon", color: UIElementsParameters.Color.semiMainColor, placeholder: "Пароль")
        textField.returnKeyType = .next
        textField.isSecureTextEntry = true
        textField.tag = 3
        textField.autocorrectionType = .no
        textField.textContentType = .username
        textField.delegate = self
        return textField
    }()
    
    private lazy var conformPasswordTextField: UITextField = {
       let textField = ProfileTextField(image: "PasswordTextFieldIcon", color: UIElementsParameters.Color.semiMainColor, placeholder: "Пароль")
        textField.returnKeyType = .go
        textField.isSecureTextEntry = true
        textField.tag = 4
        textField.autocorrectionType = .no
        textField.textContentType = .username
        textField.delegate = self
        return textField
    }()
    
    
    private let registrationLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Регистрация"
        label.font = .boldSystemFont(ofSize: 18)
        //label.font = UIFont.systemFont(ofSize: 18)
        label.textAlignment = .center
        label.textColor = UIElementsParameters.Color.semiMainColor
        return label
    }()
    
    private lazy var loginIsEmptyLabel: UILabel = UILabel().createEmptyTextFieldLabel(text: "Введите имя пользователя")
    private lazy var emailIsEmptyLabel: UILabel = UILabel().createEmptyTextFieldLabel(text: "Введите E-mail")
    private lazy var passwordIsEmptyLabel: UILabel = UILabel().createEmptyTextFieldLabel(text: "Введите пароль")
    private lazy var passwordNotConformLabel: UILabel = UILabel().createEmptyTextFieldLabel(text: "Пароли не совпадают")

    
    private let registrationButton = UIButton().createButtonWithTitle("Зарегистрироваться", backgroundColor: UIElementsParameters.Color.semiMainColor)

    
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
            registrationLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -27),
            registrationLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 27),
            
            userNameTextField.topAnchor.constraint(equalTo: registrationLabel.bottomAnchor, constant: 8),
            userNameTextField.trailingAnchor.constraint(equalTo: registrationLabel.trailingAnchor),
            userNameTextField.leadingAnchor.constraint(equalTo: registrationLabel.leadingAnchor),
            userNameTextField.heightAnchor.constraint(equalToConstant: UIElementsParameters.heigh),
            
            loginIsEmptyLabel.topAnchor.constraint(equalTo: userNameTextField.bottomAnchor),
            loginIsEmptyLabel.trailingAnchor.constraint(equalTo: userNameTextField.trailingAnchor),
            loginIsEmptyLabel.leadingAnchor.constraint(equalTo: userNameTextField.leadingAnchor, constant: UIElementsParameters.heigh / 2),
            
            emailTextField.topAnchor.constraint(equalTo: loginIsEmptyLabel.bottomAnchor, constant: 4),
            emailTextField.trailingAnchor.constraint(equalTo: registrationLabel.trailingAnchor),
            emailTextField.leadingAnchor.constraint(equalTo: registrationLabel.leadingAnchor),
            emailTextField.heightAnchor.constraint(equalToConstant: UIElementsParameters.heigh),
            
            emailIsEmptyLabel.topAnchor.constraint(equalTo: emailTextField.bottomAnchor),
            emailIsEmptyLabel.trailingAnchor.constraint(equalTo: emailTextField.trailingAnchor),
            emailIsEmptyLabel.leadingAnchor.constraint(equalTo: emailTextField.leadingAnchor, constant: UIElementsParameters.heigh / 2),
            
            passwordTextField.topAnchor.constraint(equalTo: emailIsEmptyLabel.bottomAnchor, constant: 4),
            passwordTextField.trailingAnchor.constraint(equalTo: registrationLabel.trailingAnchor),
            passwordTextField.leadingAnchor.constraint(equalTo: registrationLabel.leadingAnchor),
            passwordTextField.heightAnchor.constraint(equalToConstant: UIElementsParameters.heigh),
            
            passwordIsEmptyLabel.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor),
            passwordIsEmptyLabel.trailingAnchor.constraint(equalTo: registrationLabel.trailingAnchor),
            passwordIsEmptyLabel.leadingAnchor.constraint(equalTo: registrationLabel.leadingAnchor, constant: UIElementsParameters.heigh / 2),
            
            conformPasswordTextField.topAnchor.constraint(equalTo: passwordIsEmptyLabel.bottomAnchor, constant: 4),
            conformPasswordTextField.trailingAnchor.constraint(equalTo: registrationLabel.trailingAnchor),
            conformPasswordTextField.leadingAnchor.constraint(equalTo: registrationLabel.leadingAnchor),
            conformPasswordTextField.heightAnchor.constraint(equalToConstant: UIElementsParameters.heigh),
            
            passwordNotConformLabel.topAnchor.constraint(equalTo: conformPasswordTextField.bottomAnchor),
            passwordNotConformLabel.trailingAnchor.constraint(equalTo: registrationLabel.trailingAnchor),
            passwordNotConformLabel.leadingAnchor.constraint(equalTo: registrationLabel.leadingAnchor, constant: UIElementsParameters.heigh / 2),
        
            registrationButton.topAnchor.constraint(equalTo: passwordNotConformLabel.bottomAnchor, constant: 22),
            registrationButton.trailingAnchor.constraint(equalTo: registrationLabel.trailingAnchor),
            registrationButton.leadingAnchor.constraint(equalTo: registrationLabel.leadingAnchor),
            registrationButton.heightAnchor.constraint(equalToConstant: UIElementsParameters.heigh)
        
        ])
    }
}

