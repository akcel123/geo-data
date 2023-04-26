//
//  EventsRouter.swift
//  Geo Data
//
//  Created by Денис Павлов on 22.03.2023.
//

import UIKit

class EventsRouter: EventsRouterProtocol {

    

    
    var navigationController: UINavigationController?
    var eventsAssemblyBuilder: EventsAssemblyBuilderProtocol?
    
    init(navigationController: UINavigationController, eventsAssemblyBuilder: EventsAssemblyBuilderProtocol) {
        self.navigationController = navigationController
        self.eventsAssemblyBuilder = eventsAssemblyBuilder
    }
    
    func showEventsInitial() {
        if let navigationController = navigationController {
            guard let eventsViewController = eventsAssemblyBuilder?.createEventsModule(router: self) else { return }
            eventsViewController.tabBarItem = UITabBarItem(title: "Список событий", image: UIImage(named: "EventItem"), tag: 1)
            
            navigationController.viewControllers = [eventsViewController]
        }
    }
    
    func showDetailsEvent(event: GeoEvent?) {
        if let navigationController = navigationController {
            guard let detailsViewController = eventsAssemblyBuilder?.createDetailEventModule(geoEvent: event) else { return }
            navigationController.pushViewController(detailsViewController, animated: true)
        }
    }
    
    func showEditEvent(event: GeoEvent) {
        if let navigationController = navigationController {
            guard let editEventViewController = eventsAssemblyBuilder?.createEditEventModule(geoEvent: event, router: self) else { return }
            navigationController.present(editEventViewController, animated: true)
        }
    }
    
    func dismissEditEvent() {
        if let navigationController = navigationController {
            navigationController.dismiss(animated: true)
        }
    }
    
    
    

    
}
