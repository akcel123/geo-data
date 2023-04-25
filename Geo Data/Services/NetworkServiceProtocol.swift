//
//  NetworkServiceProtocol.swift
//  Geo Data
//
//  Created by Денис Павлов on 14.03.2023.
//

import Foundation

protocol NetworkServiceProtocol {
    
    var tokenService: JwtTokenServiceProtocol { get set }
    
    init(jwtTokenService: JwtTokenServiceProtocol)
    func getAllGeoEvents(completion: @escaping (Result<[GeoEvent], Error>) -> Void)
    func addNewGeoEvent(event: GeoEvent, completion: @escaping (Error?) -> Void)
    func editEvent(event: GeoEvent, completion: @escaping ((Error?) -> Void))
    func deleteEvent(with id: String, completion: @escaping ((Error?) -> Void))
}
