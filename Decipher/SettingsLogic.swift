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
   
    init() {
        
        
        
    }
    
    //preferences
    
    @objc func browser() {
        //go to preferred browser controller
    }
    
    @objc func saveScans() {
        
    }
    
    @objc func soundEffects() {
        
    }
    
    @objc func vibrateOnScan() {
        
    }

    @objc func laserAnimation() {
        
    }
    
    //social
    
    @objc func rate() {
        
    }
    
    @objc func share() {
        
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
    
    @objc func help() {
        //go to help controller
    }
    
    @objc func clearScans() {
        Model.instance.scanHistory = []
        deli.history.reloadHistory()
    }
    

    
}