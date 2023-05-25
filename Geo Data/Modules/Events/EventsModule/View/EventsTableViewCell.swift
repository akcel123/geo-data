//
//  EventsTableViewCell.swift
//  Geo Data
//
//  Created by Денис Павлов on 14.03.2023.
//

import UIKit

class EventsTableViewCell: UITableViewCell {

    static let reuseIdentifier = "EventsTableViewCell"
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 18)
//        label.adjustsFontSizeToFitWidth = true
//        label.minimumScaleFactor = 0.5
        label.textAlignment = .left
        return label
    }()
    
    private let creationDateLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 1
        label.textAlignment = .right
        label.font = .systemFont(ofSize: 12)
        return label
    }()
    
    private let iconImage: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    

    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        addSubview(iconImage)
        addSubview(nameLabel)
        addSubview(creationDateLabel)
        self.backgroundColor = .systemBackground
        setupConstraints()
    }
    
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    public func setupCellProp(name: String, creationDate: String, image: String) {
        nameLabel.text = name
        creationDateLabel.text = "Дата создания: \(creationDate)"
        iconImage.layer.cornerRadius = 50/2
        iconImage.layer.borderWidth = 2
        iconImage.layer.borderColor = UIElementsParameters.Color.semiMainColor.cgColor
        iconImage.backgroundColor = #colorLiteral(red: 0.829135716, green: 0.9043282866, blue: 0.9630483985, alpha: 1)
        iconImage.clipsToBounds = true
        
        let image = UIImage(named: image)?.withTintColor(UIElementsParameters.Color.semiMainColor)
        
        iconImage.image = image
        iconImage.contentMode = .center
        
        
    }
    
    
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            
            iconImage.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            iconImage.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),
            iconImage.heightAnchor.constraint(equalToConstant: 50),
            iconImage.widthAnchor.constraint(equalToConstant: 50),
            
            nameLabel.topAnchor.constraint(equalTo: self.topAnchor),
            nameLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            //nameLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            nameLabel.leadingAnchor.constraint(equalTo: iconImage.trailingAnchor, constant: 12),
            nameLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16),
            nameLabel.heightAnchor.constraint(equalToConstant: 60),
            
            creationDateLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -8),
            creationDateLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -4),
            creationDateLabel.heightAnchor.constraint(equalToConstant: 12),
        
        ])
    }

}
