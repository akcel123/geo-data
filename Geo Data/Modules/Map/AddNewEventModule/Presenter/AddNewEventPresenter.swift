//
//  AddNewEventPresenter.swift
//  Geo Data
//
//  Created by Денис Павлов on 13.04.2023.
//

import Foundation

class AddNewEventPresenter: AddNewEventPresenterDelegate {
    
    var router: MapRouterProtocol!
    var networkService: NetworkServiceProtocol!
    weak var view: AddNewEventViewPresenter?
    
    
    required init(view: AddNewEventViewPresenter, networkService: NetworkServiceProtocol, router: MapRouterProtocol) {
        self.view = view
        self.networkService = networkService
        self.router = router
        
    }
    
    func addNewEvent(title: String, details: String, latitude: String, longitude: String) {
        let event = GeoEvent(title: title, details: details, latitude: latitude, longitude: longitude)
        networkService.addNewGeoEvent(event: event) { [weak self] error in
            if let error = error {
                DispatchQueue.main.async {
                    self?.view?.showAddNewEventError(error: error)
                }
                
                return
            }
            DispatchQueue.main.async {
                self?.view?.showSuccessAddEvent()
                
            }
            
            
        }
    }
    
    func buttonAuthDidTapped() {
        router.navigationController?.tabBarController?.selectedIndex = 2
        router.dismissAddNewEvent()
    }
    
    func buttonSuccessAddedEventDidTapped() {
        router.dismissAddNewEvent()
    }
    
    
    
}
