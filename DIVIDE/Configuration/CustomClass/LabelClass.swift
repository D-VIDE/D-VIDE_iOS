//
//  LabelClass.swift
//  DIVIDE
//
//  Created by 정지윤 on 2022/07/19.
//

import Foundation
import UIKit
import Then

public enum LabelType {
    case gray
    case color
}

class MainLabel: UILabel {
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
    convenience init(type: LabelType) {
        self.init()
        
        switch type {
        case .gray:
            self.textColor = .mainGray
            self.font = UIFont.AppleSDGothicNeo(.bold, size: 15)
        case .color:
            self.textColor = .mainOrange
            self.font = UIFont.AppleSDGothicNeo(.bold, size: 15)
        }
    }
    
    var style: LabelType = .gray {
       didSet {
           switch style {
           case .gray:
               self.textColor = .mainGray
               self.font = UIFont.AppleSDGothicNeo(.bold, size: 15)
               
           case .color:
               self.textColor = .mainOrange
               self.font = UIFont.AppleSDGothicNeo(.bold, size: 15)
           }
       }
   }
    
}


