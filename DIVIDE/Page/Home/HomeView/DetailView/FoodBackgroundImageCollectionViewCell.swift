////
////  FoodBackgroundImageCollectionViewCell.swift
////  DIVIDE
////
////  Created by 임우섭 on 2022/08/22.
////
//
//import UIKit
//import SnapKit
//import Then
//
//class FoodBackgroundImageCollectionViewCell: UICollectionViewCell {
//    
//    static let identifier = "foodBackgroundImageCell"
//    
//    var foodImage = UIImageView().then {
//        $0.backgroundColor = .red
//        $0.sizeToFit()
//    }
//    //델리게이트로 받아온 사진 넣음
//    override init(frame: CGRect) {
//
//        super.init(frame: frame)
//        
//        contentView.addSubview(foodImage)
//        
//        setImageCollectionView()
//    }
//
//    required init?(coder aDecoder: NSCoder) {
//
//        fatalError("init(coder:) has not been implemented")
//    }
//    
//    func setImageCollectionView() {
//        self.backgroundColor = .white
//        self.layer.masksToBounds = true
//        self.layer.cornerRadius = 7
//        foodImage.snp.makeConstraints { make in
//            make.center.equalToSuperview()
//            make.width.equalToSuperview()
//            make.height.equalToSuperview()
//        }
//    }
//}
