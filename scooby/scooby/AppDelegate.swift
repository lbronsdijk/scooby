//
//  AppDelegate.swift
//  scooby
//
//  Created by Lloyd Keijzer on 11-04-16.
//  Copyright © 2016 Lloyd Keijzer. All rights reserved.
//

import UIKit
import CoreData

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var hasInternetConnection: Bool = true
    var restrictRotation: Bool = false
    private var thrownNetWorkError: Bool = false
    
    private var backgroundTask : UIBackgroundTaskIdentifier!

    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        
        // start monitoring internet connection
        NSNotificationCenter.defaultCenter().addObserver(self, selector: Selector("networkStatusChanged:"), name: ReachabilityStatusChangedNotification, object: nil)
        Reach().monitorReachabilityChanges()
        
        // create the application its window
        self.window = UIWindow(frame: UIScreen.mainScreen().bounds)
        
        // create rootviewcontroller with navigation
        //let dashboardViewController = DashboardViewController()
        let navigationController = NavigationController(rootViewController: ViewController())
        
        // set and show rootviewcontroller
        self.window!.rootViewController = navigationController
        self.window!.makeKeyAndVisible()
        
        MultipeerController.displayName = "Luc"
        MultipeerController.sharedInstance
        
        return true
    }

    // application will close
    func applicationWillTerminate(application: UIApplication) {
        self.saveContext() // save core data before closing
    }
    
    func application(application: UIApplication, supportedInterfaceOrientationsForWindow window: UIWindow?) -> UIInterfaceOrientationMask {
        return (restrictRotation) ? UIInterfaceOrientationMask.Portrait : UIInterfaceOrientationMask.All
    }
    
    // background
    func applicationDidEnterBackground(application: UIApplication) {
        
        //Start a background task to keep the app running in the background
        backgroundTask = application.beginBackgroundTaskWithExpirationHandler { () -> Void in
            
            // If your background task takes too long, this block of code will execute
            self.cleanUp()
            
            self.backgroundTask = UIBackgroundTaskInvalid
        }
        
        // Do the work you need to do
        dispatch_async(dispatch_get_main_queue()) { () -> Void in
            
            //Finish up the transfer of data between peers
            self.cleanUp()
            
            // End the background task so that iOS doesn't kill the app
            application.endBackgroundTask(self.backgroundTask)
        }
    }
    
    // clean up
    func cleanUp() {
        
        // Clean up the Multipeer session
    }
    
    // foreground
    func applicationWillEnterForeground(application: UIApplication) {
        application.endBackgroundTask(self.backgroundTask)
    }
    
    // unused application methods
    func applicationWillResignActive(application: UIApplication) {}
    func applicationDidBecomeActive(application: UIApplication) {}
    
    // MARK: - Network reachability
    
    // handler for network status changes
    func networkStatusChanged(notification: NSNotification) {
        let status = Reach().connectionStatus()
        do {
            switch status {
            case .Unknown, .Offline:
                hasInternetConnection = false
                if !self.thrownNetWorkError { self.thrownNetWorkError = true; throw CustomErrorType.NetworkError(message: "No internet connection") }
            case .Online(.WWAN):
                hasInternetConnection = true
                self.thrownNetWorkError = false
                print("Connected via WWAN")
            case .Online(.WiFi):
                hasInternetConnection = true
                self.thrownNetWorkError = false
                print("Connected via WiFi")
            }
        } catch CustomErrorType.NetworkError(let message) {
            ErrorController.sharedInstance.networkErrorHandler(message)
        } catch {}
    }
    
    // MARK: - Core Data stack
    
    lazy var applicationDocumentsDirectory: NSURL = {
        // The directory the application uses to store the Core Data store file. This code uses a directory named "nl.labela.iOSAppTemplate" in the application's documents Application Support directory.
        let urls = NSFileManager.defaultManager().URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask)
        return urls[urls.count-1]
    }()
    
    lazy var managedObjectModel: NSManagedObjectModel = {
        // The managed object model for the application. This property is not optional. It is a fatal error for the application not to be able to find and load its model.
        let modelURL = NSBundle.mainBundle().URLForResource("iOSAppTemplate", withExtension: "momd")!
        return NSManagedObjectModel(contentsOfURL: modelURL)!
    }()
    
    lazy var persistentStoreCoordinator: NSPersistentStoreCoordinator = {
        // The persistent store coordinator for the application. This implementation creates and returns a coordinator, having added the store for the application to it. This property is optional since there are legitimate error conditions that could cause the creation of the store to fail.
        // Create the coordinator and store
        let coordinator = NSPersistentStoreCoordinator(managedObjectModel: self.managedObjectModel)
        let url = self.applicationDocumentsDirectory.URLByAppendingPathComponent("SingleViewCoreData.sqlite")
        var failureReason = "There was an error creating or loading the application's saved data."
        do {
            try coordinator.addPersistentStoreWithType(NSSQLiteStoreType, configuration: nil, URL: url, options: nil)
        } catch {
            // Report any error we got.
            var dict = [String: AnyObject]()
            dict[NSLocalizedDescriptionKey] = "Failed to initialize the application's saved data"
            dict[NSLocalizedFailureReasonErrorKey] = failureReason
            
            dict[NSUnderlyingErrorKey] = error as NSError
            let wrappedError = NSError(domain: "YOUR_ERROR_DOMAIN", code: 9999, userInfo: dict)
            // Replace this with code to handle the error appropriately.
            // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            NSLog("Unresolved error \(wrappedError), \(wrappedError.userInfo)")
            abort()
        }
        
        return coordinator
    }()
    
    lazy var managedObjectContext: NSManagedObjectContext = {
        // Returns the managed object context for the application (which is already bound to the persistent store coordinator for the application.) This property is optional since there are legitimate error conditions that could cause the creation of the context to fail.
        let coordinator = self.persistentStoreCoordinator
        var managedObjectContext = NSManagedObjectContext(concurrencyType: .MainQueueConcurrencyType)
        managedObjectContext.persistentStoreCoordinator = coordinator
        return managedObjectContext
    }()
    
    // MARK: - Core Data Saving support
    
    func saveContext () {
        if managedObjectContext.hasChanges {
            do {
                try managedObjectContext.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                NSLog("Unresolved error \(nserror), \(nserror.userInfo)")
                abort()
            }
        }
    }
}
