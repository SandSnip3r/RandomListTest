//
//  AppDelegate.swift
//  RandomListTest
//
//  Created by Victor Stone on 1/30/17.
//  Copyright © 2017 Victor Stone. All rights reserved.
//

import UIKit
import CoreData

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        //generateTestData()
        return true
    }
    
    func generateTestData() {
        do {
            let list = RandomList(context: managedObjectContext)
            list.title = "Co-workers"
            
            let listItem1 = RandomListItem(context: managedObjectContext)
            listItem1.name = "Perry"
            listItem1.num = 1
            listItem1.list = list
            
            let listItem2 = RandomListItem(context: managedObjectContext)
            listItem2.name = "Caleb"
            listItem2.num = 2
            listItem2.list = list
            
            let listItem3 = RandomListItem(context: managedObjectContext)
            listItem3.name = "Brian"
            listItem3.num = 3
            listItem3.list = list
            
            let listItem4 = RandomListItem(context: managedObjectContext)
            listItem4.name = "Ryan"
            listItem4.num = 4
            listItem4.list = list
            
            let listItem5 = RandomListItem(context: managedObjectContext)
            listItem5.name = "Aria"
            listItem5.num = 5
            listItem5.list = list
        }
        do {
            let list = RandomList(context: managedObjectContext)
            list.title = "Workouts"
            
            let listItem1 = RandomListItem(context: managedObjectContext)
            listItem1.name = "Chest, triceps, and calves"
            listItem1.num = 1
            listItem1.list = list
            
            let listItem2 = RandomListItem(context: managedObjectContext)
            listItem2.name = "Back, biceps, and abs"
            listItem2.num = 2
            listItem2.list = list
            
            let listItem3 = RandomListItem(context: managedObjectContext)
            listItem3.name = "Shoulders, traps, and calves"
            listItem3.num = 3
            listItem3.list = list
            
            let listItem4 = RandomListItem(context: managedObjectContext)
            listItem4.name = "Legs and abs"
            listItem4.num = 4
            listItem4.list = list
        }
        do {
            let list = RandomList(context: managedObjectContext)
            list.title = "Candies"
            
            let listItem1 = RandomListItem(context: managedObjectContext)
            listItem1.name = "M&Ms"
            listItem1.num = 1
            listItem1.list = list
            
            let listItem2 = RandomListItem(context: managedObjectContext)
            listItem2.name = "Heath"
            listItem2.num = 2
            listItem2.list = list
            
            let listItem3 = RandomListItem(context: managedObjectContext)
            listItem3.name = "Take 5"
            listItem3.num = 3
            listItem3.list = list
            
            let listItem4 = RandomListItem(context: managedObjectContext)
            listItem4.name = "Payday"
            listItem4.num = 4
            listItem4.list = list
            
            let listItem5 = RandomListItem(context: managedObjectContext)
            listItem5.name = "Butterfinger"
            listItem5.num = 5
            listItem5.list = list
        }
        do {
            let list = RandomList(context: managedObjectContext)
            list.title = "This list has a really long title for testing purposes"
            
            var num: Int32 = 1
            for letter in ["a","b","c","d","e","f"] {
                var str = "Long list item"
                for _ in 0..<100 {
                    str += letter
                }
                let listItem = RandomListItem(context: managedObjectContext)
                listItem.name = str
                listItem.num = num
                num += 1
                listItem.list = list
            }
        }
        do {
            let list = RandomList(context: managedObjectContext)
            list.title = "Favorite 3 digit numbers"
            
            var num: Int32 = 1
            for i in 100..<1000 {
                if arc4random_uniform(5) == 0 {
                    let listItem = RandomListItem(context: managedObjectContext)
                    listItem.name = "\(i)"
                    listItem.num = num
                    num += 1
                    listItem.list = list
                }
            }
        }
        do {
            try managedObjectContext.save()
        } catch {
            print(error)
        }
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
        // Saves changes in the application's managed object context before the application terminates.
        self.saveContext()
    }

    // MARK: - Core Data stack

    lazy var persistentContainer: NSPersistentContainer = {
        /*
         The persistent container for the application. This implementation
         creates and returns a container, having loaded the store for the
         application to it. This property is optional since there are legitimate
         error conditions that could cause the creation of the store to fail.
        */
        let container = NSPersistentContainer(name: "RandomListTest")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                 
                /*
                 Typical reasons for an error here include:
                 * The parent directory does not exist, cannot be created, or disallows writing.
                 * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                 * The device is out of space.
                 * The store could not be migrated to the current model version.
                 Check the error message to determine what the actual problem was.
                 */
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()

    // MARK: - Core Data Saving support

    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }

}

let appDelegate = UIApplication.shared.delegate as! AppDelegate
let managedObjectContext = appDelegate.persistentContainer.viewContext

