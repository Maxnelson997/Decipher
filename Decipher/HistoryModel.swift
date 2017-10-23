//
//  HistoryModel.swift
//  Decipher
//
//  Created by Max Nelson on 10/20/17.
//  Copyright © 2017 cplusplus. All rights reserved.
//

import UIKit

struct HistoryModel {
    var title:String!
    var url:URL!
    var isURL:Bool = false
    
    init(title:String) {
        self.title = title
        if let url = URL(string: title){ //check whether the string is URL
            self.url = url
            isURL = true
        }else {
            isURL = false
        }
    }
}

