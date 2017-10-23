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
struct UserSettings {
    var browser:String!
    var browserIcon:FAType!
    var saveScansInHistory:Bool!
    var soundEffects:Bool!
    var vibrateOnScan:Bool!
    var laserAnimation:Bool!
}
