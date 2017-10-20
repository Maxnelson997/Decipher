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
    
    init(title:String) {
        self.title = title
    }
    
    init(title:String, icon:FAType) {
        self.title = title
        self.icon = icon
    }
}

