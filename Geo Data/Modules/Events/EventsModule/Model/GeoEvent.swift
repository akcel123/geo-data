//
//  GeoEvent.swift
//  Geo Data
//
//  Created by Денис Павлов on 13.03.2023.
//

import Foundation

class GeoEvents {
    static let shared = GeoEvents()
    
    private init() {}
    
    var geoEvents: [GeoEvent]?
}

//Структура ниже необходима для декодирования JSON
struct EventModel: Decodable {
    var geoEvents: [GeoEvent]?
    
}

struct GeoEvent: Decodable {
    // параметры id, creationDate опциональны, так как не нужны при добавления события
    var id: String?
    var title: String
    var details: String?
    var latitude: String
    var longitude: String
    private var creationDate: String?
    var isChecked: Bool
    
 
    var getDate: String {
        let dateEndIndex = (self.creationDate?.firstIndex(of: "T") ?? creationDate?.endIndex)!
        let dateString = String(self.creationDate![..<dateEndIndex])
        
        return dateString
    }
    
    var getTime : String {
        let timeFirstIndex = (self.creationDate?.firstIndex(of: "T" ) ?? creationDate?.endIndex)!
        let timeSecondIndex = (self.creationDate?.firstIndex(of: ".") ?? creationDate?.endIndex)!
        var timeString = String(self.creationDate![timeFirstIndex..<timeSecondIndex])
        timeString.remove(at: timeString.startIndex)
        return timeString
    }
    
    
    init(id: String? = nil, title: String, details: String? = nil, latitude: String, longitude: String, creationDate: String? = nil, isChecked: Bool = false) {
        self.id = id
        self.title = title
        self.details = details
        self.latitude = latitude
        self.longitude = longitude
        self.creationDate = creationDate
        self.isChecked = isChecked
    }
}
