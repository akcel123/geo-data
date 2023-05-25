//
//  EventsBuilder.swift
//  Geo Data
//
//  Created by Денис Павлов on 22.03.2023.
//

import UIKit

protocol EventsAssemblyBuilderProtocol {
    func createEventsModule(router: EventsRouterProtocol) -> UIViewController
    func createDetailEventModule(geoEvent: GeoEvent?, router: EventsRouterProtocol) -> UIViewController
    func createEditEventModule(geoEvent: GeoEvent, router: EventsRouterProtocol) -> UIViewController
}

class EventsAssemblyBuilder: EventsAssemblyBuilderProtocol {
    func createEventsModule(router: EventsRouterProtocol) -> UIViewController {
        let jwtTokenService = JwtTokenService.shared
        let networkService = NetworkService(jwtTokenService: jwtTokenService)
        let view = EventsViewController()
        let presenter = EventsPresenter(view: view, networkService: networkService, router: router)
        view.presenter = presenter

        
        
        return view
    }
    
    func createDetailEventModule(geoEvent: GeoEvent?, router: EventsRouterProtocol) -> UIViewController {
        let view = DetailEventViewController()
        let jwtTokenService = JwtTokenService.shared
        let networkService = NetworkService(jwtTokenService: jwtTokenService)
        let presenter = DetailsEventPresenter(view: view, geoEvent: geoEvent, networkService: networkService, router: router)
        view.presenter = presenter
        return view
    }
    
    func createEditEventModule(geoEvent: GeoEvent, router: EventsRouterProtocol) -> UIViewController {
        let view = EditEventViewController()
        let jwtTokenService = JwtTokenService.shared
        let networkService = NetworkService(jwtTokenService: jwtTokenService)
        let presenter = EditEventPresenter(view: view, geoEvent: geoEvent, networkService: networkService, router: router)
        view.presenter = presenter
        return view
    }
    
}
