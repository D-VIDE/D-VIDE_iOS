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
    
    class var black18: UIColor { UIColor(hex: 0x121212) }
    class var yellowBackground: UIColor { UIColor(hex: 0xFFD264) }
    class var lightOrange: UIColor { UIColor(hex: 0xFEF8E8) }
    class var profileBorderGray: UIColor { UIColor(hex: 0xEEEEEE) }
    class var textFieldBackgroundGray: UIColor { UIColor(hex: 0xF5F5F5) }
    class var buttonOrange: UIColor { UIColor(hex: 0xFFAD2A) }
    class var buttonGray: UIColor { UIColor(hex: 0xBABABA) }
    class var navigationBarDefaultColor: UIColor { UIColor(red: (247/255), green: (247/255), blue: (247/255), alpha: 1) }
    class var pageControlOrange: UIColor { UIColor(hex: 0xFFAD2A) }
    class var pageControlGray: UIColor { UIColor(hex: 0xEEEEEE) }
    
    class var mainOrange: UIColor { UIColor(hex: 0xFF7C03)}
    class var mainYellow: UIColor { UIColor(hex: 0xF5BF50)}
    class var mainGray: UIColor { UIColor(hex: 0x777777)}
    class var backgroundGray: UIColor { UIColor(hex: 0xF5F5F5)}
    class var viewBackgroundGray: UIColor { UIColor(hex: 0xEFEFF0)}

}

