//
//  SNSTableViewCell.swift
//  DIVIDE
//
//  Created by 정지윤 on 2022/08/13.
//

import UIKit
import Then
import SnapKit
import Cosmos

class SNSTableViewCell: UITableViewCell {
    
    static let identifier = "SNSTableViewCell"
    
    let cellView = UIView().then {
        $0.backgroundColor = .white
        $0.roundCorners(cornerRadius: 26, maskedCorners: [.layerMaxXMinYCorner, .layerMaxXMaxYCorner])
        $0.layer.addShadow(location: .all)
    }
    
    let likeView = UIView().then {
        $0.backgroundColor = .mainYellow
    }
    
    lazy var profileImg = UIImageView().then {
        $0.cornerRadius = 14
        $0.image = UIImage(named: "basicProfileImg")
        $0.clipsToBounds = true
    }
    lazy var nicknameLabel = MainLabel(type: .Basics1).then {
        $0.text = "kksmedd10204"
        $0.textColor = .black
    }
    lazy var locationLabel = MainLabel(type: .small1).then {
        $0.text = "세종시 조치원읍"
        $0.textColor = .gray2
    }
    lazy var likeCountLabel = MainLabel(type: .small1).then {
        $0.text = "12,049"
        $0.textColor = UIColor(hex: 0x787878)
    }
    lazy var likeButton = UIButton().then {
        $0.setImage(UIImage(named: "unlike"), for: .normal)
    }
    lazy var foodImg = UIImageView().then {
        $0.cornerRadius = 13
        $0.image = UIImage(named: "foodExample")
    }
    lazy var storeLabel = MainLabel(type: .Point2).then {
        $0.text = "#금돼지식당 복천점"
        $0.textColor = .highlight
    }
    lazy var reviewLabel = MainLabel(type: .small1).then {
        $0.text = "금돼지식당 드실분~제가 LA에 있을때는 말이죠 정말 제가 꿈에무대 메이저리그로 진출하고 식당마다 싸인해달라 기자들은 항상 붙어다니며 ..."
        $0.textAlignment = .left
        $0.numberOfLines = 3
        $0.lineBreakMode = .byTruncatingTail
    }
    lazy var starView = CosmosView().then {
        $0.rating = 4
        $0.settings.updateOnTouch = false
        $0.settings.filledImage = UIImage(named: "filledStar")
        $0.settings.emptyImage = UIImage(named: "unfilledStar")
        $0.settings.fillMode = .full
        $0.settings.starMargin = 3.24
        $0.settings.starSize = 10
    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.backgroundColor = .viewBackgroundGray
        contentView.addSubview(cellView)
        contentView.addSubview(likeView)
        cellView.addSubviews([profileImg, nicknameLabel, locationLabel, likeButton, likeCountLabel, foodImg, storeLabel, reviewLabel, starView])
        
        setConstraints()
        
        likeView.isHidden = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    func setConstraints() {
        cellView.snp.makeConstraints { make in
            make.top.bottom.trailing.leading.equalToSuperview()
                .inset(UIEdgeInsets(top: 0, left: 20, bottom: 15, right: 20))
        }
        likeView.snp.makeConstraints { make in
            make.height.equalTo(146)
            make.leading.equalToSuperview()
            make.trailing.equalTo(cellView.snp.leading)
            make.centerY.equalTo(cellView.snp.centerY)
        }
        profileImg.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(9)
            make.leading.equalToSuperview().offset(19)
            make.width.height.equalTo(28)
        }
        nicknameLabel.snp.makeConstraints { make in
            make.centerY.equalTo(profileImg)
            make.leading.equalTo(profileImg.snp.trailing).offset(7)
        }
        locationLabel.snp.makeConstraints { make in
            make.centerY.equalTo(profileImg)
            make.leading.equalTo(nicknameLabel.snp.trailing).offset(7)
        }
        likeButton.snp.makeConstraints { make in
            make.centerY.equalTo(profileImg)
            make.trailing.equalToSuperview().offset(-19)
            make.width.equalTo(17)
            make.height.equalTo(15)
        }
        likeCountLabel.snp.makeConstraints { make in
            make.centerY.equalTo(profileImg)
            make.trailing.equalTo(likeButton.snp.leading).offset(-3)
        }
        foodImg.snp.makeConstraints { make in
            make.height.width.equalTo(86)
            make.top.equalTo(profileImg.snp.bottom).offset(8)
            make.leading.equalTo(profileImg.snp.leading)
            make.bottom.equalToSuperview().offset(-15)
        }
        storeLabel.snp.makeConstraints { make in
            make.top.equalTo(foodImg.snp.top).offset(3)
            make.leading.equalTo(foodImg.snp.trailing).offset(16)
            make.trailing.equalTo(likeButton.snp.trailing)
        }
        reviewLabel.snp.makeConstraints { make in
            make.top.equalTo(storeLabel.snp.bottom).offset(5)
            make.leading.equalTo(storeLabel.snp.leading)
            make.trailing.equalTo(likeButton.snp.trailing)
            make.bottom.greaterThanOrEqualTo(starView.snp.top).offset(-3)
        }
        starView.snp.makeConstraints { make in
            make.leading.equalTo(storeLabel.snp.leading)
            make.bottom.equalTo(foodImg.snp.bottom).offset(-3)
        }
        
    }

}
