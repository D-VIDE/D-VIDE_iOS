//
//  UIView.swift
//  DIVIDE
//
//  Created by 정지윤 on 2022/07/04.
//

import UIKit

@IBDesignable
extension UIView {
    @IBInspectable var cornerRadius: CGFloat {
        get { return self.layer.cornerRadius }
        set {
            self.clipsToBounds = true
            self.layer.cornerRadius = newValue
        }
    }
    
    @IBInspectable var borderWidth: CGFloat {
        get { return self.layer.borderWidth }
        set { self.layer.borderWidth = newValue }
    }
    
    @IBInspectable var borderColor: UIColor? {
        get { return (self.layer.borderColor != nil) ? UIColor(cgColor: self.layer.borderColor!) : nil }
        set { self.layer.borderColor = newValue?.cgColor }
    }
    
    func roundCorner(corners: CACornerMask, cornerRadius: CGFloat) {
        self.layer.cornerRadius = cornerRadius
        self.clipsToBounds = true
        self.layer.maskedCorners = corners
    }
    
    func createDottedLine(width: CGFloat, color: CGColor) {
        let caShapeLayer = CAShapeLayer()
        caShapeLayer.strokeColor = color
        caShapeLayer.lineWidth = width
        caShapeLayer.lineDashPattern = [2,3]
        let cgPath = CGMutablePath()
        let cgPoint = [CGPoint(x: 0, y: 0), CGPoint(x: self.frame.width, y: 0)]
        cgPath.addLines(between: cgPoint)
        caShapeLayer.path = cgPath
        layer.addSublayer(caShapeLayer)
    }
    
}
