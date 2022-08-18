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
        $0.image = UIImage(systemName: "ladybug")
    }
    lazy var rankLabel = MainLabel(type: .small3).then {
        $0.text = "1위"
        $0.textColor = .mainOrange2
    }
    lazy var titleLabel = MainLabel(type: .small0).then {
        $0.text = "한남점 토스트"
        $0.textColor = UIColor(hex: 0x787878)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentView.backgroundColor = .red
        contentView.addSubviews([foodImg, rankLabel, titleLabel])
        
        foodImg.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.left.right.equalToSuperview().offset(3)
            make.width.equalTo(100)
            make.height.equalTo(98)
        }
        rankLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(foodImg.snp.bottom).offset(3)
        }
        titleLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(rankLabel.snp.bottom).offset(4)
            make.horizontalEdges.equalTo(foodImg.snp.horizontalEdges)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
