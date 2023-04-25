//
//  ProfileBuilder.swift
//  Geo Data
//
//  Created by Денис Павлов on 24.03.2023.
//

import UIKit



protocol ProfileAssemblyBuilderProtocol {
    func createProfileModule(profile: Profile, router: ProfileRouterProtocol) -> UIViewController
    func createAuthModule(router: ProfileRouterProtocol) -> UIViewController
    func createRegistrModule(router: ProfileRouterProtocol) -> UIViewController
    func createInitialModule(router: ProfileRouterProtocol) -> UIViewController

}

class ProfileAssemblyBuilder: ProfileAssemblyBuilderProtocol {

    
    func createProfileModule(profile: Profile, router: ProfileRouterProtocol) -> UIViewController {

        let view = ProfileViewController()
        
        
        let authNetworkService = AuthNetworkService()
        let tokenService = JwtTokenService.shared
        let authService = AuthService(authNetworkService: authNetworkService, tokenService: tokenService)
        
        
        let presenter = ProfilePresenter(view: view, authService: authService, router: router, profile: profile)
        view.presenter = presenter
        return view
    }
    
    func createAuthModule(router: ProfileRouterProtocol) -> UIViewController {
        
        let view = AuthorizationViewController()
        
        let authNetworkService = AuthNetworkService()
        let tokenService = JwtTokenService.shared
        let authService = AuthService(authNetworkService: authNetworkService, tokenService: tokenService)
        
        let presenter = AuthorizationPresenter(view: view, authService: authService, router: router)
        view.presenter = presenter
        return view
    }
    
    func createRegistrModule(router: ProfileRouterProtocol) -> UIViewController{
        
        let view = RegistrationViewController()
        
        let authNetworkService = AuthNetworkService()
        let tokenService = JwtTokenService.shared
        let authService = AuthService(authNetworkService: authNetworkService, tokenService: tokenService)
        
        let presenter = RegistrationPresenter(view: view, authService: authService, router: router)
        view.presenter = presenter
        return view
    }
    
    func createInitialModule(router: ProfileRouterProtocol) -> UIViewController {
        
        let authNetworkService = AuthNetworkService()
        let tokenService = JwtTokenService.shared
        let authService = AuthService(authNetworkService: authNetworkService, tokenService: tokenService)
        
        if authService.isAuthorizated && tokenService.userName != nil && tokenService.role != nil {
            let view = ProfileViewController()
            let presenter = ProfilePresenter(view: view, authService: authService, router: router)
            view.setProfileName(tokenService.userName!)
            view.setProfileRole(tokenService.role!.rawValue)
            view.presenter = presenter
            return view
        } else {
            let view = AuthorizationViewController()
            let presenter = AuthorizationPresenter(view: view, authService: authService, router: router)
            view.presenter = presenter
            return view
        }
        
    }
    
    

    
}
