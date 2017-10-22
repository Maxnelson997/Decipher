//
//  SettingCell.swift
//  Decipher
//
//  Created by Max Nelson on 10/20/17.
//  Copyright © 2017 cplusplus. All rights reserved.
//

import UIKit
import Font_Awesome_Swift

class SettingCell:UITableViewCell {
    let title:DecipherLabel = {
        let l = DecipherLabel(size: 20)
        l.layer.masksToBounds = true
        l.layer.cornerRadius = 4
        l.backgroundColor = UIColor.clear
        return l
    }()
    
    let icon:UIButton = {
        let v = UIButton()
        v.isUserInteractionEnabled = false
        v.backgroundColor = UIColor.clear
        v.setFAIcon(icon: .FAChevronRight, iconSize: 22, forState: .normal)
        
        v.setFATitleColor(color: UIColor.MNTextGray)
        return v
    }()
    
    var isSwitch:Bool = false
    
    let switContainer:UIView = {
        let v = UIView()
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()
    let swit:UISwitch = {
        let s = UISwitch()
        s.translatesAutoresizingMaskIntoConstraints = false
        s.onTintColor = UIColor.MNGreen
        return s
    }()
    
    var stack:UIStackView = {
       let s = UIStackView()
        s.translatesAutoresizingMaskIntoConstraints = false
        s.backgroundColor = .clear
        s.distribution = .fill
        s.axis = .horizontal
        return s
    }()

    override func awakeFromNib() {
        contentView.backgroundColor = UIColor.clear
        contentView.addSubview(stack)
        stack.addArrangedSubview(title)
        var v:UIView = icon
        if isSwitch {
            stack.addArrangedSubview(switContainer)
            switContainer.addSubview(swit)
            NSLayoutConstraint.activate([swit.centerXAnchor.constraint(equalTo: switContainer.centerXAnchor), swit.centerYAnchor.constraint(equalTo: switContainer.centerYAnchor)])
            v = switContainer
        } else {
            stack.addArrangedSubview(icon)
        }
      
        NSLayoutConstraint.activate(stack.getConstraintsTo(view: contentView, withInsets: .init(top: 0, left: 10, bottom: 0, right: 10)))
        NSLayoutConstraint.activate([
            title.widthAnchor.constraint(lessThanOrEqualTo: stack.widthAnchor),
            v.widthAnchor.constraint(equalTo: stack.heightAnchor),
            ])
    }
    override func prepareForReuse() {
        stack.removeFromSuperview()
    }
}

