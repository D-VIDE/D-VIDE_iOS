//
//  UIImage.swift
//  DIVIDE
//
//  Created by 정지윤 on 2022/07/04.
//

import UIKit
import Photos
import Kingfisher

extension UIImage {
    func resize(toTargetSize targetSize: CGSize) -> UIImage? {
        let width = (self.size.width / self.size.height < targetSize.width / targetSize.height) ? targetSize.width : (targetSize.width * self.size.width / self.size.height)
        let height = (self.size.height / self.size.width < targetSize.height / targetSize.width) ? targetSize.height : (targetSize.height * self.size.height / self.size.width)
        let target = CGRect(x: 0, y: 0, width: width, height: height)
        UIGraphicsBeginImageContextWithOptions(target.size, false, UIScreen.main.scale)
        draw(in: target, blendMode: .normal, alpha: 1)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage
    }
    
    func imageWithBorder(width: CGFloat, color: UIColor) -> UIImage? {
        let square = CGSize(width: min(size.width, size.height) + width * 2, height: min(size.width, size.height) + width * 2)
        let imageView = UIImageView(frame: CGRect(origin: CGPoint(x: 0, y: 0), size: square))
        imageView.contentMode = .scaleAspectFill
        imageView.image = self
        imageView.layer.borderWidth = width
        imageView.layer.borderColor = color.cgColor
        imageView.layer.cornerRadius = square.width / 2
        imageView.clipsToBounds = true
        UIGraphicsBeginImageContextWithOptions(imageView.bounds.size, false, scale)
        guard let context = UIGraphicsGetCurrentContext() else { return nil }
        imageView.layer.render(in: context)
        let result = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return result
    }
    
    // MARK:- 빈 사진
    static let empty = UIImage()
    
    // MARK:- 버튼 사진
    static let btnCheckboxActive = UIImage(named: "btnCheckboxActive")
    static let btnCheckboxInactive = UIImage(named: "btnCheckboxInactive")
    static let btnBack = UIImage(named: "btnBack")
    
    // MARK:- 뚱닭 그림자
    static let imgShadow = UIImage(named: "imgShadow")
    
    // MARK:- 알 사진
    static let imgEggDiamond = UIImage(named: "imgEggDiamond")
    static let imgEggGold = UIImage(named: "imgEggGold")
    static let imgEggSilver = UIImage(named: "imgEggSilver")
    static let imgEggWhite = UIImage(named: "imgEggWhite")
    
    // MARK: - 픽 에그 인터렉션 안내 화살표 사진
    static let imgPickeggArrow = UIImage(named: "icPickeggArrow")
    
    // MARK:- 상품 사진
    static let imgNopickEgg = UIImage(named: "imgNopickEgg")
    static let imgCloseEgg = UIImage(named: "imgCloseEgg")
    
    // MARK:- Placeholder
    static let imgProductPlaceholder = UIImage(named: "imgNopickEgg")
    static let imgProfilePlaceholder = UIImage(named: "imgDefaultProfile")
    
    // MARK:- 프로필 기본 사진
    static let imgDefaultProfile = UIImage(named: "imgDefaultProfile")
    
    // MARK: - 타임어택 배너
    static let imgHomeTimebannerOn = UIImage(named: "imgHomeTimebannerOn")
    static let imgHomeTimebannerOff = UIImage(named: "imgHomeTimebannerOff")
}

