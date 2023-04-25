//
//  AuthorizationPresenter.swift
//  Geo Data
//
//  Created by Денис Павлов on 27.03.2023.
//

import Foundation

class AuthorizationPresenter: AuthorizationPresenterDelegate {

    
    
    var authService: AuthServiceProtocol!
    var router: ProfileRouterProtocol!
    weak var view: AuthorizationViewPresenter?
    
    required init(view: AuthorizationViewPresenter, authService: AuthServiceProtocol, router: ProfileRouterProtocol) {
        self.authService = authService
        self.router = router
        self.view = view
    }
    
    // TODO: Нужно добавить обработку ошибки авторизации, я так понимаю, 401 ошибка (пользователя не существует)
    func logIn(userName: String, password: String) {
        authService.logIn(userName: userName, password: password) { [view, router, authService] error in
            guard let error = error else {
                
                authService?.getProfile(userName: userName) { result in
                    switch result {
                    case .success(let profile):
                        DispatchQueue.main.async {
                            router?.showProfile(profile: profile)
                        }
                    case .failure(let error):
                        DispatchQueue.main.async {
                            view?.showLogInError(error: error)
                        }
                        break
                    }
                }
                
                
                return
            }
            
            DispatchQueue.main.async {
                view?.showLogInError(error: error)
            }
            
            
        }
    }
    
    
    func register() {
        router.showRegistration()
    }
    
}
