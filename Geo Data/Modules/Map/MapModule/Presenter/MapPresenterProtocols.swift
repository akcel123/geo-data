//
//  MapPresenterProtocols.swift
//  Geo Data
//
//  Created by Денис Павлов on 20.04.2023.
//

import Foundation

protocol MapViewPresenter: AnyObject {
    func removeAddNewEventPlacemarkAndButton()
    func showAddNewEventButton()
    func addEventOnMap(id: String, latitude: Double, longitude: Double)
}

// по сути этот протокол является неким делегатом, функции которого вызываются во вью
protocol MapPresenterDelegate: AnyObject {
    init(view: MapViewPresenter, networkService: NetworkServiceProtocol, router: MapRouterProtocol)
    
    func addNewEventButtonPressed()
    func onMapPressed(latitude: Double, longitude: Double)
    func onEventPressed(id: String)
    
}
