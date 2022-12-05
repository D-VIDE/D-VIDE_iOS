//
//  TagCollectionViewCell.swift
//  DIVIDE
//
//  Created by 정지윤 on 2022/07/21.
//

import UIKit
import SnapKit

class TagCollectionViewCell: UICollectionViewCell {
    let tagLabel = MainLabel(type: .Basics2)
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
    
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setAttribute()
        addView()
        setLayout()
    }
    
    func setAttribute() {
        self.backgroundColor = .white
        self.layer.masksToBounds = true
        self.layer.cornerRadius = 10
        
        tagLabel.do {
            $0.textAlignment = .center
            $0.textColor = .gray2
            $0.font = UIFont.NotoSansKR(.bold, size: 12)
        }
        
    }
    func addView() {
        contentView.addSubview(tagLabel)
    }
    func setLayout() {
        
        tagLabel.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
