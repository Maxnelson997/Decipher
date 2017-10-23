//
//  PTextField.swift
//  ProjectSync
//
//  Created by Max Nelson on 9/16/17.
//  Copyright © 2017 gadzoom. All rights reserved.
//

import UIKit

class PTextField:UITextField {
    override init(frame: CGRect) {
        super.init(frame: frame)
        phaseTwo()
    }
    
    init() {
        super.init(frame: .zero)
        translatesAutoresizingMaskIntoConstraints = false
        phaseTwo()
    }
    
    init(customFont:CustomFont, size: CGFloat, placeholder:String) {
        super.init(frame: .zero)
        translatesAutoresizingMaskIntoConstraints = false
        self.fontValue = UIFont.init(customFont: customFont, withSize: size)!
        self.placeholderValue = placeholder
        phaseTwo()
    }
    
    init(customFont:CustomFont, size: CGFloat, placeholder:String, type:UIKeyboardType) {
        super.init(frame: .zero)
        translatesAutoresizingMaskIntoConstraints = false
        self.fontValue = UIFont.init(customFont: customFont, withSize: size)!
        self.placeholderValue = placeholder
        self.keyboardType = type
        phaseTwo()
    }
    

    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    fileprivate var fontValue:UIFont = {
        let font = UIFont.init(customFont: .ProximaNovaLight, withSize: 20)
        return font!
    }()
    
    fileprivate var placeholderValue:String = {
        return "text"
    }()
    

    

    
    func phaseTwo() {
//        self.backgroundColor = UIColor.PWhite
        self.backgroundColor = UIColor.white
        self.textColor = UIColor.MNDarkGray
        
        self.font = fontValue
        self.placeholder = self.placeholderValue
        
        self.autocorrectionType = .no
        self.autocapitalizationType = .none
        self.spellCheckingType = .no
        
        let spacerView = UIView(frame:CGRect(x: 0, y: 0, width: 5, height: 10))
        self.leftViewMode = .always
        self.leftView = spacerView
        self.tintColor = UIColor.MNDarkGray
    }
    
    
    
    
}
