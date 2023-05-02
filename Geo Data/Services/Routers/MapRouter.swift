//
//  MapRouter.swift
//  Geo Data
//
//  Created by Денис Павлов on 13.04.2023.
//

import UIKit

class MapRouter: MapRouterProtocol {

    var navigationController: UINavigationController?
    var mapAssemblyBuilder: MapAssemblyBuilderProtocol?
    
    init(navigationController: UINavigationController, mapAssemblyBuilder: MapAssemblyBuilderProtocol) {
        self.navigationController = navigationController
        self.mapAssemblyBuilder = mapAssemblyBuilder
    }
    
    func showInitial() {
        if let navigationController = navigationController {
            guard let mapViewController = mapAssemblyBuilder?.createMapModule(router: self) else { return }
            mapViewController.tabBarItem = UITabBarItem(title: "Карта", image: UIImage(named: "MainItem"), tag: 0)
            navigationController.viewControllers = [mapViewController]
        }
    }
    
    func showAddNewEvent(location: (latitude: Double, longitude: Double)?) {
        if let navigationController = navigationController {
            guard let addNewEventViewController = mapAssemblyBuilder?.createAddNewEventModule(location: location, router: self) else { return }
            navigationController.present(addNewEventViewController, animated: true)
        }
    }
    
    func dismissAddNewEvent() {
        if let navigationController = navigationController {
            navigationController.dismiss(animated: true)
        }
    }
    
    func showEventDetails(geoEvent: GeoEvent) {
        if let navigationController = navigationController {
            guard let eventsDetailsViewController = mapAssemblyBuilder?.createDetailEventModule(geoEvent: geoEvent) else { return }
            navigationController.present(eventsDetailsViewController, animated: true)
        }
    }
    
    
}
