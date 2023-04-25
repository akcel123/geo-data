//
//  JwtTokenServiceProtocol.swift
//  Geo Data
//
//  Created by Денис Павлов on 26.03.2023.
//

import Foundation

// TODO: данный сервис отвечает за хранение токенов в памяти

protocol JwtTokenServiceProtocol: AnyObject {
    var accessToken: String? { get set }
    var refreshToken: String? { get set }
    var userName: String? { get }
    var role: ProfileRole? { get }
    func removeTokens()
    var isTokenExpired: Bool { get }
    func refreshToken(completion: @escaping (Error?) -> Void) 
}
