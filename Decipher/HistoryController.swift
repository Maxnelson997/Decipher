//
//  ViewController.swift
//  Decipher
//
//  Created by Max Nelson on 10/19/17.
//  Copyright © 2017 cplusplus. All rights reserved.
//

import UIKit

class HistoryController: DecipherTableController {
    
    let model = Model.instance
    
    override func start() {
        reloadHistory()
        
    }
    
    func reloadHistory() {
        if model.userSettings.saveScansInHistory {
            if tableView.dataSource != nil {
                tableView.reloadData()
            } else {
                tableView.delegate = self
                tableView.dataSource = self
            }
        }
    }
    
    //datasource
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return model.scanHistory.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "historycell", for: indexPath) as! HistoryCell
        cell.title.text = model.scanHistory[indexPath.item].title
        cell.awakeFromNib()
        cell.selectionStyle = .none
        cell.backgroundColor = .clear
        return cell
    }
    
    //delegate
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if model.scanHistory[indexPath.item].isURL {
            (UIApplication.shared.delegate as! AppDelegate).goToURL(url: model.scanHistory[indexPath.item].url)
        } else {
            let alertController = UIAlertController(title: "Bruh..", message: "This is not a valid web URL.", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            alertController.addAction(okAction)
            present(alertController, animated: true, completion: nil)
        }
        
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "recent scans"
    }
    

}
