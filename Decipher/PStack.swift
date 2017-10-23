//
//  PStack.swift
//  ProjectSync
//
//  Created by Max Nelson on 9/23/17.
//  Copyright © 2017 gadzoom. All rights reserved.
//

import UIKit

class PStack:UIStackView {
    override init(frame: CGRect) {
        super.init(frame: .zero)
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(axis:UILayoutConstraintAxis) {
        super.init(frame: .zero)
        self.axis = axis
 
        self.distribution = .fill
    }
}
