//
//  TextFieldClass.swift
//  DIVIDE
//
//  Created by 정지윤 on 2022/07/19.
//

import Foundation
import UIKit

public enum TextFieldType {
    case main
    case color
}

class MainTextField: UITextField {
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
    convenience init(type: TextFieldType) {
        self.init()
        
        switch type {
        case .main:
            self.setPaddingFor(left: 18, right: 18)
            self.backgroundColor = .white
            self.layer.borderWidth = 0.1
            self.layer.borderColor = UIColor.mainGray.cgColor
            self.layer.cornerRadius = 18
            self.layer.maskedCorners = CACornerMask(arrayLiteral: .layerMaxXMinYCorner, .layerMaxXMaxYCorner)
            self.layer.addShadow(location: .all)
            self.addTarget(self, action: #selector(textFieldTextChanged(_:)), for: .allEditingEvents)
            
        // 추후에 다른 타입 필요할 시 수정 에정
        case .color:
            self.textColor = .mainOrange
            self.font = UIFont.AppleSDGothicNeo(.bold, size: 15)
        }
    }
    
    var style: TextFieldType = .main {
       didSet {
           switch style {
           case .main:
               self.setPaddingFor(left: 18, right: 18)
               self.backgroundColor = .white
               self.layer.borderWidth = 0.1
               self.layer.borderColor = UIColor.mainGray.cgColor
               self.layer.cornerRadius = 18
               self.layer.maskedCorners = CACornerMask(arrayLiteral: .layerMaxXMinYCorner, .layerMaxXMaxYCorner)
               self.layer.addShadow(location: .all)
               
           case .color:
               self.textColor = .mainOrange
               self.font = UIFont.AppleSDGothicNeo(.bold, size: 15)
           }
       }
    }
    
    @objc func textFieldTextChanged(_ sender: UITextField) {
        if let text = sender.text, text.count > 0 && sender.isEditing {
            sender.backgroundColor = .white
            sender.borderWidth = 1.5
            sender.layer.borderColor = UIColor.mainOrange.cgColor
        } else {
            sender.backgroundColor = .white
            sender.borderWidth = 0.1
            sender.layer.borderColor = UIColor.mainGray.cgColor
        }
    }
}
