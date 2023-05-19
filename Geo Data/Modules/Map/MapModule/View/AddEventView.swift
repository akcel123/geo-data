//
//  AddEventView.swift
//  Geo Data
//
//  Created by Денис Павлов on 02.05.2023.
//

import UIKit

protocol AddEventViewDelegate: AnyObject {
    func buttonAddTapped()
    func buttonRemoveTapped()
}

class AddEventView: UIView {

    weak var delegate: AddEventViewDelegate?
    
    private lazy var addEventButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = CGFloat(16 / 2)
        
        button.backgroundColor = UIElementsParameters.Color.mainColor
        button.setTitle("Добавить событие", for: .normal)
        // Редактируем выравнивание текста и цвет текста
        button.titleLabel?.textAlignment = .center
        button.addTarget(self, action: #selector(self.buttonAddDidTapped), for: .touchUpInside)
        
        return button
    }()
    
    private lazy var removeButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        let buttonConfig = UIImage.SymbolConfiguration(pointSize: CGFloat(16), weight: .bold)
        button.setImage(UIImage(systemName: "clear", withConfiguration: buttonConfig), for: .normal)
        
        button.tintColor = .placeholderText
        
        button.backgroundColor = .clear
        button.addTarget(self, action: #selector(self.buttonRemoveDidTapped), for: .touchUpInside)
        return button
    }()
    
    

    
    required init(delegate: AddEventViewDelegate) {
        super.init(frame: .zero)
        self.translatesAutoresizingMaskIntoConstraints = false
        self.delegate = delegate
        setupViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    @objc func buttonAddDidTapped() {
        delegate?.buttonAddTapped()
    }
    
    @objc func buttonRemoveDidTapped() {
        delegate?.buttonRemoveTapped()
    }
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    
    func setupViews() {
        self.layer.cornerRadius = 8
        self.backgroundColor = .secondarySystemBackground
        addSubviews(subviews: [addEventButton, removeButton])
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            removeButton.topAnchor.constraint(equalTo: self.topAnchor, constant: 8),
            removeButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -8),
           
            
            addEventButton.topAnchor.constraint(equalTo: removeButton.bottomAnchor, constant: 16),
            addEventButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16),
            addEventButton.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            addEventButton.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -16),
            addEventButton.heightAnchor.constraint(equalToConstant: UIElementsParameters.heigh),
        
        ])
    }

}
