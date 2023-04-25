//
//  DetailEventPresenterProtocol.swift
//  Geo Data
//
//  Created by Денис Павлов on 20.03.2023.
//

import Foundation

protocol DetailEventPresenterDelegate: AnyObject {
    init(view: DetailEventViewPresenter, geoEvent: GeoEvent?)
    
}

protocol DetailEventViewPresenter: AnyObject {
    // View должна обладать инициализатором, который принимает отображаемые параметры события
    func setEventDetails(title: String, details: String, creationTime: String)
    
    
}
