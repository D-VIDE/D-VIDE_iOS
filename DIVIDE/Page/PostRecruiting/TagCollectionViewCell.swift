//
//  TagCollectionViewCell.swift
//  DIVIDE
//
//  Created by 정지윤 on 2022/07/21.
//

import UIKit
import SnapKit

class TagCollectionViewCell: UICollectionViewCell {
    
    override var isSelected: Bool {
        didSet{
            if isSelected {
                contentView.backgroundColor = .mainOrange2
                tagLabel.textColor = .white
            } else {
                contentView.backgroundColor = .white
                tagLabel.textColor = .gray2
            }
        }
    }
    
    let tagLabel = MainLabel().then {
        $0.textColor = .gray2
        $0.font = UIFont.NotoSansKR(.bold, size: 12)
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
