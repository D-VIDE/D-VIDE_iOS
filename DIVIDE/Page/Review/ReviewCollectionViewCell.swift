//
//  ReviewCollectionViewCell.swift
//  DIVIDE
//
//  Created by 임우섭 on 2022/12/29.
//

import UIKit

class ReviewCollectionViewCell: UICollectionViewCell {
    lazy var foodImg = UIImageView().then {
         $0.cornerRadius = 13
     }
     
     lazy var rankLabel = MainLabel(type: .small3).then {
         $0.text = "1위"
         $0.textColor = .mainOrange2
     }
     
     
     override func awakeFromNib() {
         super.awakeFromNib()
         // Initialization code
     }
}
