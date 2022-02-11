//
//  CheckButton.swift
//  BRAVI
//
//  Created by Zanette Ciriaco on 09/02/22.
//

import UIKit

class FilterRadioButton: UIButton {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        config()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    private func config(){
        self.height(30)
        self.layer.borderColor = UIColor.lightGray.cgColor
        self.setTitleColor(UIColor.systemBlue, for: .selected)
        self.setTitleColor(UIColor.gray, for: .normal)
        self.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
    }
    
    func configure(title: String) {
        self.setTitle(title, for: .normal)
    }
}

