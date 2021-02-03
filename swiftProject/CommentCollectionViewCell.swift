//
//  CommentCollectionViewCell.swift
//  swiftProject
//
//  Created by mbds on 03/02/2021.
//

import UIKit

class CommentCollectionViewCell: UICollectionViewCell {
    let nameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let idLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let bodyLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 2
        return label
    }()
    
    let emailLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.italicSystemFont(ofSize: 10)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
            
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.layer.cornerRadius = 10
        self.layer.backgroundColor = UIColor.white.cgColor
        
        addSubview(nameLabel)
        addSubview(idLabel)
        addSubview(bodyLabel)
        addSubview(emailLabel)
        
        nameLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20).isActive = true
        nameLabel.topAnchor.constraint(equalTo: topAnchor, constant: 20).isActive = true
        
        idLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20).isActive = true
        idLabel.leadingAnchor.constraint(greaterThanOrEqualTo: nameLabel.trailingAnchor, constant: 10).isActive = true
        idLabel.topAnchor.constraint(equalTo: topAnchor, constant: 20).isActive = true
        
        bodyLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20).isActive = true
        bodyLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 20).isActive = true
        bodyLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20).isActive = true
        
        emailLabel.topAnchor.constraint(greaterThanOrEqualTo: bodyLabel.bottomAnchor, constant: 10).isActive = true
        emailLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -20).isActive = true
        emailLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20).isActive = true
    }
            
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
