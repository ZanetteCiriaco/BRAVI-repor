//
//  HighlightActivity.swift
//  BRAVI
//
//  Created by Zanette Ciriaco on 10/02/22.
//

import UIKit
import CoreData

class HighlightActivity: UIViewController {
    
    let activityManager = ActivityManager()
    var activity: NSManagedObject!
    var startTime: Date?
    var stopTime: Date?
    var timer: Timer!

    private let back: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(systemName: "arrowshape.turn.up.backward.fill")
        image.contentMode = .scaleAspectFit
        image.sizeToFit()
        image.height(45)
        image.width(45)
        return image
    }()
    
    private let containerView: UIStackView = {
        let view = UIStackView()
        view.height(UIScreen.main.bounds.height * 0.5)
        view.width(UIScreen.main.bounds.width * 0.8)
        view.layer.borderWidth = 5
        view.layer.borderColor = UIColor.black.cgColor
        view.layer.cornerRadius = 10
        view.spacing = 5
        view.axis = .vertical
        view.distribution = .fillProportionally
        view.alignment = .center
        return view
    }()
    
    private var activityLabel: UILabel = {
        let label = UILabel()
        label.lineBreakMode = .byTruncatingTail
        label.width(UIScreen.main.bounds.width * 0.75)
        label.numberOfLines = 0
        label.textAlignment = .center
        label.textColor = .black
        return label
    }()
    
    private var priceLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        return label
    }()
    
    private var accessibiLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        return label
    }()
    
    private var participantsLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        return label
    }()
    
    private var timerLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        return label
    }()
    
    private var statusLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        return label
    }()
    
    private let giveUpButton: UIButton = {
        let button = UIButton()
        button.setTitle("Give Up", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .red.withAlphaComponent(0.5)
        button.titleLabel?.font = .systemFont(ofSize: 16, weight: .semibold)
        button.layer.cornerRadius = 10
        button.height(50)
        button.width(110)
        button.addTarget(self, action: #selector(giveupAction), for: .touchUpInside)
        return button
    }()
    
    private let performedButton: UIButton = {
        let button = UIButton()
        button.setTitle("performed", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .systemGreen.withAlphaComponent(0.7)
        button.titleLabel?.font = .systemFont(ofSize: 16, weight: .semibold)
        button.layer.cornerRadius = 10
        button.height(50)
        button.width(110)
        button.addTarget(self, action: #selector(performedAction), for: .touchUpInside)
        return button
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        setValues()
        configureView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        verifyStatus()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.timer?.invalidate()
    }
    
    private func setValues() {
        activityLabel.text = "Activity: \n" + (activity.value(forKey: "activity") as? String)!
        priceLabel.text = "Price: " + "\(activity.value(forKey: "price") as! Double)"
        accessibiLabel.text = "Accessibility: " + "\(activity.value(forKey: "accessibility") as! Double)"
        participantsLabel.text = "Participants: " + "\(activity.value(forKey: "participants") as! Int)"
        statusLabel.text = activity.value(forKey: "status") as? String
    }
    
    private func configureView() {
        view.addSubview(back)
        view.addSubview(containerView)
        view.addSubview(performedButton)
        view.addSubview(giveUpButton)
        
        containerView.addArrangedSubview(activityLabel)
        containerView.addArrangedSubview(priceLabel)
        containerView.addArrangedSubview(accessibiLabel)
        containerView.addArrangedSubview(participantsLabel)
        containerView.addArrangedSubview(timerLabel)
        
        back.isUserInteractionEnabled = true
        let tapBackRecognizer = UITapGestureRecognizer(target: self, action: #selector(backAction))
        back.addGestureRecognizer(tapBackRecognizer)
        
        setupConstraints()
    }
    
    private func setupConstraints() {
        back.topToSuperview(offset: 44)
        back.leftToSuperview(offset: 20)
        
        containerView.centerXToSuperview()
        containerView.centerYToSuperview()
        
        performedButton.topToBottom(of: containerView, offset: 20)
        performedButton.centerXToSuperview(offset: -55)
        
        giveUpButton.centerY(to: performedButton)
        giveUpButton.leftToRight(of: performedButton, offset: 10)
    }
    
    @objc func backAction() {
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc func giveupAction() {
        activityManager.setStatus(at: activity, status: "Abandoned")
        verifyStatus()
    }
    
    @objc func performedAction() {
        activityManager.setStatus(at: activity, status: "Performed")
        activityManager.setTimer(at: activity, date: Date(), forKey: "stopTimer")
        verifyStatus()
    }
    
    private func verifyStatus() {
        let status = activity.value(forKey: "status") as? String

        switch status {
        case "In progress":
            startTimer()
            
        case "Performed":
            performedButton.isEnabled = false
            giveUpButton.isEnabled = false
            performedButton.backgroundColor = .lightGray
            giveUpButton.backgroundColor = .lightGray
            stopTimer()
            
        default:
            performedButton.isEnabled = false
            giveUpButton.isEnabled = false
            performedButton.backgroundColor = .lightGray
            giveUpButton.backgroundColor = .lightGray
        }
    }
    
    private func startTimer() {
        self.startTime = activity.value(forKey: "startTimer") as? Date
        
        timer = Timer.scheduledTimer(timeInterval: 0.1, target: self , selector: #selector(refreshTime), userInfo: nil, repeats: true)
    }
    
    private func stopTimer() {
        self.stopTime = activity.value(forKey: "stopTimer") as? Date
        self.startTime = activity.value(forKey: "startTimer") as? Date
        
        let value = Int(stopTime!.timeIntervalSince(startTime!))
        displayString(value)
        
        self.timer?.invalidate()
    }
    
    @objc func refreshTime() {
        if let startTime = startTime {
            let value = Int(Date().timeIntervalSince(startTime))
            displayString(value)
        } else {
            self.startTime = Date()
            self.activityManager.setTimer(at: activity, date: Date(), forKey: "startTimer")
        }
    }

    private func displayString(_ value: Int) {
        let hour = value / 3600
        let min = (value % 3600) / 60
        let sec = (value % 3600) % 60

        var toDisplayString = ""
        toDisplayString += String(format: "%02d", hour)
        toDisplayString += ":"
        toDisplayString += String(format: "%02d", min)
        toDisplayString += ":"
        toDisplayString += String(format: "%02d", sec)

        timerLabel.text = toDisplayString
    }
}
