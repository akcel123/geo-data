//
//  DetailEventViewController.swift
//  Geo Data
//
//  Created by Денис Павлов on 20.03.2023.
//

import UIKit

class DetailEventViewController: UIViewController {

    var presenter: DetailEventPresenterDelegate?
    
    // MARK: - View elements properties
    private lazy var titleLabel = UILabel().createLabelWithText(DetailEventNames.titleName)
    private lazy var detailsLabel  = UILabel().createLabelWithText(DetailEventNames.detailsName)
    private lazy var creationTimeLabel  = UILabel().createLabelWithText(DetailEventNames.creationDate)
    
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
    
    private lazy var creationTimeTextField: UITextField = {
        let textField = DetailsTextField(text: "")
        return textField
    }()
    
    private var iconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private var editEventButton: UIButton = {
        let button = UIButton().createButtonWithTitle("Редактировать", backgroundColor: UIElementsParameters.Color.semiMainColor)
        button.alpha = 0
        button.isEnabled = false
        return button
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Описание"
        self.navigationController?.navigationBar.prefersLargeTitles = false
        
        setupViews()
        setupConstraints()
       
    }


    
}

// MARK: - setting view
private extension DetailEventViewController {
    func setupViews() {
        view.backgroundColor = .systemBackground

        view.addSubview(iconImageView)
        view.addSubviews(subviews: [titleLabel, detailsLabel, creationTimeLabel])
        view.addSubviews(subviews: [titleTextField, detailsTextField, creationTimeTextField])
        view.addSubview(editEventButton)
        editEventButton.addTarget(self, action: #selector(didTapOnEditButton), for: .touchUpInside)
    }
    
    @objc func didTapOnEditButton() {
        self.presenter?.editEvent()
    }

}

// MARK: - setting constraints
private extension DetailEventViewController {
    private func setupConstraints() {
        NSLayoutConstraint.activate([

            iconImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 42),
            iconImageView.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            iconImageView.heightAnchor.constraint(equalToConstant: 213),
            iconImageView.widthAnchor.constraint(equalToConstant: 213),
            
            
            titleLabel.leadingAnchor.constraint(equalTo: titleTextField.leadingAnchor, constant: UIElementsParameters.heigh / 2),
            titleLabel.bottomAnchor.constraint(equalTo: titleTextField.topAnchor),
            
            titleTextField.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -27),
            titleTextField.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 27),
            titleTextField.topAnchor.constraint(equalTo: iconImageView.bottomAnchor, constant: 41),

            detailsLabel.leadingAnchor.constraint(equalTo: titleTextField.leadingAnchor, constant: UIElementsParameters.heigh / 2),
            detailsLabel.bottomAnchor.constraint(equalTo: detailsTextField.topAnchor),
            
            detailsTextField.trailingAnchor.constraint(equalTo: titleTextField.trailingAnchor),
            detailsTextField.leadingAnchor.constraint(equalTo: titleTextField.leadingAnchor),
            detailsTextField.topAnchor.constraint(equalTo: titleTextField.bottomAnchor, constant: 42),

            creationTimeLabel.leadingAnchor.constraint(equalTo: titleTextField.leadingAnchor, constant: UIElementsParameters.heigh / 2),
            creationTimeLabel.bottomAnchor.constraint(equalTo: creationTimeTextField.topAnchor),

            creationTimeTextField.trailingAnchor.constraint(equalTo: titleTextField.trailingAnchor),
            creationTimeTextField.leadingAnchor.constraint(equalTo: titleTextField.leadingAnchor),
            creationTimeTextField.topAnchor.constraint(equalTo: detailsTextField.bottomAnchor, constant: 42),
            
            editEventButton.trailingAnchor.constraint(equalTo: titleTextField.trailingAnchor),
            editEventButton.leadingAnchor.constraint(equalTo: titleTextField.leadingAnchor),
            editEventButton.topAnchor.constraint(equalTo: creationTimeTextField.bottomAnchor, constant: 39)

        ])
        
        
    }
}

//MARK: - DetailEventViewProtocol
extension DetailEventViewController: DetailEventViewPresenter {
    func setEventDetails(title: String, details: String, creationTime: String, iconName: String, profileRole: ProfileRole) {
        iconImageView.layer.cornerRadius = 213/2
        iconImageView.layer.borderWidth = 2
        iconImageView.layer.borderColor = UIElementsParameters.Color.semiMainColor.cgColor
        iconImageView.backgroundColor = #colorLiteral(red: 0.829135716, green: 0.9043282866, blue: 0.9630483985, alpha: 1)
        iconImageView.clipsToBounds = true
        
        let image = UIImage(named: iconName + "Big")?.withTintColor(UIElementsParameters.Color.semiMainColor)
        
        iconImageView.image = image
        iconImageView.contentMode = .center
        titleTextField.text = title
        detailsTextField.text = details
        creationTimeTextField.text = creationTime
        
        if profileRole != .user {
            editEventButton.alpha = 1
            editEventButton.isEnabled = true
        } else {
            editEventButton.alpha = 0
            editEventButton.isEnabled = false
        }
        
    }
    
    
}

// MARK: - UITextFieldDelegate
extension DetailEventViewController: UITextFieldDelegate {
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        return false
    }
}
