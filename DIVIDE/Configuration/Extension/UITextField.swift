//
//  UITextField.swift
//  DIVIDE
//
//  Created by 정지윤 on 2022/07/04.
//

import UIKit

extension UITextField {
    func setPaddingFor(left: CGFloat = 0, right: CGFloat = 0) {
        let leftPaddingView = UIView(frame: CGRect(x: 0, y: 0, width: left, height: self.frame.size.height))
        self.leftView = leftPaddingView
        self.leftViewMode = .always
        
        let rightPaddingView = UIView(frame: CGRect(x: 0, y: 0, width: right, height: self.frame.size.height))
        self.rightView = rightPaddingView
        self.rightViewMode = .always
    }
    
}
