//
//  DecipherLabel.swift
//  Decipher
//
//  Created by Max Nelson on 10/20/17.
//  Copyright © 2017 cplusplus. All rights reserved.
//

import UIKit

class DecipherLabel:UILabel {
    
    
    fileprivate var size:CGFloat = 15
    
    override init(frame:CGRect) {
        super.init(frame: .zero)
        phaseTwo()
    }
    
    init(size:CGFloat) {
        super.init(frame: .zero)
        self.size = size
        phaseTwo()
        
    }
    
    func phaseTwo() {
        self.font = UIFont.init(customFont: .ProximaNovaLight, withSize: size)
        self.backgroundColor = UIColor.MNOriginalDarkGray
        self.textColor = UIColor.MNTextGray
        self.translatesAutoresizingMaskIntoConstraints = false
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func drawText(in rect: CGRect) {
        super.drawText(in: UIEdgeInsetsInsetRect(rect, UIEdgeInsets(top: 0, left: 5, bottom: 0, right: 5)))
    }
    
    
}
