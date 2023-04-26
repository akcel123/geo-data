//
//  EditEventViewController.swift
//  Geo Data
//
//  Created by Денис Павлов on 26.04.2023.
//

import UIKit

class EditEventViewController: UIViewController {

    
    var presenter: EditEventPresenterDelegate?
    
    // MARK: - View elements properties
    private lazy var titleLabel = createLabel(title: "Название")
    private lazy var detailsLabel  = createLabel(title: "Описание")
    private lazy var latitudeLabel  = createLabel(title: "Широта")
    private lazy var longitudeLabel  = createLabel(title: "Долгота")
    private lazy var isCheckedLabel  = createLabel(title: "Подтвержденное событие")
   
    
    private lazy var titleTextField = createTextField()
    // TODO: - Заменить на UITextView
    private lazy var detailsTextField = createTextField()
    private lazy var latitudeTextField = createTextField()
    private lazy var longitudeTextField = createTextField()
    private lazy var isCheckedSwitch: UISwitch = {
        let isCheckedSwitch = UISwitch()
        isCheckedSwitch.translatesAutoresizingMaskIntoConstraints = false
        
        return isCheckedSwitch
    }()
    private lazy var editButton: UIButton = {
        let button = UIButton()
        
        button.translatesAutoresizingMaskIntoConstraints = false
        // Устанавливаем скругления
        button.layer.cornerRadius = CGFloat(32 / 2)
        // Устанавливаем цвет фона кнопки
        button.backgroundColor = .systemCyan
        // добавляем название кнопки
        button.setTitle(title, for: .normal)
        // Редактируем выравнивание текста и цвет текста
        button.titleLabel?.textAlignment = .center
        button.titleLabel?.textColor = .systemGray
        button.addTarget(self, action: #selector(self.addButtonPress), for: .touchUpInside)
        
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

// MARK: - setting view
private extension EditEventViewController {
    
    func setupNavBar() {
        self.title = "Редактирование события"
    }
    
    func setupViews() {
        view.backgroundColor = .systemBackground

        titleTextField.returnKeyType = .next
        titleTextField.tag = 0
        
        detailsTextField.returnKeyType = .next
        detailsTextField.tag = 1
        
        // Клавиатура - цифры и точка
        //latitudeTextField.keyboardType = .decimalPad
        // У данной клавиатуры нет клавиши return, соответственно мы не можем добавить кнопку "далее"
        // В данный момент оставляю клавиатуру по умолчанию, потом подумаю, как лучше сделать
        latitudeTextField.returnKeyType = .next
        latitudeTextField.tag = 2
        
        //longitudeTextField.keyboardType = .decimalPad
        longitudeTextField.returnKeyType = .done
        longitudeTextField.tag = 3
        
        
        view.addSubviews(subviews: [titleLabel, detailsLabel, latitudeLabel, longitudeLabel, isCheckedLabel])
        view.addSubviews(subviews: [titleTextField, detailsTextField, latitudeTextField, longitudeTextField, isCheckedSwitch])
        view.addSubview(editButton)

        
        
    }
    
    @objc private func addButtonPress(arg: UIButton) {
        
        activiryIndicator.center = latitudeLabel.center
        activiryIndicator.startAnimating()
        view.addSubview(activiryIndicator)
        
        presenter?.editEvent(title: titleTextField.text ?? "",
                             details: detailsTextField.text ?? "",
                             latitude: latitudeTextField.text ?? "",
                             longitude: longitudeTextField.text ?? "",
                             isChecked: isCheckedSwitch.isOn)
    }
    

    func createLabel(title: String) -> UILabel {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = title
        label.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.5
        return label
    }
    
    func createTextField() -> UITextField {
        let textField = UITextField()
        textField.backgroundColor = .secondarySystemBackground
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.delegate = self
        textField.borderStyle = .roundedRect
        
        return textField
    }
}

//MARK: - EditEventViewPresenter
extension EditEventViewController: EditEventViewPresenter {
    func showEditEventError(_ error: Error) {
        activiryIndicator.removeFromSuperview()
        
        let alert = UIAlertController(title: "Ошибка редактирования",
                                      message: "ошибка: \(error.localizedDescription)", preferredStyle: .alert)
        let cancelActionButton = UIAlertAction(title: "OK", style: .cancel) { [weak self] _ in
            self?.presenter?.buttonOkInAlerIsPressed()
        }
        alert.addAction(cancelActionButton)
        self.present(alert, animated: true)
    }
    
    func showEditEventAccess() {
        activiryIndicator.removeFromSuperview()
        
        let alert = UIAlertController(title: "Успех",
                                      message: "Событие отредактировано", preferredStyle: .alert)
        let cancelActionButton = UIAlertAction(title: "OK", style: .cancel) { [weak self] _ in
            self?.presenter?.buttonOkInAlerIsPressed()
        }
        alert.addAction(cancelActionButton)
        self.present(alert, animated: true)
    }
    
    func setEventDetails(title: String, details: String, latitude: String, longitude: String, isChecked: Bool) {
        titleTextField.text = title
        detailsTextField.text = details
        latitudeTextField.text = latitude
        longitudeTextField.text = longitude
        isCheckedSwitch.isOn = isChecked
    }
    

    
    
}

// MARK: - UITextFieldDelegate
extension EditEventViewController: UITextFieldDelegate {
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

// MARK: - setting constraints
private extension EditEventViewController {
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            titleLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            titleLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            titleLabel.heightAnchor.constraint(equalToConstant: 32),
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            
            titleTextField.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor),
            titleTextField.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            titleTextField.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8),

            detailsLabel.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor),
            detailsLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            detailsLabel.heightAnchor.constraint(equalToConstant: 32),
            detailsLabel.topAnchor.constraint(equalTo: titleTextField.bottomAnchor, constant: 16),

            detailsTextField.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor),
            detailsTextField.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            detailsTextField.topAnchor.constraint(equalTo: detailsLabel.bottomAnchor, constant: 8),

            latitudeLabel.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor),
            latitudeLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            latitudeLabel.heightAnchor.constraint(equalToConstant: 32),
            latitudeLabel.topAnchor.constraint(equalTo: detailsTextField.bottomAnchor, constant: 16),

            latitudeTextField.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor),
            latitudeTextField.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            latitudeTextField.topAnchor.constraint(equalTo: latitudeLabel.bottomAnchor, constant: 8),

            longitudeLabel.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor),
            longitudeLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            longitudeLabel.heightAnchor.constraint(equalToConstant: 32),
            longitudeLabel.topAnchor.constraint(equalTo: latitudeTextField.bottomAnchor, constant: 16),

            longitudeTextField.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor),
            longitudeTextField.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            longitudeTextField.topAnchor.constraint(equalTo: longitudeLabel.bottomAnchor, constant: 8),
            
            //isCheckedLabel.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor),
            isCheckedLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            isCheckedLabel.heightAnchor.constraint(equalToConstant: 32),
            isCheckedLabel.topAnchor.constraint(equalTo: longitudeTextField.bottomAnchor, constant: 16),
            
            isCheckedSwitch.topAnchor.constraint(equalTo: isCheckedLabel.topAnchor),
            isCheckedSwitch.leadingAnchor.constraint(equalTo: isCheckedLabel.trailingAnchor, constant: 8),
            
            
            editButton.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor),
            editButton.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            editButton.heightAnchor.constraint(equalToConstant: 32 * 2),
            editButton.topAnchor.constraint(equalTo: isCheckedSwitch.bottomAnchor, constant: 16)

        ])
        
        
    }
}

