//
//  DButton.swift
//  Decipher
//
//  Created by Max Nelson on 10/23/17.
//  Copyright © 2017 cplusplus. All rights reserved.
//

import UIKit

class DButton: UIButton {
    override init(frame: CGRect) {
        super.init(frame: .zero)
        phaseTwo()
    }
    
    init() {
        super.init(frame: .zero)
        phaseTwo()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("coder(init:) as not been implemented")
    }
    
    func phaseTwo() {
        
    }
    
    //accessors and mutators
    
    //animate text
    var text:String {
        get {
            return titleLabel!.text!
        } set {
            UIView.animate(withDuration: 0.3, animations: {
                self.alpha = 0
            }, completion: { finished in
                self.setTitle(newValue, for: .normal)
                UIView.animate(withDuration: 0.3, animations: {
                    self.alpha = 1
                })
            })
        }
    }
    
    
}
