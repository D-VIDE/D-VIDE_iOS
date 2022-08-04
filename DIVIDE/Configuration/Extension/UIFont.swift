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
    public enum NotoSansKRType: String {
        case black = "Black"
        case bold = "Bold"
        case medium = "Medium"
        case regular = "Regular"
        case light = "Light"
        case thin = "Thin"
    }
    public enum SamlipHopangType: String {
        case basic = "Basic"
        case outline = "Outline"
    }
    

    static func AppleSDGothicNeo(_ type: AppleSDGothicNeoType, size: CGFloat) -> UIFont {
        return UIFont(name: "AppleSDGothicNeo-\(type.rawValue)", size: size)!
    }
    static func NotoSansKR(_ type: NotoSansKRType, size: CGFloat) -> UIFont {
        return UIFont(name: "NotoSansKR-\(type.rawValue)", size: size)!
    }
    static func SDSamliphopang(_ type: SamlipHopangType, size: CGFloat) -> UIFont {
        return UIFont(name: "SDSamliphopangche\(type.rawValue)", size: size)!
    }
}

