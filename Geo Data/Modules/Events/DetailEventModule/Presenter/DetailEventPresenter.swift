//
//  DetailEventPresenter.swift
//  Geo Data
//
//  Created by Денис Павлов on 20.03.2023.
//

import Foundation

class DetailsEventPresenter: DetailEventPresenterDelegate {

    
    private var geoEvent: GeoEvent!
    var router: EventsRouterProtocol?
    weak var view: DetailEventViewPresenter?
     
    required init(view: DetailEventViewPresenter, geoEvent: GeoEvent?, networkService: NetworkServiceProtocol, router: EventsRouterProtocol) {
        self.view = view
        guard let geoEvent = geoEvent else { return }
        self.geoEvent = geoEvent
        self.router = router
        
        view.setEventDetails(title: geoEvent.title, details: geoEvent.details ?? "", creationTime: geoEvent.getDate + "  " + geoEvent.getTime, iconName: geoEvent.getIconName, profileRole: networkService.tokenService.role ?? .user)
        
    }
    
    required init(view: DetailEventViewPresenter, geoEvent: GeoEvent?, networkService: NetworkServiceProtocol) {
        self.view = view
        guard let geoEvent = geoEvent else { return }
        self.geoEvent = geoEvent
        
        view.setEventDetails(title: geoEvent.title, details: geoEvent.details ?? "", creationTime: geoEvent.getDate + "  " + geoEvent.getTime, iconName: geoEvent.getIconName, profileRole: .user)
        
    }
    
    func editEvent() {
        router?.showEditEvent(event: geoEvent)
    }
    
}
