//
//  AuthService.swift
//  Geo Data
//
//  Created by Денис Павлов on 24.03.2023.
//

import Foundation

class AuthService: AuthServiceProtocol {

    var tokenService: JwtTokenServiceProtocol
    var authNetworkService: AuthNetworkServiceProtocol
    var isAuthorizated: Bool {
        return tokenService.accessToken != nil && tokenService.refreshToken != nil
    }
    var profileName: String {
        return tokenService.userName ?? "Незнакомец"
    }
    
    
    func registration(userName: String, email: String, password: String, completion: @escaping (Error?) -> Void) {
        authNetworkService.registration(userName: userName, email: email, password: password, completion: completion)
    }
    
    func logIn(userName: String, password: String, completion: @escaping (Error?) -> Void) {
        authNetworkService.logIn(userName: userName, password: password) { [weak self] result in
            switch result {
            case .success(let jwtToken):
                self?.tokenService.accessToken = jwtToken.accessToken
                self?.tokenService.refreshToken = jwtToken.refreshToken
                completion(nil)
            case .failure(let error):
                completion(error)
            }
        }
    }
    
    
    func logOut(userName: String) {
        tokenService.removeTokens()
    }
    
    
    func getProfile(userName: String, completion: @escaping (Result<Profile, Error>) -> Void) {
        
        guard let accessToken = tokenService.accessToken else {
            completion(.failure(NSError(domain: "token is not avaible", code: 123)))  // ????????????
            return
        }

        if tokenService.isTokenExpired {
            tokenService.refreshToken() { [weak self] error in
                if let error = error {
                    completion(.failure(error))
                    return
                }
                self?.authNetworkService.getUser(userName: userName, accessToken: accessToken, completion: completion)

            }
            return
        }
        authNetworkService.getUser(userName: userName, accessToken: accessToken, completion: completion)
    }
    


    func deleteProfile(userName: String, completion: @escaping (Error?) -> Void) {
        guard tokenService.accessToken != nil else {
            completion(NSError(domain: "token is not avaible", code: 123))  // ????????????
            return
        }
        
        if tokenService.isTokenExpired {
            tokenService.refreshToken { [weak self] error in
                if let error = error {
                    completion(error)
                    return
                }
                self?.authNetworkService.deleteUser(userName: userName, accessToken: (self?.tokenService.accessToken)!) { error in
                    if let error = error {
                        completion(error)
                        return
                    }
                    self?.tokenService.removeTokens()
                }
            }
            return
        }
        
        self.authNetworkService.deleteUser(userName: userName, accessToken: self.tokenService.accessToken!) { error in
            if let error = error {
                completion(error)
                return
            }
            self.tokenService.removeTokens()
        }
        
 
    }
    
    
    required init(authNetworkService: AuthNetworkServiceProtocol, tokenService: JwtTokenServiceProtocol) {
        self.authNetworkService = authNetworkService
        self.tokenService = tokenService
    }
    
    
}
