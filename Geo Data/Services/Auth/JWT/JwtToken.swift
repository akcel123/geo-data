//
//  JwtToken.swift
//  Geo Data
//
//  Created by Денис Павлов on 24.03.2023.
//

import Foundation

struct JwtToken: Decodable {
    var accessToken: String
    var refreshToken: String
}
