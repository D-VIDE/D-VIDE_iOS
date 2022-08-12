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
    case hopang
    case bold
    case medium
    case regular
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
        case .hopang:
            self.textColor = .mainOrange2
            self.font = UIFont.SDSamliphopang(.basic, size: 25)
        case .bold:
            self.textColor = .mainDarkGray
            self.font = UIFont.NotoSansKR(.bold, size: 15)
            self.textAlignment = .left
        case .medium:
            self.textColor = .mainDarkGray
            self.font = UIFont.NotoSansKR(.medium, size: 15)
        case .regular:
            self.textColor = .mainDarkGray
            self.font = UIFont.NotoSansKR(.regular, size: 12)

        }
    }
}


