//
//  ProfileViewController.swift
//  Geo Data
//
//  Created by Денис Павлов on 24.03.2023.
//

import UIKit

class ProfileViewController: UIViewController {

    private var helloLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Приветствую, незнакомец"
        label.font = UIFont.systemFont(ofSize: 18, weight: UIFont.Weight.bold)
        return label
    }()
    
    
    private var deleteProfileButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = 4
        button.backgroundColor = .systemMint
        button.setTitle("Удалить", for: .normal)
        return button
    }()
    
    private var logOutButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = 4
        button.backgroundColor = .systemRed
        button.setTitle("Выйти", for: .normal)
        return button
    }()
    
    var presenter: ProfilePresenter?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupNavBar()
        setupViews()
        setupConstraints()
        
    }
    




}

//MARK: - ProfileViewPresenter
extension ProfileViewController: ProfileViewPresenter {
    func setProfileRole(_ role: String) {
        if helloLabel.text != nil {
            helloLabel.text! += ", Вы - \(role)"
        }
    }
    
    func setProfileName(_ name: String) {
        helloLabel.text = "Приветствую, " + name
    }
    
    func deleteProfileError(error: Error) {
        let alert = UIAlertController(title: "Ошибка удаления профиля",
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



//MARK: - setting views
private extension ProfileViewController {
    
    func setupViews() {
        
        
        view.backgroundColor = .systemBackground
//        navigationController?.title = "Профиль"
        
        logOutButton.addTarget(self, action: #selector(logOutButtonTapped), for: .touchUpInside)
        deleteProfileButton.addTarget(self, action: #selector(deleteUserButtonTapped), for: .touchUpInside)
        
        view.addSubview(helloLabel)
        view.addSubview(logOutButton)
        view.addSubview(deleteProfileButton)
    }

    func setupNavBar() {
        self.title = "Профиль"
    }
    
    @objc func logOutButtonTapped() {
        presenter?.didTappedOnLogOut()
    }
    
    @objc func deleteUserButtonTapped() {
        presenter?.didTappedOnDelete()
    }
    

}


// MARK: -  constraints
private extension ProfileViewController {
    func setupConstraints() {
        NSLayoutConstraint.activate([
            helloLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 32),
            helloLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            helloLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            
            deleteProfileButton.heightAnchor.constraint(equalToConstant: 64),
            deleteProfileButton.bottomAnchor.constraint(equalTo: logOutButton.topAnchor, constant: -16),
            deleteProfileButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -32),
            deleteProfileButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 32),
            
            logOutButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -32),
            logOutButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -32),
            logOutButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 32),
            logOutButton.heightAnchor.constraint(equalToConstant: 64),
            
        ])
    }
}

