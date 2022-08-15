//
//  CALayer.swift
//  DIVIDE
//
//  Created by 정지윤 on 2022/07/04.
//

import UIKit

extension CALayer {


    func addBorder(_ arr_edge: [UIRectEdge], color: UIColor, width: CGFloat) {
        for edge in arr_edge {
            let border = CALayer()
            switch edge {
            case UIRectEdge.top:
                border.frame = CGRect.init(x: 0, y: 0, width: frame.width, height: frame.height)
                break
            case UIRectEdge.bottom:
                border.frame = CGRect.init(x: 0, y: frame.height - width, width: frame.width, height: width)
                break
            case UIRectEdge.left:
                border.frame = CGRect.init(x: 0, y: 0, width: width, height: frame.height)
                break
            case UIRectEdge.right:
                border.frame = CGRect.init(x: frame.width - width, y: 0, width: width, height: frame.height)
                break
            default:
                break
            }
            
            border.backgroundColor = color.cgColor
            self.addSublayer(border)
        }
    }
    
    
    enum VerticalLocation {
            case bottom
            case top
            case left
            case right
            case all
        }

    func addShadow(location: VerticalLocation, color: UIColor = .shadowGray, opacity: Float = 0.3, radius: CGFloat = 2.0) {
        switch location {
        case .bottom:
             addShadow(offset: CGSize(width: 0, height: 2), color: color, opacity: opacity, radius: radius)
        case .top:
            addShadow(offset: CGSize(width: 0, height: -2), color: color, opacity: opacity, radius: radius)
        case .left:
            addShadow(offset: CGSize(width: -2, height: 0), color: color, opacity: opacity, radius: radius)
        case .right:
            addShadow(offset: CGSize(width: 2, height: 0), color: color, opacity: opacity, radius: radius)
        case .all:
            addShadow(offset: CGSize(width: 0, height: 2), color: color, opacity: opacity, radius: radius)
            addShadow(offset: CGSize(width: 0, height: -2), color: color, opacity: opacity, radius: radius)
            addShadow(offset: CGSize(width: -2, height: 0), color: color, opacity: opacity, radius: radius)
            addShadow(offset: CGSize(width: 2, height: 0), color: color, opacity: opacity, radius: radius)
        }
    }

    func addShadow(offset: CGSize, color: UIColor = .black, opacity: Float = 0.1, radius: CGFloat = 3.0) {
        self.masksToBounds = false
        self.shadowColor = color.cgColor
        self.shadowOffset = offset
        self.shadowOpacity = opacity
        self.shadowRadius = radius
    }
}

