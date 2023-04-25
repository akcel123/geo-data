//
//  EventsPresenterProtocols.swift
//  Geo Data
//
//  Created by Денис Павлов on 14.03.2023.
//

import Foundation

// по сути этот протокол необходим для управления View
protocol EventsViewPresenter: AnyObject {

    func refreshCollection()
}

// по сути этот протокол является неким делегатом, функции которого вызываются во вью
protocol EventsPresenterDelegate: AnyObject {
    init(view: EventsViewPresenter, networkService: NetworkServiceProtocol, router: EventsRouterProtocol)
    
    
    func getNameAndCreatDateWithIndex(_ index: Int) -> (String, String)
    func getNumOfModelElements() -> Int
    func updateEventsTable(isChecked: Bool)
    func updateEvents()
    func didTappedOnCell(with index: Int)
    
    func editEvent(with index: Int)
    func deleteEvent(with index: Int)
    
    var role: ProfileRole { get }
    var isChecked: Bool! { get set }
}

