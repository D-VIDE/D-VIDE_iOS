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


class MainNavBar: UIView  {
    required init(coder aDecoder: NSCoder) {
            super.init(coder: aDecoder)!
        }
        
    override init(frame: CGRect){
        super.init(frame: frame)
        self.backgroundColor = .white
        self.layer.addBorder([.bottom], color: .mainLightGray, width: 1)
        self.layer.cornerRadius = 18
        self.layer.maskedCorners = CACornerMask(arrayLiteral: .layerMaxXMaxYCorner, .layerMinXMaxYCorner)
        self.layer.addShadow(location: .bottom)
    }
}
