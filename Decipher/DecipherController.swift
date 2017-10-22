//
//  DecipherController.swift
//  Decipher
//
//  Created by Max Nelson on 10/20/17.
//  Copyright © 2017 cplusplus. All rights reserved.
//

import UIKit

class DecipherController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.MNOriginalDarkGray
        start()
    }
    
    func start() {}
    
}


class DecipherTableController: UITableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.contentInset = UIEdgeInsets(top: -44, left: 0, bottom: 0, right: 0)
        self.tableView.backgroundColor = UIColor.MNOriginalDarkGray
        self.tableView.separatorStyle = .none
        self.tableView.register(SettingCell.self, forCellReuseIdentifier: "settingcell")
        self.tableView.register(HistoryCell.self, forCellReuseIdentifier: "historycell")
        start()
    }
    
    func start() {}
    
}

