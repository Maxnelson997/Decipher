//
//  AppDelegate.swift
//  Decipher
//
//  Created by Max Nelson on 10/19/17.
//  Copyright © 2017 cplusplus. All rights reserved.
//

import UIKit
import CoreData
import Font_Awesome_Swift

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var navigationController:UINavigationController!
    
    var login:LoginController!
    var scan:ScanController!
    var history:HistoryController!
    var settings:SettingsController!

    var tabBarController:UITabBarController!
    
    @objc func Login() {
        navigationController.pushViewController(tabBarController, animated: true)
    }
    
    @objc func Logout() {
        navigationController.popToViewController(login, animated: true)
    }
    

    
    func barButton(withIcon: FAType, withSelector: Selector) -> UIBarButtonItem {
        let b = UIButton(type: .custom)
        b.setFAIcon(icon: withIcon, iconSize: 30, forState: UIControlState.normal)
        b.contentHorizontalAlignment = .left
        b.frame = CGRect(x: 0, y: 0, width: 30, height: 0)
        b.addTarget(self, action: withSelector, for: .touchUpInside)
        return UIBarButtonItem(customView: b)
    }
    
    //help
    func createTitle(titleText:String) -> UIButton {
        let navTitle = UIButton(type: .custom)
        navTitle.setTitle(titleText, for: .normal)
//        navTitle.titleLabel?.font = UIFont.init(customFont: .LatoBold, withSize: 20)
        navTitle.backgroundColor = UIColor.clear
        navTitle.setTitleColor(UIColor.darkGray, for: .normal)
        return navTitle
    }
    
    
    func makeTitle(titleText:String) -> UIButton {
        let navTitle = UIButton(type: .custom)
        navTitle.setTitle(titleText, for: .normal)
//        navTitle.titleLabel?.font =
        navTitle.setTitleColor(UIColor.darkGray, for: .normal)
        return navTitle
    }
    
    @objc func space() {
        
    }
    
    func showBar() {
        UIView.animate(withDuration: 0.3, animations: {
           self.navigationController.navigationBar.transform = CGAffineTransform(translationX: 0, y: 0)
        }) { (true) in }
    }
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        UINavigationBar.appearance().barTintColor = UIColor.darkGray
        
        login = LoginController()
        scan = ScanController()
        history = HistoryController()
        settings = SettingsController()
        
        let scanNav = UINavigationController(rootViewController: scan)
        scanNav.tabBarItem.title = "scan"
        scanNav.navigationItem.titleView = makeTitle(titleText: "scan")
        scanNav.tabBarItem.setFAIcon(icon: .FAQrcode)
    
    
        
        let historyNav = UINavigationController(rootViewController: history)
        historyNav.tabBarItem.title = "history"
        historyNav.navigationItem.titleView = makeTitle(titleText: "history")
        historyNav.tabBarItem.setFAIcon(icon: .FAHistory)
        
        let settingsNav = UINavigationController(rootViewController: settings)
        settings.navigationItem.titleView = makeTitle(titleText: "buttons")
        settingsNav.title = "hmm"
        
        
        settingsNav.navigationItem.titleView = makeTitle(titleText: "settings")
        settingsNav.tabBarItem.setFAIcon(icon: .FASpaceShuttle)
        
//        scanNav.tabBarItem.setFAIcon(icon: FAType.FAHome)
        //        normalViewNav.tabBarItem.image = resizeImage(image: home_image.image!, targetSize: CGSize(width: 25, height: 25))

        tabBarController = UITabBarController()
        tabBarController.tabBar.backgroundColor = UIColor.gray
        tabBarController.tabBarItem.badgeColor = .yellow
        tabBarController.tabBar.barTintColor = UIColor.PVibrantBlue
    

        tabBarController.viewControllers = [scan, history, settings]
        tabBarController.navigationItem.leftBarButtonItem = barButton(withIcon: .FAChevronLeft, withSelector: #selector(self.Logout))
        tabBarController.navigationItem.rightBarButtonItem = barButton(withIcon: .FAGrav, withSelector: #selector(self.space))
        
        navigationController = UINavigationController()
        navigationController.viewControllers = [login, tabBarController]
        navigationController.popToRootViewController(animated: false)
        
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.makeKeyAndVisible()
        window?.backgroundColor = UIColor.DBackground
        window?.rootViewController = navigationController
        
        
        return true
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
        let container = NSPersistentContainer(name: "Decipher")
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

