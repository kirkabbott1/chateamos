//
//  MessageTableViewCell.swift
//  Chateamos
//
//  Created by Kirk Abbott on 12/8/22.
//

import Foundation
import UIKit

class MessageTableViewCell: UITableViewCell {
    
    lazy var sender: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 1
//        label.backgroundColor = .white
//        label.textColor = .black
        
        return label
    }()
    
    lazy var messageLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.layer.masksToBounds = true
        label.layer.cornerRadius = 10
        label.textColor = .systemGray
        
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        createUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func createUI() {
        self.contentView.addSubview(self.messageLabel)
        self.contentView.addSubview(self.sender)
        
//        self.messageLabel.topAnchor.constraint(equalTo: self.contentView.safeAreaLayoutGuide.topAnchor, constant: 8).isActive = true
        self.messageLabel.leadingAnchor.constraint(equalTo: self.contentView.safeAreaLayoutGuide.leadingAnchor, constant: 8).isActive = true
        self.messageLabel.trailingAnchor.constraint(equalTo: self.contentView.safeAreaLayoutGuide.trailingAnchor, constant: 8).isActive = true
        self.messageLabel.bottomAnchor.constraint(equalTo: self.contentView.safeAreaLayoutGuide.bottomAnchor, constant: 8).isActive = true

        
        self.sender.topAnchor.constraint(equalTo: self.contentView.safeAreaLayoutGuide.topAnchor, constant: 8).isActive = true
        self.sender.leadingAnchor.constraint(equalTo: self.contentView.safeAreaLayoutGuide.leadingAnchor, constant: 8).isActive = true
        self.sender.trailingAnchor.constraint(equalTo: self.contentView.safeAreaLayoutGuide.trailingAnchor, constant: -8).isActive = true
        self.sender.bottomAnchor.constraint(equalTo: self.messageLabel.topAnchor, constant: 0).isActive = true
        self.heightAnchor.constraint(equalToConstant: 24).isActive = true

    }
    
}
