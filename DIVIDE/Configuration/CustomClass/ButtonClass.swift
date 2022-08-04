//
//  ButtonClass.swift
//  DIVIDE
//
//  Created by 정지윤 on 2022/07/19.
//

import Foundation
import UIKit

public enum CustomButtonType {
    case mainAction
    case color
}

class MainButton: UIButton {
    required init(coder aDecoder: NSCoder) {
            super.init(coder: aDecoder)!
        }
        
    override init(frame: CGRect){
        super.init(frame: frame)
    }
    
    init() {
        super.init(frame:CGRect.zero)
    }
    
    // 보조 이니셜라이저
    convenience init(type: CustomButtonType) {
        self.init()
        
        switch type {
        case .mainAction:
            self.setTitleColor(.white, for: .normal)
            self.backgroundColor = .mainOrange2
            self.titleLabel?.font = UIFont.SDSamliphopang(.basic, size: 20)
            self.layer.cornerRadius = 25
            self.layer.maskedCorners = CACornerMask(arrayLiteral: .layerMaxXMinYCorner, .layerMinXMinYCorner, .layerMaxXMaxYCorner, .layerMinXMaxYCorner)
        case .color:
            self.backgroundColor = .mainOrange2
        }
    }
    
    var style: CustomButtonType = .mainAction {
       didSet {
           switch style {
           case .mainAction:
               self.setTitle("업로드 하기", for: .normal)
               self.setTitleColor(.white, for: .normal)
               self.backgroundColor = .mainOrange2
               self.layer.cornerRadius = 18
               self.layer.maskedCorners = CACornerMask(arrayLiteral: .layerMaxXMinYCorner, .layerMinXMinYCorner)
               
           case .color:
               self.backgroundColor = .mainOrange2
           }
       }
   }
}
