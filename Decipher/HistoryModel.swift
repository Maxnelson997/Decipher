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
    var url:URL = URL(string: "http://www.maxthedev.com")!
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
    
    init(fromDict:NSDictionary) {
        if let d = fromDict as? [String: AnyObject] {
            self.title = d["title"] as! String
            self.url = URL(string: d["url"] as! String)!
            self.isURL = (d["isURL"] != nil)
        }
    }
    
    func asDictionaryForFirebase() -> NSDictionary {
        let dict:NSDictionary = ["title":title,"url":url.absoluteString,"isURL":isURL]
        return dict
    }
    
    
}

