//
//  EventsRouterProtocol.swift
//  Geo Data
//
//  Created by Денис Павлов on 22.03.2023.
//

import UIKit

protocol RouterEvents {
    var navigationController: UINavigationController? { get set }
    var eventsAssemblyBuilder: EventsAssemblyBuilderProtocol? { get set }
}

protocol EventsRouterProtocol: RouterEvents {
    func showEventsInitial()
    func showDetailsEvent(event: GeoEvent?)
}
