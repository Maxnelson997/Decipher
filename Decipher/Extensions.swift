//
//  Extensions.swift
//  Decipher
//
//  Created by Max Nelson on 10/20/17.
//  Copyright © 2017 cplusplus. All rights reserved.
//

import UIKit

func delay(_ delay: Double, closure: @escaping ()->()) {
    DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + Double(Int64(delay * Double(NSEC_PER_SEC))) / Double(NSEC_PER_SEC), execute: closure)
}


extension UIColor {
    
    open class var DBackground: UIColor { return UIColor.init(rgb: 0xB5DFFF) }
    open class var PWhite: UIColor { return UIColor.init(rgb: 0xBFBFBF) }
    open class var PBlueOne: UIColor { return UIColor.init(rgb: 0x1E313F) }
    open class var PVibrantBlue: UIColor { return UIColor.init(rgb: 0x132A4B) }
    open class var PLighterGray: UIColor { return UIColor.init(rgb: 0x646872) }
    open class var PDarkerGray: UIColor { return UIColor.init(rgb: 0x323640) }
    open class var PBorderGray: UIColor { return UIColor.init(rgb: 0x37424B) }
    open class var PBorderGrayTwo: UIColor { return UIColor.init(rgb: 0x374B5B) }
    open class var PLightBlue: UIColor { return UIColor.init(rgb: 0x34536B) }
    open class var PButtonBlue: UIColor { return UIColor.init(rgb: 0x2e4a60) }
    open class var PTan: UIColor { return UIColor.init(rgb: 0x9F9A86) }
    
    convenience init(red: Int, green: Int, blue: Int) {
        assert(red >= 0 && red <= 255, "Invalid red component")
        assert(green >= 0 && green <= 255, "Invalid green component")
        assert(blue >= 0 && blue <= 255, "Invalid blue component")
        
        self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: 1.0)
    }
    
    convenience init(rgb: Int) {
        self.init(
            red: (rgb >> 16) & 0xFF,
            green: (rgb >> 8) & 0xFF,
            blue: rgb & 0xFF
        )
    }
}


