//
//  HistoryCell.swift
//  Decipher
//
//  Created by Max Nelson on 10/20/17.
//  Copyright © 2017 cplusplus. All rights reserved.
//

import UIKit

class HistoryCell:UITableViewCell {
    let title:DecipherLabel = {
        let l = DecipherLabel(size: 20)
        l.layer.masksToBounds = true
        l.layer.cornerRadius = 4
        l.backgroundColor = UIColor.MNDarkGray
        return l
    }()
    override func awakeFromNib() {
        contentView.backgroundColor = UIColor.clear
        contentView.addSubview(title)
        NSLayoutConstraint.activate(title.getConstraintsTo(view: contentView, withInsets: .init(top: 2, left: 5, bottom: 2, right: 5)))
    }
    override func prepareForReuse() {
        title.removeFromSuperview()
    }
}

