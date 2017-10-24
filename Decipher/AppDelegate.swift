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
import AVFoundation
import Firebase
import FirebaseDatabase
import NVActivityIndicatorView

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var navigationController:UINavigationController!
    
    var login:LoginController!
    var scan:ScanController!
    var history:HistoryController!
    var settings:SettingsController!
    
    var historyNav:UINavigationController!
    var settingsNav:UINavigationController!
    var scanNav:UINavigationController!

    var tabBarController:UITabBarController!
    var loadAnimation:NVActivityIndicatorView = NVActivityIndicatorView(frame: .zero, type: .ballPulseSync, color: .white, padding: 0)
    
    //Firebase
    var db:DatabaseReference!
    
    @objc func createUser(email:String,password:String) {
        print("attempting to create user with credentials: username: \(email), password: \(password)")
        Auth.auth().createUser(withEmail: email, password: password) { (user, error) in
            print("firebase create user ,user, response: \(String(describing: user))")
            print("firebase create user ,error, response: \(String(describing: error))")
            
            print("\n\n")
            
            if error == nil {
                //creation successful
                let uid = Auth.auth().currentUser?.uid

                //DB JUNK
                //save the user into the database
                self.db.child("users").child(uid!).updateChildValues(["username":email])
          
                
                if let user = user {
                    if let emailForNewUser = user.email {
                        print("account succesfuly created \(emailForNewUser)")
                        let alertController = UIAlertController(title: "Heads Up", message: "account succesfuly created", preferredStyle: .alert)
                        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
                        alertController.addAction(okAction)
                        self.login.present(alertController, animated: true, completion: nil)
                        self.Login(email: user.email, password: password)
                        
                    }
                }
            } else {
                if let error = error {
                    var description = error.localizedDescription
                    print("error logging in. description: \(description)")
                    if description == "The email address is badly formatted." {
                        description = "Please enter a valid email address to sign up."
                    }
                    print("error creating user with description: \(description)")
                    let alertController = UIAlertController(title: "Heads Up", message: description, preferredStyle: .alert)
                    let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
                    alertController.addAction(okAction)
                    self.login.present(alertController, animated: true, completion: nil)
                }
            }
        }
    }
    
    @objc func Login(email:String? = "",password:String? = "",withoutCredentials:Bool = false) {
        Model.instance.woc = withoutCredentials
        if withoutCredentials {
            navigationController.pushViewController(tabBarController, animated: true)
            return
        }
        print("attempting to SIGN IN user with credentials: username: \(String(describing: email!)), password: \(String(describing: password!))")
        delay(0.1) {
                 self.loadAnimation.startAnimating()
        }
   
        self.login.uistate(active: false)
        Auth.auth().signIn(withEmail: email!, password: password!) { (user, error) in
            print("firebase create user ,user, response: \(String(describing: user))")
            print("firebase create user ,error, response: \(String(describing: error))")

            print("\n\n")

            if let error = error {
                var description = error.localizedDescription
                print("error logging in. description: \(description)")
                if description == "The password is invalid or the user does not have a password." {
                    description = "Invalid username or password."
                }
                let alertController = UIAlertController(title: "Heads Up", message: description, preferredStyle: .alert)
                let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
                alertController.addAction(okAction)
                self.login.present(alertController, animated: true, completion: nil)
            } else {
                print("login success")
                self.settings.navigationItem.titleView = self.makeTitle(titleText: "Settings - \((email!).capitalizingFirstLetter())")
                //save
                Model.instance.isloggedin = true
    
             
                //retrieve nsarray of scans
                self.retrieveScans()
                
                self.navigationController.pushViewController(self.tabBarController, animated: true)
            }
            self.loadAnimation.stopAnimating()
            self.login.uistate(active: true)
            
            
        }
       
    }
    
    func regenerateControllers() {
        Model.instance.setSettings()
        tabBarController.selectedIndex = 1
        settings.reloadHistory()
        history.reloadHistory()
    }
    
    @objc func Logout() {
        //reset all data
        regenerateControllers()
        Model.instance.scanHistory = []
        let firebaseAuth = Auth.auth()
        print("user with uid: ")
        print(String(describing: firebaseAuth.currentUser?.uid))
        do {
            try firebaseAuth.signOut()
    
            navigationController.popToViewController(login, animated: true)
            print("logout success")
            Model.instance.isloggedin = false
        } catch let signOutError as NSError {
            print ("Error signing out: %@", signOutError)
            let alertController = UIAlertController(title: "Heads Up", message: "couldn't logout, try again.", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            alertController.addAction(okAction)
            settings.present(alertController, animated: true, completion: nil)
            
        }
        
        
    }
    

    
    @objc func syncScans() {
        if !Model.instance.woc {
            let uid = Auth.auth().currentUser?.uid
            
            //        self.db.child("users").child(uid!).setValue([)
            self.db.child("users").child(uid!).updateChildValues(["scanHistory":Model.instance.userSettings.getScanHistoryArray()])
        }

    }
    
    @objc func retrieveScans() {
        let uid = Auth.auth().currentUser?.uid
        db.child("users").child(uid!).observeSingleEvent(of: .value, with: { (snapshot) in
            //get user value
            let value = snapshot.value as? NSDictionary
            if let scans = value?["scanHistory"] as? [NSDictionary] {
                for scan in scans {
                    Model.instance.scanHistory.append(HistoryModel(fromDict: scan))
                }
                self.history.reloadHistory()
            } else {
                print("no scans?")
            }
            if let saveScansInHistory = value?["saveScansInHistory"] as? Bool {
                Model.instance.userSettings.saveScansInHistory = saveScansInHistory
            }
            if let soundEffects = value?["soundEffects"] as? Bool {
                Model.instance.userSettings.soundEffects = soundEffects
            }
            if let vibrateOnScan = value?["vibrateOnScan"] as? Bool {
                Model.instance.userSettings.vibrateOnScan = vibrateOnScan
            }
            if let laserAnimation = value?["laserAnimation"] as? Bool {
                Model.instance.userSettings.laserAnimation = laserAnimation
            }
            //update the settings. values for settings tableview.
            Model.instance.setSettings()
        }) { (error) in
            print(error.localizedDescription)
        }
    }
    
    @objc func goToClear() {
        Model.instance.settingsLogic.clearScans()
    }
    
    func barButton(withIcon: FAType, withSelector: Selector, color:UIColor = .white) -> UIBarButtonItem {
        let b = UIButton(type: .custom)
        b.setFAIcon(icon: withIcon, iconSize: 30, forState: UIControlState.normal)
        b.setFATitleColor(color: color)
        b.contentHorizontalAlignment = .left
        b.frame = CGRect(x: 0, y: 0, width: 30, height: 0)
        b.addTarget(self, action: withSelector, for: .touchUpInside)
        return UIBarButtonItem(customView: b)
    }
    
    //help
    func createTitle(titleText:String) -> UIButton {
        let navTitle = UIButton(type: .custom)
        navTitle.setTitle(titleText, for: .normal)
        navTitle.titleLabel?.font = UIFont.init(customFont: .ProximaNovaSemibold, withSize: 20)
        navTitle.backgroundColor = UIColor.clear
        navTitle.setTitleColor(UIColor.darkGray, for: .normal)
        return navTitle
    }
    
    
    func makeTitle(titleText:String) -> UIButton {
        let navTitle = UIButton(type: .custom)
        navTitle.setTitle(titleText, for: .normal)
        navTitle.titleLabel?.adjustsFontSizeToFitWidth = true
        navTitle.titleLabel?.font = UIFont.init(customFont: .ProximaNovaSemibold, withSize: 20)
        navTitle.setTitleColor(UIColor.MNTextGray, for: .normal)
        return navTitle
    }
    
    @objc func goBackToScan() {
        scan = ScanController()
        scan.navigationItem.titleView = makeTitle(titleText: "Scan")
        scanNav.viewControllers = [scan]
    }
    
    @objc func space() {
        
    }
    var on:Bool = false
    @objc func turnOnLight() {
        
        guard let device = AVCaptureDevice.default(for: .video) else { return }
        
        if device.hasTorch {
            do {
                try device.lockForConfiguration()
                
                if on == false {
                    device.torchMode = .on
                } else {
                    device.torchMode = .off
                }
                
                on = !on
                
                device.unlockForConfiguration()
            } catch {
                print("Torch could not be used")
            }
        } else {
            print("Torch is not available")
        }
    }
    
    @objc func openInBrowser() {
        //open in preferred browser
        //preferred browser is set in settings
        //defualt browser is safari.
        //use FAIcon for safari or chrome / preferred browser, ya feel Maxwell? ya I feel bruh. :D
        print("open in preferred browswer")
        
        var browser = Model.instance.userSettings.browser
        if browser == "opera" {
            browser = "opera://open-url?url=http://"
        } else if browser == "firefox" {
            browser = "firefox://open-url?url=http://"
        } else if browser == "chrome" {
            browser = "googlechrome://"
        } else if browser == "safari" {
            browser = "safari://"
        }
        
        if UIApplication.shared.canOpenURL(webController.url) {
            UIApplication.shared.open(webController.url, options: ["":""], completionHandler: nil)
        } else {
            let alertController = UIAlertController(title: "Heads Up", message: "your preferred browser is not installed on your phone.", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            alertController.addAction(okAction)
            webController.present(alertController, animated: true, completion: nil)
        }
    }
    var webController:WebViewController!
    @objc func goToURL(url:URL) {
        webController = WebViewController()
        webController.url = url
        webController.navigationItem.titleView = makeTitle(titleText: url.absoluteString)
        webController.navigationItem.leftBarButtonItem = barButton(withIcon: .FAChevronLeft, withSelector: #selector(self.goBackToHistory))
        webController.navigationItem.rightBarButtonItem = barButton(withIcon: .FASafari, withSelector: #selector(self.openInBrowser))
        //FASafari, FAChrome, FAFirefox, FAOpera
        showBar()
        navigationController.pushViewController(webController, animated: true)
    }
    
    @objc func goBackToHistory() {
        navigationController.popViewController(animated: true)
        UIView.animate(withDuration: 0.3, animations: {
            self.navigationController?.navigationBar.transform = CGAffineTransform(translationX: 0, y: -200)
        }) { (false) in }
    }
    
    func showBar() {
        UIView.animate(withDuration: 0.3, animations: {
           self.navigationController.navigationBar.transform = CGAffineTransform(translationX: 0, y: 0)
        }) { (true) in }
    }
 
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        
        FirebaseApp.configure()
        db = Database.database().reference()
        
        
        login = LoginController()
        scan = ScanController()
//        let scanWithin:QRCodeReaderViewController = scan.readerVC
        history = HistoryController()
        settings = SettingsController()
        
        scan.navigationItem.titleView = makeTitle(titleText: "Scan")
        history.navigationItem.titleView = makeTitle(titleText: "History")
        settings.navigationItem.titleView = makeTitle(titleText: "Settings")
        settings.navigationItem.rightBarButtonItem = barButton(withIcon: .FASignOut, withSelector: #selector(self.Logout), color: UIColor.MNRed)
        history.navigationItem.rightBarButtonItem = barButton(withIcon: .FARemove, withSelector: #selector(self.goToClear), color: UIColor.MNRed)
        scan.navigationItem.rightBarButtonItem = barButton(withIcon: .FALightbulbO, withSelector: #selector(self.turnOnLight), color: UIColor.yellow)
//        scan.navigationItem.rightBarButtonItem = barButton(withIcon: .FALightbulbO, withSelector: #selector(self.turnOnLight), color: UIColor.MNRed)
        
        scanNav = UINavigationController(rootViewController: scan)
        scanNav.tabBarItem.title = "scan"
        scanNav.tabBarItem.setFAIcon(icon: .FAQrcode, size: nil, orientation: .up, textColor: UIColor.white, backgroundColor: UIColor.clear, selectedTextColor: UIColor.MNGreen.withAlphaComponent(1), selectedBackgroundColor: .clear)
        scanNav.tabBarItem.setTitleTextAttributes([NSAttributedStringKey.font:UIFont.init(customFont: .ProximaNovaLight, withSize: 16)!, NSAttributedStringKey.foregroundColor:UIColor.white], for: .normal)
        
//        let scanNav1 = UINavigationController(rootViewController: scanWithin)
//        scanNav1.tabBarItem.title = "scan"
//        scanNav1.tabBarItem.setFAIcon(icon: .FAQrcode, size: nil, orientation: .up, textColor: UIColor.white, backgroundColor: UIColor.clear, selectedTextColor: UIColor.MNGreen.withAlphaComponent(1), selectedBackgroundColor: .clear)
//        scanNav1.tabBarItem.setTitleTextAttributes([NSAttributedStringKey.font:UIFont.init(customFont: .ProximaNovaLight, withSize: 16)!, NSAttributedStringKey.foregroundColor:UIColor.white], for: .normal)
        
        historyNav = UINavigationController(rootViewController: history)
        historyNav.tabBarItem.title = "history"
        historyNav.tabBarItem.setFAIcon(icon: .FAHistory, size: nil, orientation: .up, textColor: UIColor.white, backgroundColor: UIColor.clear, selectedTextColor: UIColor.MNGreen.withAlphaComponent(1), selectedBackgroundColor: .clear)
        historyNav.tabBarItem.setTitleTextAttributes([NSAttributedStringKey.font:UIFont.init(customFont: .ProximaNovaLight, withSize: 16)!, NSAttributedStringKey.foregroundColor:UIColor.white], for: .normal)
        settingsNav = UINavigationController(rootViewController: settings)
        settingsNav.tabBarItem.title = "settings"
      
        settingsNav.tabBarItem.setFAIcon(icon: .FACogs, size: nil, orientation: .up, textColor: UIColor.white, backgroundColor: UIColor.clear, selectedTextColor: UIColor.MNGreen.withAlphaComponent(1), selectedBackgroundColor: .clear)
        settingsNav.tabBarItem.setTitleTextAttributes([NSAttributedStringKey.font:UIFont.init(customFont: .ProximaNovaLight, withSize: 16)!, NSAttributedStringKey.foregroundColor:UIColor.white], for: .normal)
        
//        scanNav.tabBarItem.setFAIcon(icon: FAType.FAHome)
        //        normalViewNav.tabBarItem.image = resizeImage(image: home_image.image!, targetSize: CGSize(width: 25, height: 25))

        tabBarController = UITabBarController()
        tabBarController.tabBar.barTintColor = UIColor.MNGray
        UIApplication.shared.statusBarStyle = .lightContent
        UINavigationBar.appearance().barTintColor = UIColor.MNGray

        tabBarController.viewControllers = [historyNav, scanNav, settingsNav]
        tabBarController.navigationItem.leftBarButtonItem = barButton(withIcon: .FAChevronLeft, withSelector: #selector(self.Logout))
        tabBarController.navigationItem.rightBarButtonItem = barButton(withIcon: .FAGrav, withSelector: #selector(self.space))
        
        navigationController = UINavigationController()
        navigationController.viewControllers = [login, tabBarController]
        navigationController.popToRootViewController(animated: false)
        
        tabBarController.selectedIndex = 1
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.makeKeyAndVisible()
        window?.backgroundColor = UIColor.DBackground
        window?.rootViewController = navigationController
        window?.addSubview(loadAnimation)
        loadAnimation.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            loadAnimation.centerXAnchor.constraint(equalTo: (window?.centerXAnchor)!),
            loadAnimation.centerYAnchor.constraint(equalTo: (window?.centerYAnchor)!, constant: 25),
            loadAnimation.widthAnchor.constraint(equalToConstant: 50),
            loadAnimation.heightAnchor.constraint(equalToConstant: 50),
            ])

        
        
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
        login.saveCredentialsInCoreData()
        self.saveContext()
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
        login.saveCredentialsInCoreData()
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

