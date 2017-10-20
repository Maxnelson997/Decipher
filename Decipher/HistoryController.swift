//
//  ViewController.swift
//  Decipher
//
//  Created by Max Nelson on 10/19/17.
//  Copyright © 2017 cplusplus. All rights reserved.
//

import UIKit

class DecipherLabel:UILabel {
    
    
    fileprivate var size:CGFloat = 15
    
    init(frame:CGRect) {
        super.init(frame: .zero)
        phaseTwo()
    }
    
    init(size:CGFloat) {
        self.size = size
        phaseTwo()
        
    }
    
    func phaseTwo() {
        self.font = UIFont.init(customFont: .ProximaNovaLight, withSize: size)
        self.backgroundColor = UIColor.MNOriginalDarkGray
        self.textColor = UIColor.MNTextGray
        self.translatesAutoresizingMaskIntoConstraints = false
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}

class SettingsCell:UITableViewCell {
    
    override func awakeFromNib() {
        
    }
    override func prepareForReuse() {
        
    }
}

class HistoryCell:UITableViewCell {
    override func awakeFromNib() {
        
    }
    override func prepareForReuse() {
        
    }
}

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
        self.register(SettingsCell.self, forCellReuseIdentifier: "settingcell")
        self.register(HistoryCell.self, forCellReuseIdentifier: "historycell")
    }
}

class HistoryController: DecipherController {
    
    
    
    override func start() {

    }
    
    
}
