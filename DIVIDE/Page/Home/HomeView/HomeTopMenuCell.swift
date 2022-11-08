//
//  HomeTopMenuBar.swift
//  DIVIDE
//
//  Created by 임우섭 on 2022/07/25.
//

import UIKit
import Then
import SnapKit
class HomeTopMenuCell: UICollectionViewCell {
    
    static let identifier = "HomeTopMenuCell"
    
    var menuLabel = MainLabel(type: .Basics2).then {
        $0.textColor = .gray2
    }
    
    override var isSelected: Bool {
        didSet {
            if isSelected {
                contentView.backgroundColor = .mainOrange1
                menuLabel.textColor = .white
            } else {
                contentView.backgroundColor = .gray0
                menuLabel.textColor = .gray2
            }
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentView.addSubview(menuLabel)
        
        setMenuCollectionView()
    }

    required init?(coder aDecoder: NSCoder) {

        fatalError("init(coder:) has not been implemented")

    }
    
    func setMenuCollectionView(){
        self.backgroundColor = .viewBackgroundGray
        self.layer.masksToBounds = true
        self.layer.cornerRadius = 7
        menuLabel.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
    }
    
}
