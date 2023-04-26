//
//  NetworkService.swift
//  Geo Data
//
//  Created by Денис Павлов on 14.03.2023.
//

import Foundation

class NetworkService: NetworkServiceProtocol {
    
    var tokenService: JwtTokenServiceProtocol
    
    required init(jwtTokenService: JwtTokenServiceProtocol) {
        self.tokenService = jwtTokenService
    }
    
    
    func addNewGeoEvent(event: GeoEvent, completion: @escaping (Error?) -> Void) {
        
        guard let accessToken = tokenService.accessToken else {
            completion(URLError(.userAuthenticationRequired))  // ????????????
            return
        }
        
        if tokenService.isTokenExpired {
            tokenService.refreshToken { [weak self] error in
                if let error = error {
                    completion(error)
                    return
                }
                self?.addNewEventRequest(event: event, accessToken: accessToken, completion: completion)
            }
        } else {
            addNewEventRequest(event: event, accessToken: accessToken, completion: completion)
        }
        
        
        
    }
    
    func getAllGeoEvents(completion: @escaping (Result<[GeoEvent], Error>) -> Void) {
        guard let getEventListUrl = URL(string: GeoDataURLNames.getEventList) else {
            completion(.failure(URLError(.badURL)))
            return
        }
        var request = URLRequest(url: getEventListUrl)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "GET"
        let session = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            do {
                let obj = try JSONDecoder().decode(EventModel.self, from: data!)
                completion(.success(obj.geoEvents!))
            } catch {
                completion(.failure(error))
            }
            
        }
        session.resume()
    }
    
    
    // отправляем запрос на удаление события
    func deleteEvent(with id: String, completion: @escaping ((Error?) -> Void)) {
        
        guard let accessToken = tokenService.accessToken else {
            completion(NSError(domain: "u r not auth", code: 124))  // ????????????
            return
        }
        
        if tokenService.isTokenExpired {
            tokenService.refreshToken { [weak self] error in
                if let error = error {
                    completion(error)
                    return
                }
                self?.deleteEventRequest(with: id, accessToken: accessToken, completion: completion)
            }
        } else {
            deleteEventRequest(with: id, accessToken: accessToken, completion: completion)
        }
        
        
       

    }
    // отправляем запрос на редактирование события
    func editEvent(event: GeoEvent, completion: @escaping ((Error?) -> Void)) {
        
        guard let accessToken = tokenService.accessToken else {
            completion(NSError(domain: "u r not auth", code: 124))  // ????????????
            return
        }
        
        if tokenService.isTokenExpired {
            tokenService.refreshToken { [weak self] error in
                if let error = error {
                    completion(error)
                    return
                }
                self?.editEventRequets(event: event, accessToken: accessToken, completion: completion)
            }
        } else {
            editEventRequets(event: event, accessToken: accessToken, completion: completion)
        }
        
        
        
    }
    
    private func editEventRequets(event: GeoEvent, accessToken: String, completion: @escaping ((Error?) -> Void)) {
        
        guard let updateEventUrl = URL(string: GeoDataURLNames.updateEvent) else {
            completion(URLError(.badURL))
            return
        }
        var request = URLRequest(url: updateEventUrl)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("Bearer \(accessToken)", forHTTPHeaderField: "Authorization")
        request.httpMethod = "POST"
        request.httpBody = editPostBody(event: event)
        let session = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(error)
                return
            }
            completion(nil)
        }
        session.resume()
        
    }
    
    private func addNewEventRequest(event: GeoEvent, accessToken: String, completion: @escaping (Error?) -> Void) {
        guard let addNewEventUrl = URL(string: GeoDataURLNames.createNewItem) else {
            completion(URLError(.badURL))
            return
        }
        var request = URLRequest(url: addNewEventUrl)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("Bearer \(accessToken)", forHTTPHeaderField: "Authorization")
        request.httpMethod = "POST"
        request.httpBody = editAddNewEventBody(event: event)
        let session = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(error)
                return
            }
            
            completion(nil)
            
        }
        session.resume()
    }
    
    private func deleteEventRequest(with id: String, accessToken: String, completion: @escaping ((Error?) -> Void)) {
        guard let getEventListUrl = URL(string: GeoDataURLNames.deleteEvent + "?Id=\(id)") else {
            completion(URLError(.badURL))
            return
        }
        var request = URLRequest(url: getEventListUrl)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("Bearer \(accessToken)", forHTTPHeaderField: "Authorization")
        request.httpMethod = "DELETE"
        let session = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(error)
                return
            }
            completion(nil)
        }
        session.resume()
        
    }
    
    
    private func editAddNewEventBody(event: GeoEvent) -> Data? {
        var paramsArr: [String] = []
        // TODO: Захардкодил составление тела запроса, пока не знаю как нужно сделать правильно
        paramsArr.append("\"Title\": \"\(event.title)\"")
        paramsArr.append("\"Details\": \"\(event.details ?? "")\"")
        paramsArr.append("\"Latitude\": \"\(event.latitude)\"")
        paramsArr.append("\"Longitude\": \"\(event.longitude)\"")
        let postBodyString = "{" + paramsArr.joined(separator: ",") + "}"
        return postBodyString.data(using: .utf8)
    }
    
    private func editPostBody(event: GeoEvent) -> Data? {
        var paramsArr: [String] = []
        // TODO: Захардкодил составление тела запроса, пока не знаю как нужно сделать правильно
        paramsArr.append("\"Id\": \"\(event.id!)\"")
        paramsArr.append("\"Title\": \"\(event.title)\"")
        paramsArr.append("\"Details\": \"\(event.details ?? "")\"")
        paramsArr.append("\"Latitude\": \"\(event.latitude)\"")
        paramsArr.append("\"Longitude\": \"\(event.longitude)\"")
        paramsArr.append("\"isChecked\": \(event.isChecked.description)")
        let postBodyString = "{" + paramsArr.joined(separator: ",") + "}"
        return postBodyString.data(using: .utf8)
    }
    
}
