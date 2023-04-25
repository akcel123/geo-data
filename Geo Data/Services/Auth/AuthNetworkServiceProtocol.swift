//
//  AuthNetworkServiceProtocol.swift
//  Geo Data
//
//  Created by Денис Павлов on 24.03.2023.
//

import Foundation

protocol AuthNetworkServiceProtocol {
    func registration(userName: String, email: String, password: String, completion: @escaping (Error?) -> Void)
    func logIn(userName: String, password: String, completion: @escaping (Result<JwtToken, Error>) -> Void)
    func deleteUser(userName: String, accessToken: String, completion: @escaping (Error?) -> Void)
    func getUser(userName: String, accessToken: String, completion: @escaping (Result<Profile, Error>) -> Void)
}
