//
//  AuthServiceProtocol.swift
//  Geo Data
//
//  Created by Денис Павлов on 24.03.2023.
//

import Foundation

protocol AuthServiceProtocol {
    var authNetworkService: AuthNetworkServiceProtocol { get set }
    var tokenService: JwtTokenServiceProtocol { get set }
    var profileName: String { get }
    
    func logOut(userName: String)
    func deleteProfile(userName: String, completion: @escaping (Error?) -> Void)
    
    func registration(userName: String, email: String, password: String, completion: @escaping (Error?) -> Void)
    func logIn(userName: String, password: String, completion: @escaping (Error?) -> Void)
    
    func getProfile(userName: String, completion: @escaping (Result<Profile, Error>) -> Void) 
    
    init(authNetworkService: AuthNetworkServiceProtocol, tokenService: JwtTokenServiceProtocol)
}
