//
//  SettingModel.swift
//  Decipher
//
//  Created by Max Nelson on 10/20/17.
//  Copyright © 2017 cplusplus. All rights reserved.
//

import UIKit
import Font_Awesome_Swift

enum browserType:String {
    case safari = "safari"
    case chrome = "chrome"
    case firefox = "firefox"
    case operamini = "operamini"
}

struct SettingModel {
    var title:String!
    var icon:FAType!
    var status:Bool = false
    var isSwitch:Bool = false
    var iconColor:UIColor!
    
    init(title:String) {
        self.title = title
    }
    
    init(title:String, icon:FAType, swit:Bool? = false, color:UIColor? = UIColor.MNTextGray) {
        self.title = title
        self.icon = icon
        self.isSwitch = swit!
        self.iconColor = color
    }
}

