//
//  NavBarClass.swift
//  DIVIDE
//
//  Created by 정지윤 on 2022/07/19.
//

import Foundation
import UIKit

public enum NavBarType {
    case main
    case color
}


class MainNavBar: UINavigationBar  {
    required init(coder aDecoder: NSCoder) {
            super.init(coder: aDecoder)!
        }
        
    override init(frame: CGRect){
        super.init(frame: frame)
//        self.isTransparent = false
        self.backgroundColor = .white
        self.tintColor = .mainOrange2
//        self.isTranslucent = false
        self.layer.addBorder([.bottom, .left, .right], color: .mainLightGray, width: 0.1)
        self.frame = CGRect(x: 0, y: 0, width: self.frame.size.width, height: 120)
        self.layer.cornerRadius = 18
        self.layer.maskedCorners = CACornerMask(arrayLiteral: .layerMaxXMaxYCorner, .layerMinXMaxYCorner)
        self.layer.addShadow(location: .all)
//        self.titleTextAttributes = [NSAttributedString.Key.font: UIFont(name: "SDSamliphopangcheBasic", size: 20)!]
    }
    
    
    // 보조 이니셜라이저
//    convenience init(type: NavBarType) {
//        self.init()
//
//        switch type {
//        case .main:
//            self.tintColor = .white
//            self.layer.cornerRadius = 18
//            self.layer.borderWidth = 0.1
//    //        self.layer.borderColor = UIColor.mainGray.cgColor
//            self.layer.maskedCorners = CACornerMask(arrayLiteral: .layerMaxXMaxYCorner, .layerMinXMaxYCorner)
//            self.layer.addShadow(location: .all)
//        case .color:
//            self.tintColor = .mainOrange
//        }
//    }
//
//    var style: NavBarType = .main {
//       didSet {
//           switch style {
//           case .main:
//               self.tintColor = .white
//               self.layer.cornerRadius = 18
//               self.layer.borderWidth = 0.1
//       //        self.layer.borderColor = UIColor.mainGray.cgColor
//               self.layer.maskedCorners = CACornerMask(arrayLiteral: .layerMaxXMaxYCorner, .layerMinXMaxYCorner)
//               self.layer.addShadow(location: .all)
//           case .color:
//               self.tintColor = .mainOrange
//           }
//       }
//   }
}
