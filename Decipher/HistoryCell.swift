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
        l.backgroundColor = UIColor.clear
        l.adjustsFontSizeToFitWidth = true
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
        stack.addArrangedSubview(icon)
        NSLayoutConstraint.activate(stack.getConstraintsTo(view: contentView, withInsets: .init(top: 0, left: 10, bottom: 0, right: 10)))
        NSLayoutConstraint.activate([
            title.widthAnchor.constraint(lessThanOrEqualTo: stack.widthAnchor),
            icon.widthAnchor.constraint(equalTo: stack.heightAnchor),
            ])
    }
    override func prepareForReuse() {
        title.removeFromSuperview()
    }
}

