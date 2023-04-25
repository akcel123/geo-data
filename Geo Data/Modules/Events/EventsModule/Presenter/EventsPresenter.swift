//
//  EventsPresenter.swift
//  Geo Data
//
//  Created by Денис Павлов on 13.03.2023.
//

import Foundation


class EventsPresenter: EventsPresenterDelegate {
    
    

    weak var view: EventsViewPresenter?
    var geoEvents: [GeoEvent]? = []
    let networkService: NetworkServiceProtocol!
    var router: EventsRouterProtocol!
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
        return (geoEvents?[index].title ?? "", geoEvents?[index].getDate ?? "")
    }
    
    func getNumOfModelElements() -> Int {
        geoEvents?.count ?? 0
    }
    
    func updateEventsTable(isChecked: Bool) {
        networkService.getAllGeoEvents { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let geoEvents):
                self.geoEvents = geoEvents
                
                // TODO: Необходимо хранить полностью весь массив, а отображать только ту часть, которую требуетая отразить. Это позволит избавиться от большого количества запросов, потому что они трудозатратны.
                self.geoEvents!.removeAll { geoEvent in
                    geoEvent.isChecked == isChecked
                }
                
                DispatchQueue.main.async {
                    self.view?.refreshCollection()
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func didTappedOnCell(with index: Int) {
        router.showDetailsEvent(event: geoEvents?[index])
    }

    
    func editEvent(with index: Int) {
        // TODO: тут необходим переход на экран редактирования события
    }
    
    func deleteEvent(with index: Int) {
        networkService.deleteEvent(with: geoEvents![index].id!) { [weak self] error in
            if let error = error {
                print(error.localizedDescription)
                return
            }
            self?.geoEvents?.remove(at: index)
            DispatchQueue.main.async {
                self?.view?.refreshCollection()
            }
        }
    }
    
    
}
