//
//  ContainerStackview.swift
//  BRAVI
//
//  Created by Zanette Ciriaco on 09/02/22.
//

import Foundation
import UIKit

class ContainerStackView: UIStackView {
    var firstLine: UIStackView = {
        let view = UIStackView()
        view.axis = .horizontal
        view.spacing = 5
        return view
    }()
    
    var secondLine: UIStackView = {
        let view = UIStackView()
        view.axis = .horizontal
        view.spacing = 5
        return view
    }()
    
    var thirdLine: UIStackView = {
        let view = UIStackView()
        view.axis = .horizontal
        view.spacing = 5
        return view
    }()
    
    var fourLine: UIStackView = {
        let view = UIStackView()
        view.axis = .horizontal
        view.spacing = 5
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        config()
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func config(){
        self.axis = .vertical
        self.alignment = .center
        self.distribution = .fillProportionally
        self.spacing = 5
        self.width(250)
    }
    
    func configure(itens: [UIButton]) {
        let lineOne = itens[0..<2]
        let lineTWO = itens[2..<5]
        let lineThree = itens[5..<8]
        let lineFour = itens[8..<9]
        
        lineOne.forEach { button in
            firstLine.addArrangedSubview(button)
        }
        
        lineTWO.forEach { button in
            secondLine.addArrangedSubview(button)
        }
        
        lineThree.forEach { button in
            thirdLine.addArrangedSubview(button)
        }
        
        lineFour.forEach { button in
            fourLine.addArrangedSubview(button)
        }
        
        self.addArrangedSubview(firstLine)
        self.addArrangedSubview(secondLine)
        self.addArrangedSubview(thirdLine)
        self.addArrangedSubview(fourLine)
    }
}
