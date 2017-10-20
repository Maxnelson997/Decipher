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
        //retrieve scans from core data
        scanHistory = []
        settings = [
           SettingModel(title: "Save Scans In History", icon: .FAThumbsUp),
           SettingModel(title: "Clear Recent Scans", icon: .FARemove),
           SettingModel(title: "Preferred Browser", icon: .FASafari),
           SettingModel(title: "Automatically Open Link", icon: .FAChevronRight),
           SettingModel(title: "Sound Effects", icon: .FAChevronRight),
           SettingModel(title: "Vibrate On Scan", icon: .FAChevronRight),
           SettingModel(title: "Laser Animation", icon: .FAChevronRight),
           SettingModel(title: "Help", icon: .FAAssistiveListeningSystems),
           SettingModel(title: "Rate", icon: .FAThumbsUp),
           SettingModel(title: "Share", icon: .FAShare),
           SettingModel(title: "Instagram", icon: .FAInstagram),
           SettingModel(title: "Our Website", icon: .FAChrome),
        ]
    }
    
    var scanHistory:[HistoryModel]!
    var settings:[SettingModel]!

}


