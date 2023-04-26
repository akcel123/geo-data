//
//  EditEventPresenterProtocols.swift
//  Geo Data
//
//  Created by Денис Павлов on 26.04.2023.
//

import Foundation

protocol EditEventPresenterDelegate: AnyObject {
    
    init(view: EditEventViewPresenter, geoEvent: GeoEvent, networkService: NetworkServiceProtocol, router: EventsRouterProtocol)
    
    func editEvent(title: String, details: String, latitude: String, longitude: String, isChecked: Bool)
    func buttonOkInAlerIsPressed()
}

protocol EditEventViewPresenter: AnyObject {
    // View должна обладать инициализатором, который принимает отображаемые параметры события
    func setEventDetails(title: String, details: String, latitude: String, longitude: String, isChecked: Bool)
    func showEditEventError(_ error: Error)
    func showEditEventAccess()
    
}
