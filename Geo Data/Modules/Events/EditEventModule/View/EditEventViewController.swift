//
//  EditEventViewController.swift
//  Geo Data
//
//  Created by Денис Павлов on 26.04.2023.
//

import UIKit

class EditEventViewController: UIViewController {

    
    var presenter: EditEventPresenterDelegate?
    
    private var latitude = ""
    private var longitude = ""
    
    // MARK: - View elements properties
    private lazy var titleLabel = UILabel().createLabelWithText("Название")
    private lazy var detailsLabel  = UILabel().createLabelWithText("Описание")
    private lazy var isCheckedLabel  = UILabel().createLabelWithText("Подтвержденное событие")
   
    
    private lazy var titleTextField: UITextField = {
        let textField = DetailsTextField(text: "")
        textField.delegate = self
        return textField
    }()
    // TODO: - Заменить на UITextView
    private lazy var detailsTextField: UITextField = {
        let textField = DetailsTextField(text: "")
        textField.delegate = self
        return textField
    }()
    
    private lazy var isCheckedSwitch: UISwitch = {
        let isCheckedSwitch = UISwitch()
        isCheckedSwitch.translatesAutoresizingMaskIntoConstraints = false
        isCheckedSwitch.onTintColor = UIElementsParameters.Color.mainColor
        return isCheckedSwitch
    }()
    
    private lazy var editPlaceButton: UIButton = {
        let button = UIButton().createButtonWithTitle("Изменить местоположение", backgroundColor: UIElementsParameters.Color.mainColor)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(self.editPlaceButtonPress), for: .touchUpInside)
        return button
    }()
    
    private lazy var editButton: UIButton = {
        let button = UIButton().createButtonWithTitle("Редактировать", backgroundColor: UIElementsParameters.Color.semiMainColor)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(self.editButtonPress), for: .touchUpInside)
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
        
        detailsTextField.returnKeyType = .done
        detailsTextField.tag = 1

        
        
        view.addSubviews(subviews: [titleLabel, detailsLabel, isCheckedLabel])
        view.addSubviews(subviews: [titleTextField, detailsTextField, isCheckedSwitch])
        view.addSubview(editButton)
        view.addSubview(editPlaceButton)

        
        
    }
    
    @objc private func editButtonPress() {
        
        activiryIndicator.center = editPlaceButton.center
        activiryIndicator.startAnimating()
        view.addSubview(activiryIndicator)
        
        presenter?.editEvent(title: titleTextField.text ?? "",
                             details: detailsTextField.text ?? "",
                             latitude: self.latitude,
                             longitude: self.longitude,
                             isChecked: isCheckedSwitch.isOn)
    }
    

    @objc private func editPlaceButtonPress() {
        // FIXME: - реализовать работу данной логики, нужно сделать переход на карту с выбором местоположения
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
        self.latitude = latitude
        self.longitude = longitude
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

            titleLabel.leadingAnchor.constraint(equalTo: titleTextField.leadingAnchor, constant: UIElementsParameters.heigh / 2),
            titleLabel.bottomAnchor.constraint(equalTo: titleTextField.topAnchor),
            
            titleTextField.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -27),
            titleTextField.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 27),
            titleTextField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 67),

            detailsLabel.leadingAnchor.constraint(equalTo: titleTextField.leadingAnchor, constant: UIElementsParameters.heigh / 2),
            detailsLabel.bottomAnchor.constraint(equalTo: detailsTextField.topAnchor),
            
            detailsTextField.trailingAnchor.constraint(equalTo: titleTextField.trailingAnchor),
            detailsTextField.leadingAnchor.constraint(equalTo: titleTextField.leadingAnchor),
            detailsTextField.topAnchor.constraint(equalTo: titleTextField.bottomAnchor, constant: 42),

            isCheckedLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            isCheckedLabel.heightAnchor.constraint(equalToConstant: 32),
            isCheckedLabel.topAnchor.constraint(equalTo: detailsTextField.bottomAnchor, constant: 27),
            
            isCheckedSwitch.topAnchor.constraint(equalTo: isCheckedLabel.topAnchor),
            isCheckedSwitch.leadingAnchor.constraint(equalTo: isCheckedLabel.trailingAnchor, constant: 8),
            
            editPlaceButton.trailingAnchor.constraint(equalTo: titleTextField.trailingAnchor),
            editPlaceButton.leadingAnchor.constraint(equalTo: titleTextField.leadingAnchor),
            editPlaceButton.heightAnchor.constraint(equalToConstant: UIElementsParameters.heigh),
            editPlaceButton.topAnchor.constraint(equalTo: isCheckedSwitch.bottomAnchor, constant: 16),
            
            editButton.trailingAnchor.constraint(equalTo: editPlaceButton.trailingAnchor),
            editButton.leadingAnchor.constraint(equalTo: editPlaceButton.leadingAnchor),
            editButton.topAnchor.constraint(equalTo: editPlaceButton.bottomAnchor, constant: 16),
            editButton.heightAnchor.constraint(equalToConstant: UIElementsParameters.heigh),
            

        ])
        
        
    }
}

