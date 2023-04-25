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
        view.setupLocation(location: location)
        let presenter = AddNewEventPresenter(view: view, networkService: networkService, router: router)
        view.presenter = presenter
        
        return view
    }
    
    
}
