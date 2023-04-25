//
//  MapPresenterProtocols.swift
//  Geo Data
//
//  Created by Денис Павлов on 20.04.2023.
//

import Foundation

protocol MapViewPresenter: AnyObject {
    
}

// по сути этот протокол является неким делегатом, функции которого вызываются во вью
protocol MapPresenterDelegate: AnyObject {
    init(view: MapViewPresenter, networkService: NetworkServiceProtocol, router: MapRouterProtocol)
    
    func addNewEventButtonPressed()
   
    
}
