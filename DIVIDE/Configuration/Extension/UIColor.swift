//
//  UIColor.swift
//  DIVIDE
//
//  Created by 정지윤 on 2022/07/04.
//

import UIKit

extension UIColor {
    convenience init(hex: UInt, alpha: CGFloat = 1.0) {
        self.init(
            red: CGFloat((hex & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((hex & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(hex & 0x0000FF) / 255.0,
            alpha: CGFloat(alpha)
        )
    }
    
    class var disable: UIColor { UIColor(hex: 0xCCCCCC) }
    
    
    class var mainOrange1: UIColor { UIColor(hex: 0xFF8A00)}
    class var mainOrange2: UIColor { UIColor(hex: 0xFF7C03)}
    class var mainYellow: UIColor { UIColor(hex: 0xFFBD2F)}
    
    class var mainDarkGray: UIColor { UIColor(hex: 0x5B5B5B)}
    class var mainGray: UIColor { UIColor(hex: 0x8D8D8D)}
    class var mainLightGray: UIColor { UIColor(hex: 0xB0B0B0)}
    class var backgroundGray: UIColor { UIColor(hex: 0xF5F5F5)}
    class var viewBackgroundGray: UIColor { UIColor(hex: 0xF8F8F8)}

}

