//
//  UILabel.swift
//  DIVIDE
//
//  Created by 정지윤 on 2022/07/04.
//

import UIKit

extension UILabel {
    func addAttributedText(text: String, attributedText: String, font: UIFont) {
        let attributedStr = NSMutableAttributedString(string: text)
        attributedStr.addAttribute(.font, value: font, range: (text as NSString).range(of: attributedText))
        self.attributedText = attributedStr
    }
}
