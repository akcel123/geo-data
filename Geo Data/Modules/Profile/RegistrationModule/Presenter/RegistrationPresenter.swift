//
//  RegistrationPresenter.swift
//  Geo Data
//
//  Created by Денис Павлов on 27.03.2023.
//

import Foundation

class RegistrationPresenter: RegistrationPresenterDelegate {
  
    var router: ProfileRouterProtocol!
    var authService: AuthServiceProtocol!
    weak var view: RegistrationViewPresenter?
    
    func register(userName: String, email: String, password: String) {
        authService.registration(userName: userName, email: email, password: password) { [view, router] error in
            guard let error = error else {
                DispatchQueue.main.async {
                    router?.dismissRegistration()
                }
                return
            }
            DispatchQueue.main.async {
                view?.showRegistrationError(error: error)
            }
        }
    }
    
    

    required init(view: RegistrationViewPresenter, authService: AuthServiceProtocol, router: ProfileRouterProtocol) {
        self.view = view
        self.router = router
        self.authService = authService
    }
    
    
}
