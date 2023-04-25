//
//  ProfileRouterProtocol.swift
//  Geo Data
//
//  Created by Денис Павлов on 24.03.2023.
//

import UIKit

protocol RouterProfile {
    var navigationController: UINavigationController? { get set }
    var profileAssemblyBuilder: ProfileAssemblyBuilderProtocol? { get set }
}

protocol ProfileRouterProtocol: RouterProfile {
    // показать экран логина или профиля, если ранее был зарегестрирован (возможно нужно применить фабрику)
    func showInitial()
    func showProfile(profile: Profile)
    func showRegistration()
    func showAutorization()
    func dismissRegistration()
}
