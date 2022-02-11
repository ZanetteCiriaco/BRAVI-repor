//
//  FilterViewController.swift
//  BRAVI
//
//  Created by Zanette Ciriaco on 08/02/22.
//

import UIKit

class FilterViewController: UIViewController {

    var buttons = [UIButton]()
    
    private let back: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(systemName: "arrowshape.turn.up.backward.fill")
        image.contentMode = .scaleAspectFit
        image.height(45)
        image.width(45)
        return image
    }()
    
    private let typeLabel: UILabel = {
        let label = UILabel()
        label.text = "Type"
        label.font = .systemFont(ofSize: 18, weight: .semibold)
        return label
    }()
    
    private var containerView: ContainerStackView = {
        let view = ContainerStackView()
        return view
    }()
    
    private var typeButton: UIButton = {
        let button = FilterRadioButton()
        button.configure(title: "education")
        button.addTarget(self, action: #selector(radioButtonTapped(_:)), for: .touchUpInside)
        return button
    }()
    
    private var testeButton: UIButton = {
        let button = FilterRadioButton()
        button.configure(title: "recreational")
        button.addTarget(self, action: #selector(radioButtonTapped(_:)), for: .touchUpInside)
        return button
    }()
    
    private var socialButton: UIButton = {
        let button = FilterRadioButton()
        button.configure(title: "social")
        button.addTarget(self, action: #selector(radioButtonTapped(_:)), for: .touchUpInside)
        return button
    }()
    
    private var diyButton:  UIButton = {
        let button = FilterRadioButton()
        button.configure(title: "diy")
        button.addTarget(self, action: #selector(radioButtonTapped(_:)), for: .touchUpInside)
        return button
    }()
    
    private var charityButton: UIButton = {
        let button = FilterRadioButton()
        button.configure(title: "charity")
        button.addTarget(self, action: #selector(radioButtonTapped(_:)), for: .touchUpInside)
        return button
    }()
    
    private var cookingButton: UIButton = {
        let button = FilterRadioButton()
        button.configure(title: "cooking")
        button.addTarget(self, action: #selector(radioButtonTapped(_:)), for: .touchUpInside)
        return button
    }()
    
    private var relaxationButton: UIButton = {
        let button = FilterRadioButton()
        button.configure(title: "relaxation")
        button.addTarget(self, action: #selector(radioButtonTapped(_:)), for: .touchUpInside)
        return button
    }()
    
    private var musicButton: UIButton = {
        let button = FilterRadioButton()
        button.configure(title: "music")
        button.addTarget(self, action: #selector(radioButtonTapped(_:)), for: .touchUpInside)
        return button
    }()
    
    private var busyworkButton: UIButton = {
        let button = FilterRadioButton()
        button.configure(title: "busywork")
        button.addTarget(self, action: #selector(radioButtonTapped(_:)), for: .touchUpInside)
        return button
    }()
    
    private let priceLabel: UILabel = {
        let label = UILabel()
        label.text = "Price"
        label.textColor = .black
        label.font = .systemFont(ofSize: 18, weight: .semibold)
        return label
    }()
    
    private var priceSwitchButton: UISwitch = {
        let button = UISwitch()
        button.height(20)
        button.width(30)
        button.isOn = false
        button.onTintColor = .blue
        button.addTarget(self, action: #selector(priceSetOnAction(_:)), for: .valueChanged)
        return button
    }()
    
    private var priceSelector: UISlider = {
        let slider = UISlider()
        slider.configure()
        slider.isEnabled = false
        slider.addTarget(self, action: #selector(priceAction(_:)), for: .valueChanged)
        return slider
    }()
    
    private let priceValueLabel: UILabel = {
        let label = UILabel()
        label.text = ""
        label.textColor = .black
        label.font = .systemFont(ofSize: 18, weight: .semibold)
        return label
    }()
    
    private let accessibiLabel: UILabel = {
        let label = UILabel()
        label.text = "Accessibility"
        label.textColor = .black
        label.font = .systemFont(ofSize: 18, weight: .semibold)
        return label
    }()
    
    private var accessibilitySwitchButton: UISwitch = {
        let button = UISwitch()
        button.height(20)
        button.width(30)
        button.isOn = false
        button.onTintColor = .blue
        button.addTarget(self, action: #selector(accessibilitySetOnAction(_:)), for: .valueChanged)
        return button
    }()
    
    private var accessibilitySelector: UISlider = {
        let slider = UISlider()
        slider.configure()
        slider.isEnabled = false
        slider.addTarget(self, action: #selector(accessibilityAction(_:)), for: .valueChanged)
        return slider
    }()
    
    private let accessibilityValueLabel: UILabel = {
        let label = UILabel()
        label.text = ""
        label.textColor = .black
        label.font = .systemFont(ofSize: 18, weight: .semibold)
        return label
    }()
    
    private var saveButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .systemBlue
        button.width(120)
        button.height(50)
        button.layer.cornerRadius = 10
        button.setTitle("Save", for: .normal)
        button.setTitleColor(UIColor.white, for: .normal)
        button.addTarget(self, action: #selector(saveAction), for: .touchUpInside)
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        addButtonArray()
        configureView()
    }
    
    private func addButtonArray() {
        buttons.append(typeButton)
        buttons.append(testeButton)
        buttons.append(socialButton)
        buttons.append(diyButton)
        buttons.append(charityButton)
        buttons.append(cookingButton)
        buttons.append(relaxationButton)
        buttons.append(musicButton)
        buttons.append(busyworkButton)
        
        containerView.configure(itens: buttons)
    }
    
    private func configureView() {
        view.addSubview(back)
        view.addSubview(typeLabel)
        view.addSubview(containerView)
        view.addSubview(priceLabel)
        view.addSubview(priceSwitchButton)
        view.addSubview(priceSelector)
        view.addSubview(priceValueLabel)
        view.addSubview(accessibiLabel)
        view.addSubview(accessibilitySwitchButton)
        view.addSubview(accessibilitySelector)
        view.addSubview(accessibilityValueLabel)
        view.addSubview(saveButton)
        
        back.isUserInteractionEnabled = true
        let tapBackRecognizer = UITapGestureRecognizer(target: self, action: #selector(backAction))
        back.addGestureRecognizer(tapBackRecognizer)
        
        setupConstraints()
    }
    
    private func setupConstraints() {
        back.topToSuperview(offset: 44)
        back.leftToSuperview(offset: 20)
        
        typeLabel.topToBottom(of: back, offset: 30)
        typeLabel.leftAnchor.constraint(equalTo: containerView.leftAnchor).isActive = true
        
        containerView.topToBottom(of: typeLabel, offset: 10)
        containerView.centerXToSuperview()
        
        priceLabel.topToBottom(of: containerView, offset: 20)
        priceLabel.leftAnchor.constraint(equalTo: priceSelector.leftAnchor).isActive = true
        
        priceSwitchButton.rightAnchor.constraint(equalTo: priceSelector.rightAnchor).isActive = true
        priceSwitchButton.centerY(to: priceLabel)
        
        priceSelector.topToBottom(of: priceLabel, offset: 2)
        priceSelector.centerXToSuperview()
        
        priceValueLabel.centerY(to: priceSelector)
        priceValueLabel.leftAnchor.constraint(equalTo: priceSelector.rightAnchor, constant: 10).isActive = true
        
        accessibiLabel.leftAnchor.constraint(equalTo: accessibilitySelector.leftAnchor).isActive = true
        accessibiLabel.topToBottom(of: priceSelector, offset: 20)
        
        accessibilitySwitchButton.centerY(to: accessibiLabel)
        accessibilitySwitchButton.rightAnchor.constraint(equalTo: accessibilitySelector.rightAnchor).isActive = true
        
        accessibilitySelector.centerXToSuperview()
        accessibilitySelector.topToBottom(of: accessibiLabel, offset: 2)
        
        accessibilityValueLabel.centerY(to: accessibilitySelector)
        accessibilityValueLabel.leftAnchor.constraint(equalTo: accessibilitySelector.rightAnchor,constant: 10).isActive = true
        
        saveButton.centerXToSuperview()
        saveButton.bottomToSuperview(offset: -20)
    }
    
    @objc func radioButtonTapped(_ sender:UIButton){
        if sender.isSelected {
            sender.isSelected = !sender.isSelected
            
        } else {
            for button in buttons {
                button.isSelected = false
            }
            sender.isSelected = true
        }
    }
    
    @objc func backAction() {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    @objc func priceAction(_ sender: UISlider) {
        let value = String(format: "%.2f", sender.value)
        self.priceValueLabel.text = value
    }
                         
    @objc func priceSetOnAction(_ sender: UISwitch) {
        if sender.isOn {
            priceSelector.isEnabled = true
            priceSelector.minimumTrackTintColor = .blue
            priceValueLabel.text = "0.00"
        } else {
            priceSelector.isEnabled = false
            priceSelector.minimumTrackTintColor = .gray
            priceValueLabel.text = ""
        }
    }
    
    @objc func accessibilityAction(_ sender: UISlider) {
        let value = String(format: "%.2f", sender.value)
        self.accessibilityValueLabel.text = value
    }
    
    @objc func accessibilitySetOnAction(_ sender: UISwitch) {
        if sender.isOn {
            accessibilitySelector.isEnabled = true
            accessibilitySelector.minimumTrackTintColor = .blue
            accessibilityValueLabel.text = "0.00"
        } else {
            accessibilitySelector.isEnabled = false
            accessibilitySelector.minimumTrackTintColor = .gray
            accessibilityValueLabel.text = ""
        }
    }
    
    @objc func saveAction() {
        let price = priceValueLabel.text!
        let accessibility = accessibilityValueLabel.text!
        
        let selected = buttons.filter({ button in
            return button.isSelected == true
        })
        
        
        
        let type = selected.first?.currentTitle ?? ""
        
        let shared = AddUrlParams.sharedInstance
        let baseUrl = shared.baseUrl
        shared.url = "\(baseUrl)?price=\(price)&accessibility=\(accessibility)&type=\(type)"
        
        backAction()
    }
}
