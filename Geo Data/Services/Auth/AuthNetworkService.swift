//
//  AuthNetworkService.swift
//  Geo Data
//
//  Created by Денис Павлов on 24.03.2023.
//

import Foundation

// FIXME: В данный момент обрабатывается только ошибка при запросе, которую вызывает фреймворк. ПОДУМАТЬ как обрабатывать ошибки сервера

// TODO: Забыл добавиь обработку ответа в виде токенов, исправить!!!!!!!!!!!!!!
class AuthNetworkService: AuthNetworkServiceProtocol {

    
    
    
    func registration(userName: String, email: String, password: String, completion: @escaping (Error?) -> Void) {
        
        guard let url = URL(string: GeoDataURLNames.registration) else {
            completion(URLError(.badURL))
            return
        }
        var request = URLRequest(url: url)
        
        request.httpMethod = "POST"
        request.httpBody = editRegisterPostBody(userName: userName, email: email, password: password)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        let session = URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error {
                completion(error)
                return
            }
            //print(response)
            completion(nil)
        }
        session.resume()
    }
    
    func logIn(userName: String, password: String, completion: @escaping (Result<JwtToken, Error>) -> Void) {

        guard let url = URL(string: GeoDataURLNames.logIn) else {
            completion(.failure(URLError(.badURL)))
            return
        }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.httpBody = editLogInPostBody(userName: userName, password: password)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        let session = URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            do {
                let obj = try JSONDecoder().decode(JwtToken.self, from: data!)
                completion(.success(obj))
            } catch {
                completion(.failure(error))
            }
        }
        session.resume()
    }
    

    
    func deleteUser(userName: String, accessToken: String, completion: @escaping (Error?) -> Void) {
        let postBody = editDeleteUserPostBody(userName: userName)
        guard let url = URL(string: GeoDataURLNames.deleteUser) else {
            completion(URLError(.badURL))
            return
        }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.httpBody = postBody
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("Bearer \(accessToken)", forHTTPHeaderField: "Authorization")

        let session = URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error {
                completion(error)
                return
            }

            completion(nil)
        }
        session.resume()
    }
    
    func getUser(userName: String, accessToken: String, completion: @escaping (Result<Profile, Error>) -> Void) {
        guard let url = URL(string: GeoDataURLNames.getUser + userName) else {
            completion(.failure(URLError(.badURL)))
            return
        }
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.addValue("Bearer \(accessToken)", forHTTPHeaderField: "Authorization")
        
        let session = URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error {
                completion(.failure(error))
                return
            }

            do {
                let obj = try JSONDecoder().decode(Profile.self, from: data!)
                completion(.success(obj))
            } catch {
                completion(.failure(error))
            }
        }
        session.resume()
    }
    

    
    


    
    // MARK: - private func for bodyes
    // FIXME: Захардкодил составление тела запроса, пока не знаю как нужно сделать правильно
    private func editRegisterPostBody(userName: String, email: String, password: String) -> Data? {
        var paramsArr: [String] = []
        // "Username":"Vaska", "Email":"strix@gmail.com", "password":"12312321sadsqasas"
        
        paramsArr.append("\"Username\": \"\(userName)\"")
        paramsArr.append("\"Email\": \"\(email)\"")
        paramsArr.append("\"password\": \"\(password)\"")
        let postBodyString = "{" + paramsArr.joined(separator: ",") + "}"
        return postBodyString.data(using: .utf8)
    }
    
    private func editLogInPostBody(userName: String, password: String) -> Data? {
        var paramsArr: [String] = []
        // {"Username":"Vaska", "password":"12312321sadsqasas"}

        paramsArr.append("\"Username\": \"\(userName)\"")
        paramsArr.append("\"password\": \"\(password)\"")
        let postBodyString = "{" + paramsArr.joined(separator: ",") + "}"
        return postBodyString.data(using: .utf8)
    }
    

    private func editDeleteUserPostBody(userName: String) -> Data? {
        var paramsArr: [String] = []
        // {"Username":"Vaska""}

        paramsArr.append("\"Username\": \"\(userName)\"")
        let postBodyString = "{" + paramsArr.joined(separator: ",") + "}"
        return postBodyString.data(using: .utf8)
    }
    


    
}
