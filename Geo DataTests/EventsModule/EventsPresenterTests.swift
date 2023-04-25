//
//  EventsPresenterTests.swift
//  Geo DataTests
//
//  Created by Денис Павлов on 14.03.2023.
//

import XCTest
@testable import Geo_Data

// Определили Mock объект нашей вью
fileprivate class MockView: EventsViewPresenter {
    var isRefreshed: Bool = false
    func refreshCollection() {
        self.isRefreshed = true
    }
    
    
}

fileprivate class MockNetworkService: NetworkServiceProtocol {
    var geoEvents: [GeoEvent]!

    
    convenience init(geoEvents: [GeoEvent]) {
        self.init()
        self.geoEvents = geoEvents
    }
    
    init() {}
    
    func getAllGeoEvents(completion: @escaping (Result<[Geo_Data.GeoEvent], Error>) -> Void) {
        if let geoEvents = geoEvents {
            completion(.success(geoEvents))
        } else {
            completion(.failure(NSError(domain: "ERROE", code: 0)))
        }
    }
    
}

final class EventsPresenterTests: XCTestCase {

    //создаем необходимые сущности
    fileprivate var view: MockView!
    var geoEvents: [GeoEvent] = []
    var eventsPresenter: EventsPresenter!
    fileprivate var networkService: NetworkServiceProtocol!
    
    
    override func setUpWithError() throws {
        // Когда вызываются тесты, в первую очередь вызывается данная функция
        

    }

    override func tearDownWithError() throws {
        // Эта функция вызывается по окончанию тестов, рекомендуется выставлять на нил все свойства
        view = nil
        networkService = nil
        eventsPresenter = nil
    }
    
    func testNetworkManagerReturnsModel() {
        
        geoEvents.append(GeoEvent(title: "Foo", latitude: "0", longitude: "0"))
        geoEvents.append(GeoEvent(title: "Bar", latitude: "1", longitude: "1"))
        geoEvents.append(GeoEvent(title: "Baz", latitude: "2", longitude: "2"))
        
        view = MockView()
        networkService = MockNetworkService(geoEvents: geoEvents)
        eventsPresenter = EventsPresenter(view: view, networkService: networkService)
        
        var catchGeoEvents: [GeoEvent]?
        
        networkService.getAllGeoEvents { result in
            switch result {
            case .success(let geoEvents):
                catchGeoEvents = geoEvents
            case .failure(let error):
                print(error)
            }
        }
        
        XCTAssertNotEqual(catchGeoEvents?.count, 0)
        XCTAssertEqual(catchGeoEvents?.count, geoEvents.count)
        for (i, event) in geoEvents.enumerated() {
            XCTAssertTrue(event.isEqual(event: catchGeoEvents![i]))
        }

    }

    func testNetworkManagerReturnsError() {
        
        
        view = MockView()
        networkService = MockNetworkService()
        eventsPresenter = EventsPresenter(view: view, networkService: networkService)
        
        var catchError: Error?
        
        networkService.getAllGeoEvents { result in
            switch result {
            case .success(_):
                break
            case .failure(let error):
                catchError = error
            }
        }
        
        XCTAssertNotNil(catchError)  

    }



}
