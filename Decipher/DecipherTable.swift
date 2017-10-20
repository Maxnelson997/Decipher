//
//  DecipherTable.swift
//  Decipher
//
//  Created by Max Nelson on 10/20/17.
//  Copyright © 2017 cplusplus. All rights reserved.
//

import UIKit

class DecipherTable:UITableView {
    required init?(coder aDecoder: NSCoder) {
        fatalError("coder(init:) has not yet been implemented")
    }
    
    init() {
        super.init(frame: .zero, style: .grouped)
        phaseTwo()
    }
    
    func phaseTwo() {
        self.translatesAutoresizingMaskIntoConstraints = false
        self.backgroundColor = UIColor.MNOriginalDarkGray
        self.register(SettingCell.self, forCellReuseIdentifier: "settingcell")
        self.register(HistoryCell.self, forCellReuseIdentifier: "historycell")
    }
}
