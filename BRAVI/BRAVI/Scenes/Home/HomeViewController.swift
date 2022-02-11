//
//  HomeViewController.swift
//  BRAVI
//
//  Created by Zanette Ciriaco on 08/02/22.
//

import UIKit
import TinyConstraints
import CoreData

class HomeViewController: UIViewController {
    
    let activitiesManager = ActivityManager()
    var activities = [NSManagedObject]()
    
    private let ScreenName: UILabel = {
        let label = UILabel()
        label.text = "MY ACTIVITIES"
        label.font = .systemFont(ofSize: 28, weight: .bold)
        label.textColor = .black
        label.textAlignment = .center
        return label
    }()
    
    private lazy var activityCollection: UICollectionView = {
        let Layout = UICollectionViewFlowLayout()
        Layout.itemSize = CGSize(width: UIScreen.main.bounds.width * 0.85, height: 150)
        Layout.sectionInset = UIEdgeInsets(top: 20, left: 5, bottom: 5, right: 5)
   
        let activityCollection = UICollectionView(frame: view.frame, collectionViewLayout: Layout)
        activityCollection.width(UIScreen.main.bounds.width * 0.9)
        activityCollection.layer.borderWidth = 5
        activityCollection.layer.borderColor = UIColor.white.cgColor
        activityCollection.delegate = self
        activityCollection.dataSource = self
        activityCollection.translatesAutoresizingMaskIntoConstraints = false
        activityCollection.register(ActivityCollectionCell.self, forCellWithReuseIdentifier: ActivityCollectionCell.id)
        return activityCollection
    }()
    
    private var newActivityButton: UIButton = {
        let button = UIButton()
        button.setTitle("New activity", for: .normal)
        button.setTitleColor(UIColor.white, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 16, weight: .semibold)
        button.width(200)
        button.height(50)
        button.layer.cornerRadius = 15
        button.backgroundColor = .systemBlue
        button.addTarget(self, action: #selector(activityButtonAction), for: .touchUpInside)
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        configureView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        activities = activitiesManager.getActivities()
        activityCollection.reloadData()
    }
    
    private func configureView() {
        view.addSubview(ScreenName)
        view.addSubview(activityCollection)
        view.addSubview(newActivityButton)
        
        setupConstraints()
    }
    
    private func setupConstraints() {
        ScreenName.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 28).isActive = true
        ScreenName.centerXToSuperview()
        
        activityCollection.topToBottom(of: ScreenName, offset: 28)
        activityCollection.centerXToSuperview()
        activityCollection.bottomToTop(of: newActivityButton, offset: -28)
        
        newActivityButton.centerXToSuperview()
        newActivityButton.bottomToSuperview(offset: -28)
    }
    
    @objc func activityButtonAction() {
        let loadVc = NewActivityViewController()
        loadVc.modalPresentationStyle = .fullScreen
        self.present(loadVc, animated: true)
    }
}

extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return activities.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ActivityCollectionCell.id, for: indexPath) as! ActivityCollectionCell
        
        let objc = activities[indexPath.row]
        cell.titleLabel.text = objc.value(forKey: "activity") as? String
        cell.status = objc.value(forKey: "status") as? String
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let loadVc = HighlightActivity()
        loadVc.activity = activities[indexPath.row]
        loadVc.modalPresentationStyle = .fullScreen
        self.present(loadVc, animated: true, completion: nil)
    }
}
