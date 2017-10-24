//
//  Model.swift
//  Decipher
//
//  Created by Max Nelson on 10/20/17.
//  Copyright © 2017 cplusplus. All rights reserved.
//

import UIKit
import Font_Awesome_Swift

class Model {
    static var instance : Model = Model()
    var settingsLogic = SettingsLogic()
    
    private init() {
        print("init singleton")
        setup()
    }
    deinit {
        print("deinit singleton")
    }
    
    class func destroy() {
        instance = Model()
        
    }
    
    /*Unlock all scans $1
    
    //recent scans settings
    Clear scans
    save recent scans
    
    //Camera settings
    laser animation
    Vibrate on scan
    Ask before opening
    
    //more settings
    Browser 
    Sound effects
    Help
    rate
    Share
    Instagram
    Our Website*/
    
    func setup() {
        //create user settings type. pull previous settings from core data. if no settings instatiate with default settings like so
        //put core data here
        //else instatiate like so
        userSettings = UserSettings(browser: "Safari", browserIcon: .FASafari, saveScansInHistory: true, soundEffects: true, vibrateOnScan: true, laserAnimation: false)
        
        //retrieve scans from core data
        scanHistory = []
        
        setSettings()
    }
    
    func setSettings() {
        settings = [
            [
                //            SettingModel(title: "Browser", icon: .FASafari, color: UIColor.MNGreen, selector: #selector(settingsLogic.browser)),
                SettingModel(title: "Save Scans In History", icon: .FAThumbsUp, swit: true, status: userSettings.saveScansInHistory, selector: #selector(settingsLogic.saveScans(sender:))),
                SettingModel(title: "Sound Effects", icon: .FAChevronRight, swit: true, status: userSettings.soundEffects, selector: #selector(settingsLogic.soundEffects(sender:))),
                SettingModel(title: "Vibrate On Scan", icon: .FAChevronRight, swit: true, status: userSettings.vibrateOnScan, selector: #selector(settingsLogic.vibrateOnScan(sender:))),
                SettingModel(title: "Laser Animation", icon: .FAChevronRight, swit: true, status: userSettings.laserAnimation, selector: #selector(settingsLogic.laserAnimation(sender:))),
                ],
            [
                SettingModel(title: "Rate", icon: .FAThumbsUp, selector: #selector(settingsLogic.rate)),
                SettingModel(title: "Share", icon: .FAShare, selector: #selector(settingsLogic.share)),
                SettingModel(title: "Instagram", icon: .FAInstagram, selector: #selector(settingsLogic.instagram)),
                SettingModel(title: "Our Website", icon: .FAChrome, color: UIColor.orange, selector: #selector(settingsLogic.ourWebsite)),
                ],
            [
                //            SettingModel(title: "Help", icon: .FAInfo, selector: #selector(settingsLogic.help)),
                SettingModel(title: "Clear Recent Scans", icon: .FARemove, color: UIColor.red, selector: #selector(settingsLogic.clearScans)),
                SettingModel(title: "Logout Of Decipher", icon: .FASignOut, color: UIColor.red, selector: #selector(settingsLogic.logout)),
                ]
        ]
    }
    
    var scanHistory:[HistoryModel]!
    var settings:[[SettingModel]]!
    var browsers:[String]!
    var userSettings:UserSettings!
    var woc:Bool = false

}



