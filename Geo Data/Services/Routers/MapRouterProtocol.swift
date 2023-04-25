//
//  MapRouterProtocol.swift
//  Geo Data
//
//  Created by Денис Павлов on 13.04.2023.
//

import UIKit


protocol RouterMap {
    var navigationController: UINavigationController? { get set }
    var mapAssemblyBuilder: MapAssemblyBuilderProtocol? { get set }
}

protocol MapRouterProtocol: RouterMap {
    // показать экран логина или профиля, если ранее был зарегестрирован (возможно нужно применить фабрику)
    func showInitial()
    func showAddNewEvent(location: (latitude: Double, longitude: Double)?)
    func dismissAddNewEvent()
}
