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
    private lazy var titleLabel = createLabel()
    private lazy var detailsLabel  = createLabel()
    private lazy var creationTimeLabel  = createLabel()
    
    private lazy var titleTextField = createTextField()
    // TODO: - Заменить на UITextView
    private lazy var detailsTextField = createTextField()
    private lazy var creationTimeTextField = createTextField()
    
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
        titleLabel.text = DetailEventNames.titleName
        detailsLabel.text = DetailEventNames.detailsName
        creationTimeLabel.text = DetailEventNames.creationDate
        
        view.addSubviews(subviews: [titleLabel, detailsLabel, creationTimeLabel])
        view.addSubviews(subviews: [titleTextField, detailsTextField, creationTimeTextField])

        
        
    }
    
    func createLabel() -> UILabel {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 18, weight: UIFont.Weight.bold)
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

// MARK: - setting constraints
private extension DetailEventViewController {
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            titleLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            titleLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
//            titleLabel.heightAnchor.constraint(equalToConstant: ItemDetails.Label.height),
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            
            titleTextField.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor),
            titleTextField.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            titleTextField.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8),

            detailsLabel.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor),
            detailsLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
//            detailsLabel.heightAnchor.constraint(equalToConstant: ItemDetails.Label.height),
            detailsLabel.topAnchor.constraint(equalTo: titleTextField.bottomAnchor, constant: 16),

            detailsTextField.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor),
            detailsTextField.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            detailsTextField.topAnchor.constraint(equalTo: detailsLabel.bottomAnchor, constant: 8),


            creationTimeLabel.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor),
            creationTimeLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
//            creationTimeLabel.heightAnchor.constraint(equalToConstant: ItemDetails.Label.height),
            creationTimeLabel.topAnchor.constraint(equalTo: detailsTextField.bottomAnchor, constant: 16),

            creationTimeTextField.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor),
            creationTimeTextField.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            creationTimeTextField.topAnchor.constraint(equalTo: creationTimeLabel.bottomAnchor, constant: 8),

        ])
        
        
    }
}

//MARK: - DetailEventViewProtocol
extension DetailEventViewController: DetailEventViewPresenter {
    func setEventDetails(title: String, details: String, creationTime: String) {
        titleTextField.text = title
        detailsTextField.text = details
        creationTimeTextField.text = creationTime
        
    }
    
    
}

// MARK: - UITextFieldDelegate
extension DetailEventViewController: UITextFieldDelegate {
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        return false
    }
}
