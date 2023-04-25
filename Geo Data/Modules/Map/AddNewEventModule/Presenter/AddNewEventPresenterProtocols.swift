//
//  AddNewEventPresenterProtocols.swift
//  Geo Data
//
//  Created by Денис Павлов on 13.04.2023.
//

import Foundation

protocol AddNewEventViewPresenter: AnyObject {
    func showAddNewEventError(error: Error)
    func showSuccessAddEvent()
}

// по сути этот протокол является неким делегатом, функции которого вызываются во вью
protocol AddNewEventPresenterDelegate: AnyObject {
    init(view: AddNewEventViewPresenter, networkService: NetworkServiceProtocol, router: MapRouterProtocol)
    
    func addNewEvent(title: String, details: String, latitude: String, longitude: String)
    func buttonAuthDidTapped()
    func buttonSuccessAddedEventDidTapped()
}

