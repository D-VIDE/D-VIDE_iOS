//
//  TagCollectionViewCell.swift
//  DIVIDE
//
//  Created by 정지윤 on 2022/07/21.
//

import UIKit
import SnapKit

class TagCollectionViewCell: UICollectionViewCell {
    static let reuseIdentifier = "TagCollectionViewCell"
    static let nibName = "TagCollectionViewCell"
    
    
    let tagLabel = MainLabel().then {
        $0.textColor = .mainGray
        $0.font = UIFont.AppleSDGothicNeo(.medium, size: 13)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)

        contentView.addSubview(tagLabel)
        contentView.backgroundColor = .white
        contentView.layer.masksToBounds = true
        contentView.layer.cornerRadius = 10

        setConstraint()
      }

      func setConstraint() {
        tagLabel.snp.makeConstraints {
          $0.center.equalToSuperview()
        }
      }

      required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
      }
}
