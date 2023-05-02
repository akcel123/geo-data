//
//  MapBuilder.swift
//  Geo Data
//
//  Created by Денис Павлов on 13.04.2023.
//

import UIKit

protocol MapAssemblyBuilderProtocol {
    func createMapModule(router: MapRouterProtocol) -> UIViewController
    func createAddNewEventModule(location: (latitude: Double, longitude: Double)?, router: MapRouterProtocol) -> UIViewController
    func createDetailEventModule(geoEvent: GeoEvent?) -> UIViewController
}


class MapAssemblyBuilder: MapAssemblyBuilderProtocol {

    
    func createMapModule(router: MapRouterProtocol) -> UIViewController {
        let view = MapViewController()
        
        let jwtTokenService = JwtTokenService.shared
        let networkService = NetworkService(jwtTokenService: jwtTokenService)
        
        let presenter = MapPresenter(view: view, networkService: networkService, router: router)
        view.presenter = presenter
        
        return view
    }
    
    func createAddNewEventModule(location: (latitude: Double, longitude: Double)?, router: MapRouterProtocol) -> UIViewController {
        let jwtTokenService = JwtTokenService.shared
        let networkService = NetworkService(jwtTokenService: jwtTokenService)
        let view = AddNewEventViewController()
        let presenter = AddNewEventPresenter(view: view, networkService: networkService, router: router)
        presenter.currentLocation = location
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
