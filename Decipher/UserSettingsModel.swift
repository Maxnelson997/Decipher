//
//  UserSettingsModel.swift
//  Decipher
//
//  Created by Max Nelson on 10/22/17.
//  Copyright © 2017 cplusplus. All rights reserved.
//

import UIKit
import Font_Awesome_Swift

//model for the users selected settings. gotta implement core data with this somehow.
class UserSettings {
    var browser:String!
    var browserIcon:FAType!
    var saveScansInHistory:Bool!
    var soundEffects:Bool!
    var vibrateOnScan:Bool!
    var laserAnimation:Bool!
    
    
    init(browser:String, browserIcon:FAType, saveScansInHistory:Bool, soundEffects:Bool, vibrateOnScan:Bool, laserAnimation:Bool) {
        self.browser = browser
        self.browserIcon = browserIcon
        self.saveScansInHistory = saveScansInHistory
        self.soundEffects = soundEffects
        self.vibrateOnScan = vibrateOnScan
        self.laserAnimation = laserAnimation
    }
    
    
    func asFirebaseDictionary() -> NSDictionary {
        let dict:NSMutableDictionary = [:]
        dict["browser"] = self.browser
        dict["saveScansInHistory"] = self.saveScansInHistory
        dict["soundEffects"] = self.soundEffects
        dict["vibrateOnScan"] = self.vibrateOnScan
        dict["laserAnimation"] = self.laserAnimation
        dict["scans"] = getScanHistoryArray()
        return dict
    }
    
    
    func getScanHistoryArray() -> NSArray {

        var scanHistoryArray:[NSDictionary] = []
        for scan in Model.instance.scanHistory {
            scanHistoryArray.append(scan.asDictionaryForFirebase())
        }
        return NSArray(array: scanHistoryArray)
    }
    
    
    
}
