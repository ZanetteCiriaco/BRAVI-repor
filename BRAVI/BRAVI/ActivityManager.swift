//
//  ActivityManager.swift
//  BRAVI
//
//  Created by Zanette Ciriaco on 10/02/22.
//

import Foundation
import UIKit
import CoreData

struct ActivityManager {
    private let appDelegate = UIApplication.shared.delegate as! AppDelegate
    private var context: NSManagedObjectContext {
        let context = appDelegate.persistentContainer.viewContext
        return context
    }
    
    func save(activity: Activity) {
        let manager = NSEntityDescription.insertNewObject(forEntityName: "ActivityEntity", into: context)
        
        manager.setValue(activity.activity, forKey: "activity")
        manager.setValue(activity.price, forKey: "price")
        manager.setValue(activity.accessibility, forKey: "accessibility")
        manager.setValue(activity.participants, forKey: "participants")
        manager.setValue(activity.type, forKey: "type")
        manager.setValue(activity.link, forKey: "link")
        
        do {
            try context.save()
            print("sucesso")

        } catch {
            print("erro ao salvar")
        }
    }
    
    func getActivities() -> [NSManagedObject] {
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "ActivityEntity")
        var activitiesArray:[NSManagedObject] = []
        
        do {
            let activities = try context.fetch(request)
            activitiesArray = activities as! [NSManagedObject]
            
        } catch {
            print("Error")
        }
        
        return activitiesArray.reversed()
    }
    
    func setTimer(at: NSManagedObject, date: Date, forKey: String) {
        at.setValue(date, forKey: forKey)
        
        do {
            try context.save()
        } catch {
            print("Error")
        }
    }
    
    func setStatus(at: NSManagedObject, status: String) {
        at.setValue(status, forKey: "status")
        
        do {
            try context.save()
        } catch  {
            print("Error")
        }
    }
    
}
