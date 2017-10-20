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


enum CustomFont: String {

    case ProximaNovaLight = "ProximaNova-Regular"
    case ProximaNovaThin = "ProximaNovaT-Thin"
    case ProximaNovaRegular = "ProximaNova-Light"
    case ProximaNovaSemibold = "ProximaNova-Semibold"
}

extension UIFont {
    convenience init?(customFont: CustomFont, withSize size: CGFloat) {
        self.init(name: customFont.rawValue, size: size)
    }
}

extension UIView {
    func getConstraintsTo(view: UIView, withInsets:UIEdgeInsets) -> [NSLayoutConstraint] {
        print(withInsets)
        
        return [
            self.leftAnchor.constraint(equalTo: view.leftAnchor, constant: withInsets.left),
            self.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -1*(withInsets.right)),
            self.topAnchor.constraint(equalTo: view.topAnchor, constant: withInsets.top),
            self.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -1*(withInsets.bottom
                ))
        ]
    }
}

extension UIColor {
    
    open class var DBackground: UIColor { return UIColor.init(rgb: 0xB5DFFF) }
    open class var DBarBlack: UIColor { return UIColor.init(rgb: 0x232323) }
    open class var MNDarkGray: UIColor { return UIColor.init(rgb: 0x1C1D1D) } //0x232323 //0x1D1D1D
    open class var MNGray: UIColor { return UIColor.init(rgb:  0x292A2A) } //0x525252 //0x383939
    open class var MNOriginalDarkGray: UIColor { return UIColor.init(rgb: 0x232323) }
    open class var MNGreen: UIColor { return UIColor.init(rgb: 0x5CFF90) }
    open class var MNBlue: UIColor { return UIColor.init(rgb: 0x7ECDFD) }
    open class var MNTextGray: UIColor { return UIColor.init(rgb: 0xFEFDFE) }
    open class var MNMagenta: UIColor { return UIColor.init(rgb: 0xEC34FF) }
    
    
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


