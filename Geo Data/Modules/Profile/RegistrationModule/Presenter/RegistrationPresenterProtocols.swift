//
//  RegistrationPresenterProtocols.swift
//  Geo Data
//
//  Created by Денис Павлов on 27.03.2023.
//

import Foundation

protocol RegistrationViewPresenter: AnyObject {
    func showRegistrationError(error: Error)
}

// по сути этот протокол является неким делегатом, функции которого вызываются во вью
protocol RegistrationPresenterDelegate: AnyObject {
    init(view: RegistrationViewPresenter, authService: AuthServiceProtocol, router: ProfileRouterProtocol)
    
    func register(userName: String, email: String, password: String)
    
}

