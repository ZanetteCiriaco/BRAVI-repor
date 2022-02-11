//
//  ActivityCollectionCell.swift
//  BRAVI
//
//  Created by Zanette Ciriaco on 09/02/22.
//

import Foundation
import UIKit

class ActivityCollectionCell: UICollectionViewCell {
    static let id = "myId"
    
    var status: String? {
        didSet {
            verifyStatus()
        }
    }
    
    var titleLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = .black
        label.lineBreakMode = .byTruncatingTail
        label.numberOfLines = 0
        label.width(UIScreen.main.bounds.width * 0.8)
        return label
    }()
    
    var statusLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .semibold)
        label.layer.borderColor = UIColor.lightGray.cgColor
        label.layer.cornerRadius = 5
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureView()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }
    
    private func configureView() {
        contentView.addSubview(titleLabel)
        contentView.addSubview(statusLabel)
        
        verifyStatus()
        
        self.layer.borderColor = UIColor.systemBlue.withAlphaComponent(0.2).cgColor
        self.backgroundColor = .systemBlue.withAlphaComponent(0.1)
        self.layer.cornerRadius = 10
        self.layer.borderWidth = 2
        
        titleLabel.centerXToSuperview()
        titleLabel.centerYToSuperview()
        
        statusLabel.topToSuperview(offset: 10)
        statusLabel.leftToSuperview(offset: 10)
    }
    
    private func verifyStatus() {
        statusLabel.text = status
        
        switch status {
        case "Performed":
            statusLabel.textColor = .systemGreen
        
        case "Abandoned":
            statusLabel.textColor = .systemRed.withAlphaComponent(0.5)
        
        default:
            statusLabel.textColor = .systemBlue
        }
    }
}


