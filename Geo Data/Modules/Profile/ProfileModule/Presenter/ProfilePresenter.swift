//
//  ProfilePresenter.swift
//  Geo Data
//
//  Created by Денис Павлов on 24.03.2023.
//

import Foundation

// TODO: в данном модуле возникает неразбириха, если аксесс токен умер, нужно как то пофиксить данный момент

class ProfilePresenter: ProfilePresenterDelegate {

    
    weak var view: ProfileViewPresenter?
    var profile: Profile?
    let authService: AuthServiceProtocol!
    var router: ProfileRouterProtocol!
    
    required init(view: ProfileViewPresenter, authService: AuthServiceProtocol, router: ProfileRouterProtocol, profile: Profile) {
        self.view = view
        self.authService = authService
        self.router = router
        self.profile = profile
        self.view?.setProfileName(profile.userName)
        self.view?.setProfileRole(authService.tokenService.role?.rawValue ?? " ПОЕМУ РОЛЬ НИЛ???")
        
    }
    
    required init(view: ProfileViewPresenter, authService: AuthServiceProtocol, router: ProfileRouterProtocol) {
        self.view = view
        self.authService = authService
        self.router = router
        authService.getProfile(userName: authService.profileName) { [weak self] result in
            switch result {
            case .success(let profile):
                self?.profile = profile
                DispatchQueue.main.async {
                    self?.view?.setProfileName(profile.userName)
                    self?.view?.setProfileRole(self?.authService.tokenService.role?.rawValue ?? " ПОЕМУ РОЛЬ НИЛ???")
                }
                
            case .failure(let error):
                // TODO: придумать обработку ошибки получения профиля, возможно имеет смысл разлогиниться
                self?.didTappedOnLogOut()
                print(error.localizedDescription)
                
            }
        }
    }
    
    
    func didTappedOnLogOut() {
        //guard let profile = profile else { return } // TODO: добавить UI обработку данной ошибки. Эта ошибка вообще возможна? Возможна  (например, если аксесс умер)
        authService.logOut(userName: profile?.userName ?? "")
        self.profile = nil
        router.showAutorization()
    }
    
    func didTappedOnDelete() {
        guard let profile = profile else { return }
        authService.deleteProfile(userName: profile.userName) { [weak self] error in
            if let error = error {
                DispatchQueue.main.async {
                    self?.view?.deleteProfileError(error: error)
                }
            } else {
                self?.authService.logOut(userName: profile.userName)
                self?.profile = nil
                DispatchQueue.main.async {
                    self?.router.showAutorization()
                }
                
            }
        }
        
    }
    

    
    
}
