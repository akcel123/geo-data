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
    
    private var newEventCoordinates: YMKPoint?
    
    required init(view: MapViewPresenter, networkService: NetworkServiceProtocol, router: MapRouterProtocol) {
        self.view = view
        self.networkService = networkService
        self.router = router
        
        networkService.getAllGeoEvents { [weak self] result in
            switch result {
            case .success(let geoEvents):
                GeoEvents.shared.geoEvents = geoEvents
                for event in geoEvents {
                    if event.isChecked == false {
                        continue
                    }
                    DispatchQueue.main.async {
                        self?.view?.addEventOnMap(id: event.id!, latitude: Double(event.latitude)!, longitude: Double(event.longitude)!)
                    }
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func addNewEventButtonPressed() {
        guard let point = newEventCoordinates else {
            DispatchQueue.main.async {
                self.router.showAddNewEvent(location: nil)
            }
            
            return
        }
        DispatchQueue.main.async {
            self.router.showAddNewEvent(location: (latitude: point.latitude, longitude: point.longitude))
        }
        
    }
    
    func onMapPressed(latitude: Double, longitude: Double) {
        view?.showAddNewEventView()
        newEventCoordinates = YMKPoint(latitude: latitude, longitude: longitude)
    }
    
    func onEventPressed(id: String) {
        guard let event = GeoEvents.shared.geoEvents?.first(where: { $0.id == id}) else { return }
        router.showEventDetails(geoEvent: event)
    }
    
}
