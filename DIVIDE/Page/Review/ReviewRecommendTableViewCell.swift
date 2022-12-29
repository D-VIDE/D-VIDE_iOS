//
//  ReviewRecommendTableViewCell.swift
//  DIVIDE
//
//  Created by 임우섭 on 2022/12/29.
//

import UIKit

class ReviewRecommendTableViewCell: UITableViewCell {
    private let recommendCollectionView = UICollectionView()
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {

        super.init(style: .value1, reuseIdentifier: "ReviewRecommendTableViewCell")
        setAttribute()
        addView()
        setLayout()
        recommendCollectionView.register(ReviewCollectionViewCell.self, forCellWithReuseIdentifier: "ReviewCollectionViewCell")
    }
    required init?(coder aDecoder: NSCoder) {

        fatalError("init(coder:) has not been implemented")

    }
    
    func setAttribute(){
        recommendCollectionView.do {
            let layout = UICollectionViewFlowLayout()
            layout.scrollDirection = .horizontal
            layout.minimumLineSpacing = 4
            $0.collectionViewLayout = layout
            $0.backgroundColor = .viewBackgroundGray
            $0.showsVerticalScrollIndicator = false
            $0.contentInset = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
        }
    }
    func addView() {
        self.contentView.addSubview(recommendCollectionView)
    }
    func setLayout() {
        recommendCollectionView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.bottom.equalToSuperview()
            make.leading.equalToSuperview()
            make.width.greaterThanOrEqualToSuperview()
        }
    }
    

}
