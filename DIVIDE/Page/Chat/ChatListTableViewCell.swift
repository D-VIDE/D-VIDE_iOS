//
//  ChatListTableViewCell.swift
//  DIVIDE
//
//  Created by 정지윤 on 2022/08/05.
//

import UIKit
import Then
import SnapKit

class ChatListTableViewCell: UITableViewCell {
    static let reuseIdentifier = "ChatListTableViewCell"
    
    let cellView = UIView().then {
        $0.backgroundColor = .white
        $0.roundCorners(cornerRadius: 26, maskedCorners: [.layerMinXMaxYCorner, .layerMinXMinYCorner, .layerMaxXMinYCorner, .layerMaxXMaxYCorner])
        $0.layer.addShadow(location: .all)
    }
    
    let menuImg = UIImageView().then {
        $0.image = UIImage(systemName: "globe.asia.australia")
        $0.roundCorners(cornerRadius: 15, maskedCorners: [.layerMinXMaxYCorner, .layerMinXMinYCorner, .layerMaxXMinYCorner, .layerMaxXMaxYCorner])
    }
    let titleLabel = MainLabel(type: .Point4).then {
        $0.text = "삼첩분식 드실 분 ~"
        $0.textColor = .black
    }
    
    let lastTextLabel = MainLabel(type: .Basics1).then {
        $0.text = "넹 좋아요"
        $0.textColor = .gray2
    }
    
    let timeLabel = MainLabel(type: .small1).then {
        $0.text = "오후 2:32"
        $0.textColor = .gray1
    }
    let msgNumView = UIView().then {
        $0.backgroundColor = .mainYellow
        $0.cornerRadius = 10
    }
    let msgNumLabel = MainLabel(type: .Basics3).then {
        $0.text = "5"
        $0.textColor = .white
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.addSubview(cellView)
        cellView.addSubviews([menuImg, titleLabel, lastTextLabel, timeLabel, msgNumView])
        msgNumView.addSubview(msgNumLabel)
        
        cellView.snp.makeConstraints { make in
            make.top.bottom.trailing.leading.equalToSuperview()
                .inset(UIEdgeInsets(top: 0, left: 20, bottom: 9, right: 20))
        }
        
        menuImg.snp.makeConstraints { make in
            make.height.equalTo(52)
            make.width.equalTo(52)
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview().offset(20)
        }
        titleLabel.snp.makeConstraints { make in
            make.width.equalTo(160)
            make.top.equalTo(menuImg.snp.top)
            make.leading.equalTo(menuImg.snp.trailing).offset(20)
        }
        lastTextLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(10)
            make.leading.equalTo(titleLabel.snp.leading)
        }
        timeLabel.snp.makeConstraints { make in
            make.trailing.equalToSuperview().offset(-20)
            make.centerY.equalTo(titleLabel.snp.centerY)
        }
        msgNumView.snp.makeConstraints { make in
            make.height.equalTo(20)
            make.width.equalTo(20)
            make.trailing.equalTo(timeLabel.snp.trailing)
            make.bottom.equalTo(menuImg.snp.bottom)
        }
        msgNumLabel.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        contentView.backgroundColor = .viewBackgroundGray

    }

    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
