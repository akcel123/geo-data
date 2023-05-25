//
//  EditEventPresenter.swift
//  Geo Data
//
//  Created by Денис Павлов on 26.04.2023.
//

import Foundation

class EditEventPresenter: EditEventPresenterDelegate {
    
    var router: EventsRouterProtocol!
    var networkService: NetworkServiceProtocol!
    var geoEvent: GeoEvent
    weak var view: EditEventViewPresenter?
    
    required init(view: EditEventViewPresenter, geoEvent: GeoEvent, networkService: NetworkServiceProtocol, router: EventsRouterProtocol) {
        self.view = view
        self.geoEvent = geoEvent
        self.networkService = networkService
        self.router = router
        view.setEventDetails(title: geoEvent.title, details: geoEvent.details ?? "", latitude: geoEvent.latitude, longitude: geoEvent.longitude, isChecked: geoEvent.isChecked)
    }
    
    func editEvent(title: String, details: String, latitude: String, longitude: String, isChecked: Bool) {
        // TODO: - тут необходимо реализовать обновление событий на карте в соответствии с отредактированным
        geoEvent.title = title
        geoEvent.details = details
        geoEvent.latitude = latitude
        geoEvent.longitude = longitude
        geoEvent.isChecked = isChecked
        networkService.editEvent(event: geoEvent) { [view] error in
            if let error = error {
                DispatchQueue.main.async {
                    view?.showEditEventError(error)
                }
                return
            }
            DispatchQueue.main.async {
                view?.showEditEventAccess()
            }
        }
    }
    
    func buttonOkInAlerIsPressed() {
        router.dismissEditEvent()
    }
    
    
}
