//
//  Model.swift
//  Decipher
//
//  Created by Max Nelson on 10/20/17.
//  Copyright © 2017 cplusplus. All rights reserved.
//

import UIKit

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
    
    func setup() {
        
    }
    
    var scanHistory:[HistoryModel]!

}


