//
//  SettingsLogic.swift
//  Decipher
//
//  Created by Max Nelson on 10/22/17.
//  Copyright © 2017 cplusplus. All rights reserved.
//

import UIKit

class SettingsLogic {
    
    let deli = UIApplication.shared.delegate as! AppDelegate
   
    init() {}
    
    
    //preferences
//    @objc func browser() {
//        //go to preferred browser controller
//    }
    
    @objc func saveScans(sender:UISwitch) {
        if !sender.isOn {
            clearScans()
        } else {
            deli.history.reloadHistory()
        }
        Model.instance.userSettings.saveScansInHistory = sender.isOn
    }
    
    @objc func soundEffects(sender:UISwitch) {
        
    }
    
    @objc func vibrateOnScan(sender:UISwitch) {
        
    }

    @objc func laserAnimation(sender:UISwitch) {
        
    }
    
    //social
    
    @objc func rate() {
        //TO-DO: replace maxthedev with appstore review link
        let url = URL(string: "http://maxthedev.com")!
        if UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url, options: ["":""], completionHandler: nil)
        } else {
            let alertController = UIAlertController(title: "Heads Up", message: "your preferred browser is not installed on your phone.", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            alertController.addAction(okAction)
            deli.settings.present(alertController, animated: true, completion: nil)
        }
    }
    
    @objc func share() {
        let message = "yo, checkout this QR scanner. It's lit! 🔥"
        //TO-DO: replace maxthedev with appstore review link
        let link = "maxthedev.com"
        let activityViewController: UIActivityViewController = UIActivityViewController(activityItems: [message,link], applicationActivities: nil)
        activityViewController.popoverPresentationController?.sourceView = deli.settings.view
        deli.settings.present(activityViewController, animated: true, completion: nil)
    }
    
    @objc func instagram() {
        let instagram = URL(string: "instagram://user?username=maxcodes")!
        
        if UIApplication.shared.canOpenURL(instagram) {
            UIApplication.shared.open(instagram, options: ["":""], completionHandler: nil)
        } else {
            deli.goToURL(url: URL(string: "http://www.instagram.com/maxcodes")!)
        }
    }
    
    @objc func ourWebsite() {
        deli.goToURL(url: URL(string: "http://www.maxthedev.com")!)
    }
    
    //extra
//
//    @objc func help() {
//        //go to help controller
//    }
//
    @objc func clearScans() {
        //clear them scannaroonies.
        Model.instance.scanHistory = []
        deli.history.reloadHistory()
        //tell the user too tho.
        let alertController = UIAlertController(title: "Yo!", message: "History Scans Cleared", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(okAction)
        deli.history.present(alertController, animated: true, completion: nil)
    }
    
    @objc func logout() {
        deli.Logout()
    }

    
}
