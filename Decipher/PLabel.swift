//
//  PLabel.swift
//  ProjectSync
//
//  Created by Max Nelson on 9/16/17.
//  Copyright © 2017 gadzoom. All rights reserved.
//

import UIKit

class PLabel: UILabel {
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.text = "label"
        PhaseTwo()
    }
    
    init() {
        super.init(frame: .zero)
        self.translatesAutoresizingMaskIntoConstraints = false
        self.text = "label"
        PhaseTwo()
    }
    
    init(withSize: CGFloat) {
        super.init(frame: .zero)
        self.translatesAutoresizingMaskIntoConstraints = false
        self.size = withSize
        self.text = "label"
        PhaseTwo()
    }
    

    init(text: String, withSize: CGFloat) {
        super.init(frame: .zero)
        self.translatesAutoresizingMaskIntoConstraints = false
        self.size = withSize
        self.text = text
        PhaseTwo()
    }
    
    init(text: String, withSize: CGFloat, alignment: NSTextAlignment) {
        super.init(frame: .zero)
        self.translatesAutoresizingMaskIntoConstraints = false
        self.size = withSize
        self.text = text
        self.alignment = alignment
        PhaseTwo()
    }
    
    init(text: String, withSize: CGFloat, alignment: NSTextAlignment, inset:UIEdgeInsets) {
        super.init(frame: .zero)
        self.translatesAutoresizingMaskIntoConstraints = false
        self.size = withSize
        self.text = text
        self.alignment = alignment
        self.insetValue = inset
        PhaseTwo()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    fileprivate var size:CGFloat = 20
    fileprivate var alignment:NSTextAlignment = .center
    fileprivate var insetValue:UIEdgeInsets = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
    
    func PhaseTwo() {
        self.font = UIFont.init(customFont: .ProximaNovaSemibold, withSize: size)
        self.textColor = UIColor.white
        self.textAlignment = alignment
    }
    
    override func drawText(in rect: CGRect) {
        super.drawText(in: UIEdgeInsetsInsetRect(rect, self.insetValue))
    }
    
//    var attributedText: NSAttributedString {
//        get {
//            return self.attributedText
//        }
//        set {
//            UIView.animate(withDuration: 0.3, animations: {
//                self.alpha = 0
//            }, completion: { finished in
//                self.attributedText = newValue
//                UIView.animate(withDuration: 0.3, animations: {
//                    self.alpha = 1
//                })
//            })
//            
//            //            titleLabel?.attributedText = newValue
//            
//        }
//    }
}
