//
//  UIFont.swift
//  DIVIDE
//
//  Created by 정지윤 on 2022/07/04.
//

import Foundation
import UIKit

extension UIFont {
    public enum AppleSDGothicNeoType: String {
        case bold = "Bold"
        case regular = "Regular"
        case medium = "Medium"
    }

    static func AppleSDGothicNeo(_ type: AppleSDGothicNeoType, size: CGFloat) -> UIFont {
        return UIFont(name: "AppleSDGothicNeo-\(type.rawValue)", size: size)!
    }
}

