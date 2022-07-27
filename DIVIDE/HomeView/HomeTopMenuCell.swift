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
    
    let menuLabel = UILabel().then {
        $0.font = .systemFont(ofSize: 12, weight: .bold)
        $0.textColor = .tagGray
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
        self.backgroundColor = .orange
        self.layer.masksToBounds = true
        self.layer.cornerRadius = 7
        menuLabel.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
    }
    
}
