//
//  ProfileViewController.swift
//  DIVIDE
//
//  Created by 임우섭 on 2022/11/13.
//

import UIKit
import SnapKit

class ProfileViewController: UIViewController {
    
    private let mainProfile = UIView()
    private let settingBtn = UIButton()
    private let mainProfileImg = UIImageView()
    private let mainProfileTag = MainLabel(type: .small3)
    private let userNickName = MainLabel(type: .Point4)
    
    private let followingCount = MainLabel(type: .Big2)
    private let followingLabel = MainLabel(type: .Basics2)
    private let mainProfileDivideBar = UIView()
    private let followerCount = MainLabel(type: .Big2)
    private let followerLabel = MainLabel(type: .Basics2)
    
    private let retrenchView = UIView()
    private let retrenchCO2Label = MainLabel(type: .Basics1)
    private let retrenchDeliveryFeeLabel = MainLabel(type: .Basics1)
    
    private let retrenchViewDivideHorizontal = UIView()
    
    private let retrenchCO2Value = MainLabel(type: .Big1)
    private let retrenchCO2Gram = MainLabel(type: .Basics2)
    private let retrenchViewDivideVertical = UIView()
    private let retrenchDeliveryFeeValue = MainLabel(type: .Big1)
    private let retrenchDeliveryFeeWon = MainLabel(type: .Basics2)
    
    private let seeMyOrderHistory = UIButton()
    private let seeMyReviews = UIButton()
    private let serviceCenter = UIButton()
    private let changeDefaultAddress = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setAttribute()
        addView()
        setLayout()
    }
    func setAttribute() {
        view.backgroundColor = .viewBackgroundGray
        mainProfile.do {
            $0.borderColor = .mainYellow
            $0.borderWidth = 3
            $0.backgroundColor = .white
            $0.cornerRadius = 14
        }
        settingBtn.do {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.setImage(UIImage(named: "설정.png"), for: .normal)
            $0.imageView?.contentMode = .scaleAspectFit
            $0.contentHorizontalAlignment = .center
            $0.semanticContentAttribute = .forceRightToLeft
            $0.contentVerticalAlignment = .center
            $0.contentHorizontalAlignment = .leading
        }
        mainProfileImg.do {
            $0.image = UIImage(named: "profileImg.png")!
        }
        mainProfileTag.do {
            $0.text = "디바이드 공식 돼지"
            $0.textAlignment = .center
            $0.textColor = .mainOrange1
        }
        userNickName.do {
            $0.textAlignment = .center
            $0.text = "룡룡"
        }
        followingCount.do {
            $0.textAlignment = .center
            $0.text = "0"
        }
        followingLabel.do {
            $0.textAlignment = .center
            $0.text = "팔로잉"
        }
        mainProfileDivideBar.do {
            $0.backgroundColor = .gray0
        }
        followerCount.do {
            $0.textAlignment = .center
            $0.text = "0"
        }
        followerLabel.do {
            $0.textAlignment = .center
            $0.text = "팔로워"
        }
        retrenchView.do {
            $0.backgroundColor = .white
            $0.layer.cornerRadius = 26
            $0.layer.addShadow(location: .all, color: .gray, opacity: 0.1, radius: 26)
        }
        retrenchCO2Label.do {
            $0.text = "절약한 탄소배출"
            $0.textAlignment = .center
        }
        retrenchDeliveryFeeLabel.do {
            $0.text = "절약한 배달비"
            $0.textAlignment = .center
        }
        retrenchViewDivideHorizontal.do {
            $0.backgroundColor = .gray0
        }
        retrenchCO2Value.do {
            $0.text = "0"
            $0.textColor = .mainOrange1
            $0.textAlignment = .center
        }
        retrenchCO2Gram.do {
            $0.text = "g"
            $0.textColor = .mainOrange2
        }
        retrenchViewDivideVertical.do {
            $0.backgroundColor = .gray0
        }
        retrenchDeliveryFeeValue.do {
            $0.text = "5930"
            $0.textColor = .mainOrange1
            $0.textAlignment = .center
        }
        retrenchDeliveryFeeWon.do {
            $0.text = "원"
            $0.textColor = .mainOrange2
        }
        seeMyOrderHistory.do {
            $0.setTitle("나의 주문내역 보기", for: .normal)
            $0.setTitleColor(.mainOrange1, for: .normal)
            $0.backgroundColor = .white
            $0.titleLabel?.font = .NotoSansKR(.bold, size: 14)
            
            $0.setImage(UIImage(systemName: "chevron.right"), for: .normal)
            $0.tintColor = .mainOrange1
            $0.semanticContentAttribute = .forceRightToLeft
            $0.imageEdgeInsets = .init(top: 0, left: 0, bottom: 0, right: -160)

            $0.configuration?.titleAlignment = .center
            $0.layer.cornerRadius = 23.5
            $0.layer.addShadow(location: .all, color: .gray, opacity: 0.1, radius: 23.5)
        }
        seeMyReviews.do {
            $0.setTitle("내가 쓴 리뷰 보기", for: .normal)
            $0.setTitleColor(.mainOrange1, for: .normal)
            $0.backgroundColor = .white
            $0.titleLabel?.font = .NotoSansKR(.bold, size: 14)
            
            $0.setImage(UIImage(systemName: "chevron.right"), for: .normal)
            $0.tintColor = .mainOrange1
            $0.semanticContentAttribute = .forceRightToLeft
            $0.imageEdgeInsets = .init(top: 0, left: 0, bottom: 0, right: -170)

            
            $0.configuration?.titleAlignment = .center
            $0.layer.cornerRadius = 23.5
            $0.layer.addShadow(location: .all, color: .gray, opacity: 0.1, radius: 23.5)
        }
        serviceCenter.do {
            $0.setTitle("고객센터로 이동", for: .normal)
            $0.setTitleColor(.mainOrange1, for: .normal)
            $0.backgroundColor = .white
            $0.titleLabel?.font = .NotoSansKR(.bold, size: 14)
            
            $0.setImage(UIImage(systemName: "chevron.right"), for: .normal)
            $0.tintColor = .mainOrange1
            $0.semanticContentAttribute = .forceRightToLeft
            $0.imageEdgeInsets = .init(top: 0, left: 0, bottom: 0, right: -180)

            
            $0.configuration?.titleAlignment = .center
            $0.layer.cornerRadius = 23.5
            $0.layer.addShadow(location: .all, color: .gray, opacity: 0.1, radius: 23.5)
        }
        changeDefaultAddress.do {
            $0.setTitle("기본 주소지 변경", for: .normal)
            $0.setTitleColor(.mainOrange1, for: .normal)
            $0.backgroundColor = .white
            $0.titleLabel?.font = .NotoSansKR(.bold, size: 14)
            
            $0.setImage(UIImage(systemName: "chevron.right"), for: .normal)
            $0.tintColor = .mainOrange1
            $0.semanticContentAttribute = .forceRightToLeft
            $0.imageEdgeInsets = .init(top: 0, left: 0, bottom: 0, right: -170)

            
            $0.configuration?.titleAlignment = .center
            $0.layer.cornerRadius = 23.5
            $0.layer.addShadow(location: .all, color: .gray, opacity: 0.1, radius: 23.5)
        }
    }
    func addView() {
        view.addSubview(mainProfile)
        view.addSubview(settingBtn)
        view.addSubview(mainProfileImg)
        view.addSubview(retrenchView)
        view.addSubview(seeMyOrderHistory)
        view.addSubview(seeMyReviews)
        view.addSubview(serviceCenter)
        view.addSubview(changeDefaultAddress)
        
        mainProfile.addSubviews([mainProfileTag, userNickName, followingCount, followingLabel, mainProfileDivideBar, followerCount, followerLabel])
        
        retrenchView.addSubviews([retrenchCO2Label, retrenchDeliveryFeeLabel, retrenchViewDivideHorizontal, retrenchCO2Value, retrenchCO2Gram, retrenchViewDivideVertical, retrenchDeliveryFeeValue, retrenchDeliveryFeeWon])
    }
    func setLayout() {
        let widthBase = UIScreen.main.bounds.width * 0.85
        mainProfile.snp.makeConstraints { make in
            make.width.equalTo(widthBase)
            make.height.equalTo(167)
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(110)
        }
        settingBtn.snp.makeConstraints { make in
            make.width.height.equalTo(23)
            make.top.equalToSuperview().offset(71)
            make.trailing.equalToSuperview().offset(-43)
        }
        mainProfileImg.snp.makeConstraints { make in
            make.width.equalTo(107)
            make.height.equalTo(107)
            make.centerX.equalToSuperview()
            make.top.equalTo(mainProfile).offset(-53.5)
        }

        mainProfileTag.snp.makeConstraints { make in
            make.width.equalTo(84)
            make.height.equalTo(14)
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview().offset(-15)
        }
        userNickName.snp.makeConstraints { make in
            make.width.equalTo(84)
            make.height.equalTo(23)
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
        }
        followingCount.snp.makeConstraints { make in
            make.width.equalTo(12)
            make.height.equalTo(29)
            make.leading.equalToSuperview().offset(76.5)
            make.centerY.equalToSuperview().offset(20)
        }
        followingLabel.snp.makeConstraints { make in
            make.width.equalTo(35)
            make.height.equalTo(16)
            make.centerY.equalToSuperview().offset(45)
            make.leading.equalToSuperview().offset(65)
        }
        mainProfileDivideBar.snp.makeConstraints { make in
            make.width.equalTo(3)
            make.height.equalTo(34)
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview().offset(35)
        }
        followerCount.snp.makeConstraints { make in
            make.width.equalTo(12)
            make.height.equalTo(29)
            make.trailing.equalToSuperview().offset(-76.5)
            make.centerY.equalToSuperview().offset(20)
        }
        followerLabel.snp.makeConstraints { make in
            make.width.equalTo(35)
            make.height.equalTo(16)
            make.centerY.equalToSuperview().offset(45)
            make.trailing.equalToSuperview().offset(-65)
        }
        
        retrenchView.snp.makeConstraints { make in
            make.width.equalTo(mainProfile)
            make.height.equalTo(132)
            make.centerX.equalToSuperview()
            make.centerY.equalTo(mainProfile).offset(166)
        }
        
        retrenchCO2Label.snp.makeConstraints { make in
            make.width.equalTo(85)
            make.height.equalTo(17)
            make.leading.equalToSuperview().offset(55)
            make.top.equalToSuperview().offset(25)
        }
        retrenchDeliveryFeeLabel.snp.makeConstraints { make in
            make.width.equalTo(85)
            make.height.equalTo(17)
            make.trailing.equalToSuperview().offset(-55)
            make.top.equalToSuperview().offset(25)
        }
        retrenchViewDivideHorizontal.snp.makeConstraints { make in
            make.width.equalToSuperview()
            make.height.equalTo(2)
            make.centerY.equalToSuperview().offset(-5)
        }
        
        retrenchCO2Value.snp.makeConstraints { make in
            make.width.equalTo(54)
            make.height.equalTo(32)
            make.top.equalTo(retrenchViewDivideHorizontal).offset(20)
            make.centerX.equalToSuperview().offset(-87.5)
        }
        retrenchCO2Gram.snp.makeConstraints { make in
            make.width.equalTo(12)
            make.height.equalTo(18)
            make.bottom.equalTo(retrenchCO2Value)
            make.centerX.equalToSuperview().offset(-45)
        }
        retrenchViewDivideVertical.snp.makeConstraints { make in
            make.width.equalTo(2)
            make.height.equalTo(34)
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview().offset(20)
        }
        retrenchDeliveryFeeValue.snp.makeConstraints { make in
            make.width.equalTo(54)
            make.height.equalTo(32)
            make.top.equalTo(retrenchCO2Value)
            make.centerX.equalToSuperview().offset(87.5)
        }
        retrenchDeliveryFeeWon.snp.makeConstraints { make in
            make.width.equalTo(12)
            make.height.equalTo(16)
            make.bottom.equalTo(retrenchCO2Value)
            make.centerX.equalToSuperview().offset(129)
        }
        
        seeMyOrderHistory.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.width.equalTo(retrenchView)
            make.height.equalTo(47)
            make.top.equalTo(retrenchView).offset(147)
        }
        seeMyReviews.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.width.equalTo(retrenchView)
            make.height.equalTo(47)
            make.top.equalTo(seeMyOrderHistory).offset(62)
        }
        serviceCenter.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.width.equalTo(retrenchView)
            make.height.equalTo(47)
            make.top.equalTo(seeMyReviews).offset(62)
        }
        changeDefaultAddress.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.width.equalTo(retrenchView)
            make.height.equalTo(47)
            make.top.equalTo(serviceCenter).offset(62)
        }
    }
   

}
