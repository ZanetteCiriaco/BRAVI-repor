//
//  Slider.swift
//  BRAVI
//
//  Created by Zanette Ciriaco on 09/02/22.
//

import Foundation
import UIKit

extension UISlider {
    func configure() {
        self.maximumValue = 1
        self.minimumValue = 0
        self.minimumTrackTintColor = .blue
        self.maximumTrackTintColor = .gray
        self.thumbTintColor = .white
        self.width(200)
        self.height(45)
    }
    
}
