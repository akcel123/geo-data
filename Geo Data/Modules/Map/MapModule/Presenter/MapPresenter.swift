//
//  MapPresenter.swift
//  Geo Data
//
//  Created by Денис Павлов on 20.04.2023.
//

import Foundation
import YandexMapsMobile

class MapPresenter: MapPresenterDelegate {

    
    var router: MapRouterProtocol!
    var networkService: NetworkServiceProtocol!
    weak var view: MapViewPresenter?
    
    required init(view: MapViewPresenter, networkService: NetworkServiceProtocol, router: MapRouterProtocol) {
        self.view = view
        self.networkService = networkService
        self.router = router
    }
    
    func addNewEventButtonPressed() {
        guard let location = YMKLocationManager.lastKnownLocation()?.position else {
            DispatchQueue.main.async {
                self.router.showAddNewEvent(location: nil)
            }
            
            return
        }
        DispatchQueue.main.async {
            self.router.showAddNewEvent(location: (latitude: location.latitude, longitude: location.longitude))
        }
        
    }

    
}
