//
//  DetailEventPresenter.swift
//  Geo Data
//
//  Created by Денис Павлов on 20.03.2023.
//

import Foundation

class DetailsEventPresenter: DetailEventPresenterDelegate {
    
    weak var view: DetailEventViewPresenter?
    
    required init(view: DetailEventViewPresenter, geoEvent: GeoEvent?) {
        self.view = view
        guard let geoEvent = geoEvent else { return }
        view.setEventDetails(title: geoEvent.title, details: geoEvent.details ?? "", creationTime: geoEvent.getDate + "  " + geoEvent.getTime)
    }
    
    
}
