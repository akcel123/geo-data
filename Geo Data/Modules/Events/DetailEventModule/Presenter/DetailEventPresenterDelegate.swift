//
//  DetailEventPresenterProtocol.swift
//  Geo Data
//
//  Created by Денис Павлов on 20.03.2023.
//

import Foundation

protocol DetailEventPresenterDelegate: AnyObject {
    init(view: DetailEventViewPresenter, geoEvent: GeoEvent?, networkService: NetworkServiceProtocol, router: EventsRouterProtocol)
    init(view: DetailEventViewPresenter, geoEvent: GeoEvent?, networkService: NetworkServiceProtocol)
    func editEvent()
}

protocol DetailEventViewPresenter: AnyObject {
    // View должна обладать инициализатором, который принимает отображаемые параметры события
    func setEventDetails(title: String, details: String, creationTime: String, iconName: String, profileRole: ProfileRole)
    
    
}
