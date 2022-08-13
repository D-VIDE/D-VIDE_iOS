//
//  SNSCollectionViewCell.swift
//  DIVIDE
//
//  Created by 정지윤 on 2022/08/13.
//

import UIKit
import Then
import SnapKit

class SNSCollectionViewCell: UICollectionViewCell {
    
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
