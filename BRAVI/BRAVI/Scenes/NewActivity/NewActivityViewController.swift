//
//  NewActivityViewController.swift
//  BRAVI
//
//  Created by Zanette Ciriaco on 08/02/22.
//

import UIKit

class NewActivityViewController: UIViewController {
    
    private let activityProvider = ActivitiesProvider()
    private let activityManager = ActivityManager()
    private var activity: Activity!
    
    private let back: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(systemName: "arrowshape.turn.up.backward.fill")
        image.contentMode = .scaleAspectFit
        image.sizeToFit()
        image.height(45)
        image.width(45)
        return image
    }()
    
    private let filter: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(systemName: "slider.horizontal.3")
        image.contentMode = .scaleAspectFit
        image.sizeToFit()
        image.height(50)
        image.width(50)
        return image
    }()
    
    private var ActivityLabel: UILabel = {
        let label = UILabel()
        label.text = "\n\n \n\n"
        label.lineBreakMode = .byTruncatingTail
        label.numberOfLines = 0
        label.width(UIScreen.main.bounds.width * 0.8)
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 20, weight: .heavy)
        label.textColor = .black
        return label
    }()
    
    private let newActivityButton: UIButton = {
        let button = UIButton()
        button.setTitle("New activity", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .systemBlue
        button.layer.cornerRadius = 10
        button.titleLabel?.font = .systemFont(ofSize: 16, weight: .semibold)
        button.width(120)
        button.height(50)
        button.addTarget(self, action: #selector(activityButtonAction), for: .touchUpInside)
        return button
    }()
    
    var saveActivityButton: UIButton = {
        let button = UIButton()
        button.setTitle("Save", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .systemGreen
        button.layer.cornerRadius = 10
        button.titleLabel?.font = .systemFont(ofSize: 16, weight: .semibold)
        button.width(120)
        button.height(50)
        button.addTarget(self, action: #selector(saveButtonAction), for: .touchUpInside)
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        getNewActivity()
        configureView()
    }
    
    private func configureView() {
        view.addSubview(back)
        view.addSubview(filter)
        view.addSubview(ActivityLabel)
        view.addSubview(newActivityButton)
        view.addSubview(saveActivityButton)
        
        back.isUserInteractionEnabled = true
        let tapBackRecognizer = UITapGestureRecognizer(target: self, action: #selector(backAction))
        back.addGestureRecognizer(tapBackRecognizer)
        
        filter.isUserInteractionEnabled = true
        let tapFilterRecognizer = UITapGestureRecognizer(target: self, action: #selector(filterAction))
        filter.addGestureRecognizer(tapFilterRecognizer)
        
        setupConstraints()
    }
    
    private func setupConstraints() {
        back.topToSuperview(offset: 44)
        back.leftToSuperview(offset: 20)
        
        filter.topToSuperview(offset: 44)
        filter.rightToSuperview(offset: -20)
        
        ActivityLabel.centerXToSuperview()
        ActivityLabel.centerYToSuperview()
        
        newActivityButton.topToBottom(of: ActivityLabel, offset: 20)
        newActivityButton.centerXToSuperview(offset: -65)
        
        saveActivityButton.centerY(to: newActivityButton)
        saveActivityButton.leftToRight(of: newActivityButton, offset: 10)
    }
    
    @objc func backAction() {
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc func filterAction() {
        let loadVc = FilterViewController()
        loadVc.modalPresentationStyle = .overCurrentContext
        self.present(loadVc, animated: true)
    }
    
    @objc func saveButtonAction() {
        activityManager.save(activity: activity)
        self.dismiss(animated: true)
    }
    
    @objc func activityButtonAction() {
        getNewActivity()
    }
    
    private func getNewActivity() {
        
        activityProvider.getActivities { data, error, activityFound in
            if error {
                self.ActivityLabel.text = "No connection. Try again later"
                self.saveActivityButton.isEnabled = false
                self.saveActivityButton.backgroundColor = .lightGray
                
            } else {
                if activityFound {
                    guard let data = data else { return }
                    
                    self.activity = data
                    self.ActivityLabel.text = "\(data.activity)\n\nType: \(data.type)\n\nPrice: \(data.price)\n\nAccessibility: \(data.accessibility)\n\nParticipants: \(data.participants)"
                    
                    self.saveActivityButton.isEnabled = true
                    self.saveActivityButton.backgroundColor = .systemGreen
                    
                } else {
                    self.ActivityLabel.text = "No activity found with the specified parameters"
                    self.saveActivityButton.isEnabled = false
                    self.saveActivityButton.backgroundColor = .lightGray
                }
                
            }
        }
    }
}
