//
//  AppDelegate.swift
//  Pokedex
//
//  Created by Brandan Kalsow on 8/13/20.
//  Copyright © 2020 Virgin Pulse. All rights reserved.
//

import UIKit
import CoreData

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        return true
    }
    
    //MARK: Core Data Stack
    lazy var persistentContainer: NSPersistentContainer = {

        let container = NSPersistentContainer(name: "Pokedex")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {

                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    //Mark: Core Data Saving Support
    func saveContext() {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(error), \(nserror.userInfo)")
            }
        }
    }
}
