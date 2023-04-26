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
        label.font = .systemFont(ofSize: 32)
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.5
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
    
    private let iconImage: UIImage = {
        let image = UIImage()
        
        return image
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
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
    
    public func setupCellProp(name: String, creationDate: String) {
        nameLabel.text = name
        creationDateLabel.text = "Дата создания: \(creationDate)"
    }
    
    
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            nameLabel.topAnchor.constraint(equalTo: self.topAnchor),
            nameLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            nameLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            nameLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16),
            nameLabel.heightAnchor.constraint(equalToConstant: 64),
            
            creationDateLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -8),
            creationDateLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -4),
            creationDateLabel.heightAnchor.constraint(equalToConstant: 12),
        
        ])
    }

}
