//
//  EventsPresenter.swift
//  Geo Data
//
//  Created by Денис Павлов on 13.03.2023.
//

import Foundation


class EventsPresenter: EventsPresenterDelegate {

    
    weak var view: EventsViewPresenter?
    var geoEvents = GeoEvents.shared
    //var geoEvents: [GeoEvent]? = []
    let networkService: NetworkServiceProtocol!
    var router: EventsRouterProtocol!
    var isChecked: Bool! = false
    var role: ProfileRole {
        networkService.tokenService.role ?? .user
    }
    
    // MARK: - EventsPresenterProtocol
    required init(view: EventsViewPresenter, networkService: NetworkServiceProtocol, router: EventsRouterProtocol) {
        self.view = view
        self.networkService = networkService
        self.router = router
    }
    
    func getNameAndCreatDateWithIndex(_ index: Int) -> (String, String) {
        return (geoEvents.geoEvents?[index].title ?? "", geoEvents.geoEvents?[index].getDate ?? "")
    }
    
    func getIconImageNameWithIndex(_ index: Int) -> String {
        var imageName = geoEvents.geoEvents?[index].getIconName
        
        return imageName ?? "UserEvent"
    }
    
    
    func getNumOfModelElements() -> Int {
        var index: Int? = nil
        guard let geoEvents = geoEvents.geoEvents else {return 0}
        if role == .user || role == .none {
            return geoEvents.firstIndex { $0.isChecked == false } ?? geoEvents.count
        }

        if isChecked {
            index = geoEvents.firstIndex { $0.isChecked == false }
        } else {
            index = geoEvents.firstIndex { $0.isChecked == true }
        }
        return index ?? geoEvents.count
    }
    
    func updateEvents() {
        networkService.getAllGeoEvents { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let geoEvents):
                self.geoEvents.geoEvents = geoEvents
                if self.role != .user {
                    self.updateEventsTable(isChecked: self.isChecked)
                } else {
                    self.updateEventsTable(isChecked: true)
                }
                
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func updateEventsTable(isChecked: Bool) {
        if isChecked {
            geoEvents.geoEvents?.sort{ $0.isChecked.description > $1.isChecked.description }
        } else {
            geoEvents.geoEvents?.sort{ $0.isChecked.description < $1.isChecked.description }
        }
        DispatchQueue.main.async {
            self.view?.refreshCollection()
        }
    }
    
    func didTappedOnCell(with index: Int) {
        router.showDetailsEvent(event: geoEvents.geoEvents?[index])
    }

    
    func editEvent(with index: Int) {
        // TODO: тут необходим переход на экран редактирования события
        router.showEditEvent(event: geoEvents.geoEvents![index])
    }
    
    func deleteEvent(with index: Int) {
        networkService.deleteEvent(with: geoEvents.geoEvents![index].id!) { [weak self] error in
            if let error = error {
                print(error.localizedDescription)
                return
            }
            self?.geoEvents.geoEvents?.remove(at: index)
            DispatchQueue.main.async {
                self?.view?.refreshCollection()
            }
        }
    }
    
    
}
