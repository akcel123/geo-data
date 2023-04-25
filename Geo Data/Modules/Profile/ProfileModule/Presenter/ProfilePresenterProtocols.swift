//
//  ProfilePresenterProtocols.swift
//  Geo Data
//
//  Created by Денис Павлов on 24.03.2023.
//

import Foundation

protocol ProfileViewPresenter: AnyObject {
    func setProfileName(_ name: String)
    func setProfileRole(_ role: String)
    func deleteProfileError(error: Error)
}

// по сути этот протокол является неким делегатом, функции которого вызываются во вью
protocol ProfilePresenterDelegate: AnyObject {
    init(view: ProfileViewPresenter, authService: AuthServiceProtocol, router: ProfileRouterProtocol, profile: Profile)
    init(view: ProfileViewPresenter, authService: AuthServiceProtocol, router: ProfileRouterProtocol)
    
    func didTappedOnLogOut()
    func didTappedOnDelete()
    
}

