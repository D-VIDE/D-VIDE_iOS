//
//  ViewClass.swift
//  DIVIDE
//
//  Created by 정지윤 on 2022/07/19.
//

import Foundation
import UIKit

public enum ViewType {
    case touch
    case color
}

class MainView: UIView {
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
    convenience init(type: ViewType) {
        self.init()
        
        switch type {
        case .touch:
            self.isUserInteractionEnabled = true
            self.backgroundColor = .clear
        case .color:
            self.backgroundColor = .mainOrange2
        }
    }
    
    var style: ViewType = .touch {
       didSet {
           switch style {
           case .touch:
               self.isUserInteractionEnabled = true
               self.backgroundColor = .clear
           case .color:
               self.backgroundColor = .mainOrange2
           }
       }
   }
}
