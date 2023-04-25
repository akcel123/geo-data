//
//  EventsTableViewHeaderFooterView.swift
//  Geo Data
//
//  Created by Денис Павлов on 24.04.2023.
//

import UIKit

protocol HeaderTableViewDelegate: AnyObject {
    func actionForChecked()
    func actionForNotChecked()
}

class EventsTableViewHeaderFooterView: UITableViewHeaderFooterView {
    
    static public let reuseIdentifier = "EventsTableViewHeaderFooterView"
    
    weak var delegate: HeaderTableViewDelegate?
    lazy var segmentedControl: UISegmentedControl! = setupSegmentedController()
    

    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        addSubview(segmentedControl)
        setupConstraints()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupSegmentedController() -> UISegmentedControl {
        let segments: [String] = ["Не проверенные", "Проверенные"]
        
        let checkedAction = UIAction { [weak self] _ in
            self?.delegate?.actionForChecked()
        }
        
        let nonCheckedAction = UIAction { [weak self] _ in
            self?.delegate?.actionForNotChecked()
        }
        let segmentedControl = UISegmentedControl(frame: .zero, actions: [nonCheckedAction, checkedAction])
        
        segmentedControl.translatesAutoresizingMaskIntoConstraints = false
        segmentedControl.setTitle(segments[0], forSegmentAt: 0)
        segmentedControl.setTitle(segments[1], forSegmentAt: 1)
        segmentedControl.selectedSegmentIndex = 0
        return segmentedControl
    }
    
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            segmentedControl.topAnchor.constraint(equalTo: self.topAnchor),
            segmentedControl.trailingAnchor.constraint(equalTo: trailingAnchor),
            segmentedControl.leadingAnchor.constraint(equalTo: leadingAnchor),
            segmentedControl.heightAnchor.constraint(equalToConstant: 48)
        ])
    }

}
