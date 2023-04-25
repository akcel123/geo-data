//
//  ProfileRouter.swift
//  Geo Data
//
//  Created by Денис Павлов on 27.03.2023.
//

import UIKit

class ProfileRouter: ProfileRouterProtocol {
    var navigationController: UINavigationController?
    var profileAssemblyBuilder: ProfileAssemblyBuilderProtocol?
    
    func showProfile(profile: Profile) {
        if let navigationController = navigationController {
            guard let profileViewController = profileAssemblyBuilder?.createProfileModule(profile: profile, router: self) else { return }
            
            profileViewController.tabBarItem = UITabBarItem(title: "Профиль", image: UIImage(named: "ProfileItem"), tag: 2)
            navigationController.viewControllers = [profileViewController]
            //navigationController.pushViewController(profileViewController, animated: true)
        }
    }
    
    func showRegistration() {
        if let navigationController = navigationController {
            guard let registrationViewController = profileAssemblyBuilder?.createRegistrModule(router: self) else { return }
            navigationController.present(registrationViewController, animated: true)
            //navigationController.pushViewController(registrationViewController, animated: true)
        }
    }
    
    func showAutorization() {
        if let navigationController = navigationController {
            guard let authViewController = profileAssemblyBuilder?.createAuthModule(router: self) else { return }
            authViewController.tabBarItem = UITabBarItem(title: "Профиль", image: UIImage(named: "ProfileItem"), tag: 2)
            navigationController.viewControllers = [authViewController]
        }
    }
    
    func showInitial() {
        if let navigationController = navigationController {
            guard let initialViewController = profileAssemblyBuilder?.createInitialModule(router: self) else { return }
            initialViewController.tabBarItem = UITabBarItem(title: "Профиль", image: UIImage(named: "ProfileItem"), tag: 2)
            navigationController.viewControllers = [initialViewController]
        }
    }
    
    func dismissRegistration() {
        if let navigationController = navigationController {
            navigationController.dismiss(animated: true)
        }
    }
    

    init(navigationController: UINavigationController, profileAssemblyBuilder: ProfileAssemblyBuilderProtocol) {
        self.navigationController = navigationController
        self.profileAssemblyBuilder = profileAssemblyBuilder
    }
    
    
}
