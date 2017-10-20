//
//  ViewController.swift
//  Decipher
//
//  Created by Max Nelson on 10/19/17.
//  Copyright © 2017 cplusplus. All rights reserved.
//

import UIKit

class HistoryController: DecipherController {
    
    let model = Model.instance
    
    let table = DecipherTable()
    
    override func start() {
        view.addSubview(table)
        NSLayoutConstraint.activate(table.getConstraintsTo(view: view, withInsets: .zero))
        reloadHistory()
    }
    
    func reloadHistory() {
        if table.dataSource != nil {
            table.reloadData()
        } else {
            table.delegate = self
            table.dataSource = self
        }
    }
    
    
}

extension HistoryController: UITableViewDataSource, UITableViewDelegate {
    //datasource
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return model.scanHistory.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "historycell", for: indexPath) as! HistoryCell
        cell.title.text = model.scanHistory[indexPath.item].title
        cell.awakeFromNib()
        return cell
    }
    
    //delegate
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
}
