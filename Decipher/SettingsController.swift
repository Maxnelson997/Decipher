//
//  SettingController.swift
//  Decipher
//
//  Created by Max Nelson on 10/20/17.
//  Copyright © 2017 cplusplus. All rights reserved.
//

import UIKit

class SettingsController: DecipherTableController {
    
    let model = Model.instance

    
    override func start() {
        reloadHistory()
    }
    
    func reloadHistory() {
        if tableView.dataSource != nil {
            tableView.reloadData()
        } else {
            tableView.delegate = self
            tableView.dataSource = self
        }
    }

    //datasource
    override func numberOfSections(in tableView: UITableView) -> Int {
        return model.settings.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return model.settings[section].count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "settingcell", for: indexPath) as! SettingCell
 
        let setting = model.settings[indexPath.section][indexPath.item]
        cell.location = indexPath
        cell.title.text = setting.title
        cell.gestureRecognizers?.removeAll()
        cell.swit.removeTarget(model.settingsLogic, action: nil, for: .allTouchEvents)
        
        if setting.hasSwitch {
            cell.isSwitch = true
            cell.swit.isOn = setting.status
            cell.swit.tag = indexPath.item
            cell.swit.addTarget(model.settingsLogic, action: setting.selector, for: .valueChanged)
        } else {
            cell.addGestureRecognizer(UITapGestureRecognizer(target: model.settingsLogic, action: setting.selector))
            cell.icon.setFAIcon(icon: setting.icon, iconSize: 22, forState: .normal)
            cell.icon.setFATitleColor(color: setting.iconColor)
        }
        cell.selectionStyle = .none
        cell.backgroundColor = .clear
        cell.awakeFromNib()
        return cell
    }

    
    //delegate
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        (UIApplication.shared.delegate as! AppDelegate).goToURL(url: model.scanHistory[indexPath.item].url)
       
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 {
            return "preferences"
        }
        if section == 1 {
            return "social"
        }
        return "extra"
    }
}
