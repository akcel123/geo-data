//
//  ProfileViewController.swift
//  Geo Data
//
//  Created by Денис Павлов on 24.03.2023.
//

import UIKit

class ProfileViewController: UIViewController {

    
    private var profileImage = {
        let imageView = UIImageView(image: UIImage(named: "Avatar"))
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    private var nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 48, weight: .semibold)
        label.adjustsFontSizeToFitWidth = true
        label.textColor = UIElementsParameters.Color.mainColor
        return label
    }()
    
    private var roleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 36, weight: .semibold)
        label.adjustsFontSizeToFitWidth = true
        label.textColor = UIElementsParameters.Color.semiMainColor
        return label
    }()

    private var deleteProfileButton = UIButton().createButtonWithTitle("Удалить", backgroundColor: .red)
    private var logOutButton = UIButton().createButtonWithTitle("Выйти", backgroundColor: UIElementsParameters.Color.semiMainColor)
    

    
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
        roleLabel.text = role
    }
    
    func setProfileName(_ name: String) {
        nameLabel.text = name
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
        
        view.addSubview(profileImage)
        view.addSubview(nameLabel)
        view.addSubview(roleLabel)
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
        
//        private var profileImage
//
//        private var nameLabel
//
//        private var roleLabel
//
//
        NSLayoutConstraint.activate([
            
            profileImage.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            profileImage.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
//            profileImage.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -69),
//            profileImage.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 69),
            
            nameLabel.topAnchor.constraint(equalTo: profileImage.bottomAnchor, constant: 6),
            nameLabel.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            
            roleLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 7),
            roleLabel.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            
            
            deleteProfileButton.heightAnchor.constraint(equalToConstant: UIElementsParameters.heigh),
            deleteProfileButton.bottomAnchor.constraint(equalTo: logOutButton.topAnchor, constant: -16),
            deleteProfileButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -27),
            deleteProfileButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 27),
            
            logOutButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -34),
            logOutButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -27),
            logOutButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 27),
            logOutButton.heightAnchor.constraint(equalToConstant: UIElementsParameters.heigh),
            
        ])
    }
}

