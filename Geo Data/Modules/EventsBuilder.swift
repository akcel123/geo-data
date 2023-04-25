//
//  EventsBuilder.swift
//  Geo Data
//
//  Created by Денис Павлов on 22.03.2023.
//

import UIKit

protocol EventsAssemblyBuilderProtocol {
    func createEventsModule(router: EventsRouterProtocol) -> UIViewController
    func createDetailEventModule(geoEvent: GeoEvent?) -> UIViewController
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
    
    func createDetailEventModule(geoEvent: GeoEvent?) -> UIViewController {
        let view = DetailEventViewController()
        let presenter = DetailsEventPresenter(view: view, geoEvent: geoEvent)
        view.presenter = presenter
        return view
    }
    
}
