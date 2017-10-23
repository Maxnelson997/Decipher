//
//  PTextFieldWithHeader.swift
//  ProjectSync
//
//  Created by Max Nelson on 9/23/17.
//  Copyright © 2017 gadzoom. All rights reserved.
//

import UIKit

class PTextFieldWithHeader:PStack {

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    init(customFont:CustomFont, textSize:CGFloat = 20, headerSize:CGFloat = 15,  placeholder:String, withHeaderName:String? = nil, inset:UIEdgeInsets = UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5), alignment:NSTextAlignment = .left, type:UIKeyboardType = .alphabet) {
        super.init(axis: .vertical)
        var headerName:String = placeholder
        if let l = withHeaderName {
            headerName = l
        }
        translatesAutoresizingMaskIntoConstraints = false
        header = PLabel(text: headerName.uppercased(), withSize: headerSize, alignment: alignment, inset: inset)
        
        header.adjustsFontSizeToFitWidth = true
        header.backgroundColor = UIColor.MNGray
        field = PTextField(customFont: customFont, size: textSize, placeholder: placeholder.uppercased(), type: type)
        addArrangedSubview(header)
        addArrangedSubview(field)
        distribution = .fill
        NSLayoutConstraint.activate([
            heightAnchor.constraint(equalToConstant: 70),
            field.heightAnchor.constraint(equalToConstant: 40)
            ])
    }
    

    
    var delegate:UITextFieldDelegate {
//        didSet {
//            field.delegate = delegate
//        }
        get {
            return field.delegate!
        }
        set {
            field.delegate = newValue
        }
    }
    
    
    var text:String {
        get {
            return field.text!
        }
        set {
            field.text = newValue
        }
    }

    fileprivate var stack:PStack = PStack(axis: .vertical)
    fileprivate var header:PLabel!
    fileprivate var field:PTextField!
    
    var headerColor:UIColor {
        get {
            return header.backgroundColor!
        } set {
            header.backgroundColor = newValue
        }
    }


}
