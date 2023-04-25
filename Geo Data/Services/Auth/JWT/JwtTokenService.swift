//
//  JwtTokenService.swift
//  Geo Data
//
//  Created by Денис Павлов on 26.03.2023.
//

import Foundation


// TODO: этот класс необходимо реализовать либо синглтоном, либо каким то (непонятным пока мне) образом инжектить одну ссылку в 2 абсолютно независимых экрана
class JwtTokenService: JwtTokenServiceProtocol {
    
    
    
    

    

    static private let accessTonenKey = "accessTokenUserDefaults"
    static private let refreshTonenKey = "refreshTokenUserDefaults"
    
    static let shared = JwtTokenService()
    
    private init() {}
    
    var accessToken: String? {
        set {
            guard let newValue = newValue else { return }
            saveTokenInRom(key: Self.accessTonenKey, token: newValue)
        }
        
        get {
            UserDefaults.standard.string(forKey: Self.accessTonenKey)
        }
    }
    
    var refreshToken: String? {
        set {
            guard let newValue = newValue else { return }
            saveTokenInRom(key: Self.refreshTonenKey, token: newValue)
        }
        
        get {
            UserDefaults.standard.string(forKey: Self.refreshTonenKey)
        }
    }
    
    func removeTokens() {
        UserDefaults.standard.removeObject(forKey: Self.accessTonenKey)
        UserDefaults.standard.removeObject(forKey: Self.refreshTonenKey)
    }
    
    var userName: String? {
        // Разбор JWT-токена на составляющие
        guard let token = accessToken else { return nil }
        let tokenParts = token.components(separatedBy: ".")
        guard tokenParts.count == 3 else {
          return nil // JWT-токен неверного формата
        }

        // Декодирование второй части токена (закодированных данных) в формат JSON (Логику проверил, она работает)
        guard let base64EncodedData = tokenParts[1].base64UrlDecode(),
              let tokenData = try? JSONSerialization.jsonObject(with: base64EncodedData, options: []),
              let tokenDict = tokenData as? [String: Any] else {
          return nil // Не удалось декодировать данные токена
        }

        // Получение значения поля exp (время истечения срока действия токена) из словаря
        guard let name = tokenDict["http://schemas.xmlsoap.org/ws/2005/05/identity/claims/name"] as? String else {
          return nil // Нет поля exp в токене
        }

        return name
    }
    
    var role: ProfileRole? {
        // Разбор JWT-токена на составляющие
        guard let token = accessToken else { return nil }
        let tokenParts = token.components(separatedBy: ".")
        guard tokenParts.count == 3 else {
          return nil // JWT-токен неверного формата
        }

        // Декодирование второй части токена (закодированных данных) в формат JSON (Логику проверил, она работает)
        guard let base64EncodedData = tokenParts[1].base64UrlDecode(),
              let tokenData = try? JSONSerialization.jsonObject(with: base64EncodedData, options: []),
              let tokenDict = tokenData as? [String: Any] else {
          return nil // Не удалось декодировать данные токена
        }

        guard let roleString = tokenDict["http://schemas.microsoft.com/ws/2008/06/identity/claims/role"] as? [String] else {
            return .user // Нет поля или поле .user
        }
//        switch roleString {
//        case ProfileRole.user.rawValue: return .user
//        case ProfileRole.admin.rawValue: return .admin
//        case ProfileRole.moder.rawValue: return .moder
//        default: return nil
//        }
        return .admin
        
    }
    
    var isTokenExpired: Bool {
         // Разбор JWT-токена на составляющие
         guard let token = accessToken else { return true }
         let tokenParts = token.components(separatedBy: ".")
         guard tokenParts.count == 3 else {
           return true // JWT-токен неверного формата
         }

         // Декодирование второй части токена (закодированных данных) в формат JSON (Логику проверил, она работает)
         guard let base64EncodedData = tokenParts[1].base64UrlDecode(),
               let tokenData = try? JSONSerialization.jsonObject(with: base64EncodedData, options: []),
               let tokenDict = tokenData as? [String: Any] else {
           return true // Не удалось декодировать данные токена
         }

         // Получение значения поля exp (время истечения срока действия токена) из словаря
         guard let exp = tokenDict["exp"] as? TimeInterval else {
           return true // Нет поля exp в токене
         }

         // Проверка, истек ли срок действия токена
         let expirationDate = Date(timeIntervalSince1970: exp)
         return expirationDate <= Date()

    }
    
    func refreshToken(completion: @escaping (Error?) -> Void) {
        
        guard let url = URL(string: GeoDataURLNames.refreshToken) else {
            completion(URLError(.badURL))
            return
        }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.httpBody = editRefreshTokenBody(accessToken: self.accessToken!, refreshToken: self.refreshToken!)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        let session = URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error {
                completion(error)
                return
            }
            print(String(data: data!, encoding: .utf8))
            do {
                let obj = try JSONDecoder().decode(JwtToken.self, from: data!)
                self.refreshToken = obj.refreshToken
                self.accessToken = obj.accessToken
                completion(nil)
            } catch {
                // ошибка декодирования может возникать, если мы получаем неправильынй токен, можем чистить память в этом случае
                self.removeTokens()
                completion(error)
            }
        }
        session.resume()
    }
    
    private func saveTokenInRom(key: String, token: String) {
        UserDefaults.standard.set(token, forKey: key)
    }
    
    private func editRefreshTokenBody(accessToken: String, refreshToken: String) -> Data? {
        var paramsArr: [String] = []
        paramsArr.append("\"AccessToken\": \"\(accessToken)\"")
        paramsArr.append("\"refreshToken\": \"\(refreshToken)\"")
        let postBodyString = "{" + paramsArr.joined(separator: ",") + "}"
        print(postBodyString)
        return postBodyString.data(using: .utf8)
    }
    
    
}
