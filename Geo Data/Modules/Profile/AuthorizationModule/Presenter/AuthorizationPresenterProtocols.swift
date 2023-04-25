//
//  AuthorizationPresenterProtocols.swift
//  Geo Data
//
//  Created by Денис Павлов on 27.03.2023.
//

import Foundation

protocol AuthorizationViewPresenter: AnyObject {
    func showLogInError(error: Error)
}

// по сути этот протокол является неким делегатом, функции которого вызываются во вью
protocol AuthorizationPresenterDelegate: AnyObject {
    init(view: AuthorizationViewPresenter, authService: AuthServiceProtocol, router: ProfileRouterProtocol)
    
    func logIn(userName: String, password: String)
    func register()
    
}

