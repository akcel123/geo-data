//
//  Profile.swift
//  Geo Data
//
//  Created by Денис Павлов on 24.03.2023.
//

import Foundation

struct Profile: Decodable {
    var userName: String
    var email: String
    
    init(userName: String, email: String) {
        self.userName = userName
        self.email = email
    }
}
