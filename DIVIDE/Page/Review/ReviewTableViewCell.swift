//
//  ReviewTableViewCell.swift
//  DIVIDE
//
//  Created by 임우섭 on 2022/12/22.
//

import UIKit
import SnapKit
import Then

class ReviewTableViewCell: UITableViewCell {
    
    lazy var detailContentsView = UIView()
    lazy var userImg = UIImageView()
    lazy var userID = MainLabel(type: .Basics1)
    lazy var userLocation = MainLabel(type: .small1)
    lazy var reviewLikeCount = MainLabel(type: .small1)
    lazy var likeBtn = UIButton()
    
    lazy var foodImg = UIImageView()
    lazy var storeNameTag = MainLabel(type: .Point2)
    lazy var contentText = UITextView()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {

        super.init(style: .value1, reuseIdentifier: "ReviewTableViewCell")
        setAttribute()
        addView()
        setLayout()
    }
    required init?(coder aDecoder: NSCoder) {

        fatalError("init(coder:) has not been implemented")

    }
    
    private func setAttribute() {
        contentView.backgroundColor = .viewBackgroundGray
        
        detailContentsView.do {
            $0.roundCorners(cornerRadius: 26, maskedCorners: [.layerMaxXMinYCorner, .layerMaxXMaxYCorner])
            $0.backgroundColor = .white
            
        }
        userImg.do {
            $0.image = UIImage(named: "logo.png")
        }
        userID.do {
            $0.text = "아직 수정중"
        }
        userLocation.do {
            $0.text = "위치정보 작업중"
        }
        reviewLikeCount.do {
            $0.text = "12345"
        }
        likeBtn.do {
            $0.setImage(UIImage(named: "like.png"), for: .normal)
            $0.setImage(UIImage(named: "unlike.png"), for: .selected)
        }
        
        foodImg.do {
            $0.image = UIImage(named: "pizzaImage.png")
        }
        storeNameTag.do {
            $0.text = "#금돼지 맛집"
        }
        contentText.do {
            $0.text = "금돼지식당 드실분~제가 LA에 있을때는 말이죠 정말 제가 꿈에무대 메이저리그로 진출하고 식당마다 싸인해달라 기자들은 항상 붙어다니며 ..."
            $0.isEditable = false
        }
    }
    
    private func addView() {
        contentView.addSubview(detailContentsView)
        detailContentsView.addSubviews([userImg, userID, userLocation, reviewLikeCount, likeBtn])
        detailContentsView.addSubviews([foodImg, storeNameTag, contentText])
    }
    
    private func setLayout() {
        detailContentsView.snp.makeConstraints { make in
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.bottom.equalToSuperview()
            make.height.equalTo(146)
        }
        userImg.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(19)
            make.top.equalToSuperview().offset(9)
            make.height.equalTo(28)
            make.width.equalTo(28)
        }
        userID.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(54)
            make.top.equalToSuperview().offset(14)
            make.height.equalTo(21)
            make.width.equalTo(100)
        }
        userLocation.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(155)
            make.top.equalToSuperview().offset(14)
            make.height.equalTo(21)
            make.width.equalTo(100)
        }
        reviewLikeCount.snp.makeConstraints { make in
            make.trailing.equalToSuperview().offset(-35)
            make.top.equalToSuperview().offset(14)
            make.height.equalTo(21)
            make.width.equalTo(35)
        }
        likeBtn.snp.makeConstraints { make in
            make.trailing.equalToSuperview().offset(-20)
            make.top.equalToSuperview().offset(20)
            make.height.equalTo(15)
            make.width.equalTo(17)
        }
        foodImg.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(19)
            make.bottom.equalToSuperview().offset(-10)
            make.height.equalTo(86)
            make.width.equalTo(87)
        }
        storeNameTag.snp.makeConstraints { make in
            make.centerX.equalTo(foodImg).offset(200)
            make.top.equalTo(foodImg).offset(1)
            make.height.equalTo(21)
            make.width.equalTo(193)
        }
        contentText.snp.makeConstraints { make in
            make.top.equalTo(storeNameTag).offset(21)
            make.leading.equalTo(storeNameTag).offset(-1)
            make.height.equalTo(43)
            make.width.equalTo(210)
        }
    }

}
