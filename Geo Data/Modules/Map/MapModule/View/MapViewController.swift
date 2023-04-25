//
//  MapViewController.swift
//  Geo Data
//
//  Created by Денис Павлов on 20.04.2023.
//

import UIKit
import YandexMapsMobile

class MapViewController: UIViewController {

    // экземпляр, ответственный за работу с картой
    @objc public var mapView: YMKMapView!
    var presenter: MapPresenterDelegate?
    
    //MARK: - views properties
    private lazy var addEventButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
       // let button = UIButton(type: .system)
        // Устанавливаем скругления, чтобы получить круглую кнопку
        button.layer.cornerRadius = CGFloat(75.0 / 2.0)
        // Устанавливаем цвет фона кнопки
        button.backgroundColor = .systemCyan
        button.clipsToBounds = true
        // Создаем конфигурацию изображения, принимающую размер и толщину (использую для изображения плюса)
        let buttonConfig = UIImage.SymbolConfiguration(pointSize: CGFloat(75.0 / 2.0), weight: .ultraLight)
        // Добавляем изображение для кнопки с ранее созданной конфигурацией
        button.setImage(UIImage(systemName: "plus", withConfiguration: buttonConfig), for: .normal)
        // button.setImage(UIImage(systemName: "plus"), for: .highlighted)
        button.tintColor = .systemGroupedBackground
        button.addTarget(self, action: #selector(addButtonPress), for: .touchUpInside)
        
        
        return button
    }()
    
    //MARK: - life cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        setupNavBar()
        setupMap()
        setupViews()
        setupConstraints()
        
    }


}

// MARK: - MapViewPresenter
extension MapViewController: MapViewPresenter {


}

// MARK: - setting views
private extension MapViewController {
    
    func setupNavBar() {
        view.backgroundColor = .systemBackground
    }
    
    func setupViews() {
        
        view.insertSubview(mapView, at: 0)
        view.addSubview(addEventButton)

    }
    
    @objc private func addButtonPress(arg: UIButton) {
        presenter?.addNewEventButtonPressed()
    }

    
    
    
}

//MARK: - map settings
private extension MapViewController {
    func setupMap() {
        mapView = YMKMapView(frame: view.bounds, vulkanPreferred: false)
        mapView.clearsContextBeforeDrawing = true
        mapView.mapWindow.map.mapType = .map
        
        let mapKit = YMKMapKit.sharedInstance()
        // Создается слой со ЗНАЧКОМ местоположения пользователя, соответствие работа только со значком
        let userLocationLayer = mapKit.createUserLocationLayer(with: mapView.mapWindow)
        
        userLocationLayer.setVisibleWithOn(true)
        // данное свойство определяет, будет ли камера поворачиваться в сторону движения пользователя
        userLocationLayer.isHeadingEnabled = false

        //данный метод определяет отслеживание нескольких событий YMKUserLocationObjectListener
        userLocationLayer.setObjectListenerWith(self)
        
        //данный метод определяет отслеживание события нажатия на значок метоположения YMKUserLocationTapListener
        userLocationLayer.setTapListenerWith(self)
    }
}

// MARK: - YMKUserLocationObjectListener
extension MapViewController: YMKUserLocationObjectListener {
    //вызывается один раз, когда значок пользователя появляется на View
    func onObjectAdded(with view: YMKUserLocationView) {
        // устанавливаем изображение для значка местоположения
        view.arrow.setIconWith(UIImage(named:"LocationPlacemark")!)
        
        view.arrow.setIconStyleWith(YMKIconStyle(
            anchor: CGPoint(x: 0.5, y: 0.5) as NSValue,
              rotationType: YMKRotationType.noRotation.rawValue as NSNumber,
              zIndex: 5,
              flat: true,
              visible: true,
              scale: 1.5,
              tappableArea: nil))
        
        

        
    }
    
    //вызывается один раз, когда объект слоя удаляется, не вызывается жля значка метоположения
    func onObjectRemoved(with view: YMKUserLocationView) {
        
    }
    
    //Вызывается при обновлении объекта слоя (почитать) (не представляет ничего интересного)
    func onObjectUpdated(with view: YMKUserLocationView, event: YMKObjectEvent) {
    }
    
    
}

//MARK: - YMKUserLocationTapListener
extension MapViewController: YMKUserLocationTapListener {
    func onUserLocationObjectTap(with point: YMKPoint) {
        print(point.latitude, point.longitude)
    }
    
    
}

// MARK: - constraints
private extension MapViewController {
    func setupConstraints() {
        NSLayoutConstraint.activate([
            addEventButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            addEventButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -32),
            addEventButton.heightAnchor.constraint(equalToConstant: CGFloat(75)),
            addEventButton.widthAnchor.constraint(equalToConstant: CGFloat(75)),
        ])
    }
}


