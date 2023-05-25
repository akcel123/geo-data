//
//  AddNewEventViewController.swift
//  Geo Data
//
//  Created by Денис Павлов on 13.04.2023.
//

import UIKit

//TODO: - добавить ограничение на количество символов названия

class AddNewEventViewController: UIViewController {

    var presenter: AddNewEventPresenterDelegate?
    
    
    // MARK: - View elements properties
    private lazy var titleLabel = createLabel(title: "Название")
    private lazy var detailsLabel = createLabel(title: "Описание")
    
    private lazy var titleTextField = createTextField(placeholder: "Название события")
    private lazy var detailsTextField = createTextField(placeholder: "Описание события")

//
    let activiryIndicator = UIActivityIndicatorView(style: .large)
    
    private lazy var addButton: UIButton = {
        let button = UIButton()
        
        button.translatesAutoresizingMaskIntoConstraints = false
        // Устанавливаем скругления
        button.layer.cornerRadius = CGFloat(8)
        
        // Устанавливаем цвет фона кнопки
        button.backgroundColor = UIElementsParameters.Color.mainColor
        // добавляем название кнопки
        button.setTitle(title, for: .normal)
        // Редактируем выравнивание текста и цвет текста
        button.titleLabel?.textAlignment = .center
        button.addTarget(self, action: #selector(self.addButtonPress), for: .touchUpInside)
        
        return button
    }()
    
    //MARK: - life cicle
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        let swipeDown = UISwipeGestureRecognizer(target: self, action: #selector(hideKeyboardOnSwipeDown))
        swipeDown.direction =  UISwipeGestureRecognizer.Direction.down
        view.addGestureRecognizer(swipeDown)
        
        setupNavBar()
        setupViews()
        setupConstraints()
        
    }
    
    @objc func hideKeyboardOnSwipeDown() {
        view.endEditing(true)
    }

    @objc private func addButtonPress(arg: UIButton) {
        
        activiryIndicator.center = self.view.center
        activiryIndicator.startAnimating()
        view.addSubview(activiryIndicator)

        presenter?.addNewEvent(title: titleTextField.text ?? "",
                               details: detailsTextField.text ?? "")
    }
    
    


}

// MARK: - AddNewEventViewPresenter
extension AddNewEventViewController: AddNewEventViewPresenter {
    func showSuccessAddEvent() {
        
        activiryIndicator.removeFromSuperview()
        
        let alert = UIAlertController(title: "Событие добавлено",
                                      message: "Ваша заявка отправлена на модерацию", preferredStyle: .alert)
        let cancelActionButton = UIAlertAction(title: "OK", style: .cancel) { [weak self] _ in
            self?.presenter?.buttonSuccessAddedEventDidTapped()
        }
        alert.addAction(cancelActionButton)
        self.present(alert, animated: true)
    }
    
    func showAddNewEventError(error: Error) {
        
        activiryIndicator.removeFromSuperview()
        
        let alert = UIAlertController(title: "Ошибка добавления события",
                                      message: "Ошибка: " + error.localizedDescription, preferredStyle: .alert)
        let cancelActionButton = UIAlertAction(title: "OK", style: .cancel)
        
//        if error == URLError(.userAuthenticationRequired) {
//
//        }
        
        let authButton = UIAlertAction(title: "Авторизация", style: .default) { [weak self] _ in
            self?.presenter?.buttonAuthDidTapped()
            
        }
        alert.addAction(authButton)
        alert.addAction(cancelActionButton)
        
        self.present(alert, animated: true)
        
    }
    

}

// MARK: - UITextFieldDelegate
extension AddNewEventViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        let nextTag: NSInteger = textField.tag + 1
        // Try to find next responder
        guard let nextResponder = textField.superview?.viewWithTag(nextTag) else {
            textField.resignFirstResponder()
            return false
        }
        nextResponder.becomeFirstResponder()
        return false
    }
    
}

// MARK: - setting views
private extension AddNewEventViewController {
    
    func setupNavBar() {
        self.title = "Добавить события"
        view.backgroundColor = .systemBackground
    }
    
    func setupViews() {
        view.addSubviews(subviews: [titleLabel, detailsLabel])
        view.addSubviews(subviews: [titleTextField, detailsTextField])
        view.addSubview(addButton)

        titleTextField.returnKeyType = .next
        titleTextField.tag = 0
        
        detailsTextField.returnKeyType = .next
        detailsTextField.tag = 1
        
        
    }
    
    
    
    func createLabel(title: String) -> UILabel {
        // Создаем объект
        let label = UILabel()
        // разрешаем применение констрейтов
        label.translatesAutoresizingMaskIntoConstraints = false
        // Устанавливаем текст, в нашем случае это название
        label.text = title
        //label.textColor = ItemDetails.Label.textColor
        
        // Устанавливаем шрифт
        label.font = UIFont.systemFont(ofSize: 20, weight: .bold)

        return label
    }

    private func createTextField(placeholder: String) -> UITextField {
        // создаем объект
        let textField = UITextField()
        textField.backgroundColor = .secondarySystemBackground
        textField.translatesAutoresizingMaskIntoConstraints = false
        // добавляем плейсхолдер
        textField.placeholder = placeholder
        // Добавляем кнопку отчищения пока текст есть
        textField.clearButtonMode = UITextField.ViewMode.whileEditing
        // Устанавливаем стиль полей
        textField.borderStyle = .roundedRect
        
        
        return textField
    }
    
    
    
    
}

// MARK: - constraints
private extension AddNewEventViewController {
    func setupConstraints() {
        NSLayoutConstraint.activate([
            titleLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            titleLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            titleLabel.heightAnchor.constraint(equalToConstant: 32),
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            
            titleTextField.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor),
            titleTextField.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            titleTextField.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8),
            titleTextField.heightAnchor.constraint(equalToConstant: UIElementsParameters.heigh),
            
            detailsLabel.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor),
            detailsLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            detailsLabel.heightAnchor.constraint(equalToConstant: 32),
            detailsLabel.topAnchor.constraint(equalTo: titleTextField.bottomAnchor, constant: 8),

            detailsTextField.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor),
            detailsTextField.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            detailsTextField.topAnchor.constraint(equalTo: detailsLabel.bottomAnchor, constant: 8),
            detailsTextField.heightAnchor.constraint(equalToConstant: UIElementsParameters.heigh),
            
            addButton.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor),
            addButton.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            addButton.heightAnchor.constraint(equalToConstant: UIElementsParameters.heigh),
            addButton.topAnchor.constraint(equalTo: detailsTextField.bottomAnchor, constant: 16)
        ])
    }
}

