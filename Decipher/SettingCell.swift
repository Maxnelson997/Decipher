//
//  SettingCell.swift
//  Decipher
//
//  Created by Max Nelson on 10/20/17.
//  Copyright © 2017 cplusplus. All rights reserved.
//

import UIKit

class SettingCell:UITableViewCell {
    let title:DecipherLabel = DecipherLabel(size: 15)
    override func awakeFromNib() {
        contentView.backgroundColor = UIColor.MNOriginalDarkGray
        contentView.addSubview(title)
        NSLayoutConstraint.activate(title.getConstraintsTo(view: contentView, withInsets: .init(top: 0, left: 5, bottom: 0, right: 5)))
    }
    override func prepareForReuse() {
        title.removeFromSuperview()
    }
}

