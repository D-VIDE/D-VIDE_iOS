//
//  HomeTableViewCell.swift
//  DIVIDE
//
//  Created by 임우섭 on 2022/07/22.
//

import UIKit
import SnapKit
import Then
// 이미지, 타이틀, AMPM, 마감시간, 부족한금액 API로 받아오기
class HomeTableViewCell: UITableViewCell {
    private let contentsView: UIView = {
        
        let contentsView = UIView()
        
        return contentsView
    }()
   
    
    //MARK: - conponents
    // 로고
    private let logo = UIImageView().then{
        $0.image = UIImage(named: "logo.png")
        $0.contentMode = .scaleAspectFill
        $0.clipsToBounds = true
        $0.cornerRadius = 20
    }
    // 사용자 닉네임orID
    private let userName = UILabel().then{
        $0.text = "kksmedd10204"
        $0.textAlignment = .left
        $0.font = .systemFont(ofSize: 12, weight: .regular)
    }
    // 지역
    private let userLocation = UILabel().then{
        $0.text = "세종시 조치원읍"
        $0.textAlignment = .left
        $0.font = .systemFont(ofSize: 10, weight: .regular)
    }
    // 남은 시간 말풍선
    
    // Image 생성
    private let img = UIImageView().then{
        $0.image = UIImage(named: "pizzaImage.jpg")
        $0.contentMode = .scaleAspectFill
        $0.clipsToBounds = true
        $0.cornerRadius = 13
    }
    
    // label 생성
    private let title = UILabel().then {
        $0.text = "삼첩분식 드실분~ 저는 빨리..."
        $0.textAlignment = .center
        $0.font = .systemFont(ofSize: 16, weight: .regular)
    }
    
    private let closingTimeTitle = UILabel().then{
        $0.text = "마감시간"
        $0.textColor = .gray2
        $0.textAlignment = .center
        $0.font = .systemFont(ofSize: 10, weight: .medium)
    }
    
    private let AMPMLabel = UILabel().then{
        $0.text = "오후"
        $0.textColor = .mainYellow
        $0.textAlignment = .center
        $0.font = .boldSystemFont(ofSize: 10)
    }
    
    private let closingTimeValue = UILabel().then{
        $0.text  = "04:00"
        $0.textColor = .mainOrange2
        $0.textAlignment = .center
        $0.font = .boldSystemFont(ofSize: 22)
    }
    
    private let insufficientChargeTitle = UILabel().then{
        $0.text = "부족한 금액"
        $0.textColor = .gray2
        $0.textAlignment = .center
        $0.font = .systemFont(ofSize: 10, weight: .medium)
    }
    
    private let insufficientChargeValueLabel = UILabel().then{
        $0.text  = "0"
        $0.textColor = .mainOrange2
        $0.textAlignment = .center
        $0.font = .boldSystemFont(ofSize: 22)
    }
    
    private let currency = UILabel().then{
        $0.text = "원"
        $0.textColor = .mainYellow
        $0.textAlignment = .center
        $0.font = .boldSystemFont(ofSize: 10)
    }
    private let progressBarBackground = UIView().then{
        $0.backgroundColor = .gray4
    }
    
    private let progressBar = UIView().then{
        $0.backgroundColor = .mainOrange2
    }
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {

        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setInfoConstraint()
        setContentsConstraint()

    }

    required init?(coder aDecoder: NSCoder) {

        fatalError("init(coder:) has not been implemented")

    }
    
    
    private func setInfoConstraint() {
        self.selectionStyle = .none
        
        contentView.addSubview(logo)
        contentView.addSubview(userName)
        contentView.addSubview(userLocation)
        
        logo.snp.makeConstraints { make in
            make.width.equalTo(28)
            make.height.equalTo(28)
            make.top.equalToSuperview().offset(11)
            make.leading.equalToSuperview().offset(19)
        }
        
        userName.snp.makeConstraints { make in
            make.width.equalTo(100)
            make.height.equalTo(21)
            make.leading.equalToSuperview().offset(54)
            make.centerY.equalTo(logo)
        }
        
        userLocation.snp.makeConstraints { make in
            make.width.equalTo(100)
            make.height.equalTo(21)
            make.centerY.equalTo(userName)
            make.centerX.equalTo(userName).offset(100)
        }
    }
    
    var cellWidth = 0.0
    var cellHeight = 0.0
    private func setContentsConstraint() {
        contentView.addSubview(contentsView)
        
        contentsView.snp.makeConstraints { make in
            make.width.equalToSuperview()
            make.height.equalTo(121)
            make.bottom.equalTo(contentView)
        }
        
        cellWidth = contentsView.intrinsicContentSize.width
        cellHeight = contentsView.intrinsicContentSize.height
        self.backgroundColor = .viewBackgroundGray
        //그림자
        contentsView.roundCorners(cornerRadius: 26, maskedCorners: [.layerMinXMinYCorner, .layerMaxXMinYCorner])
        contentsView.backgroundColor = .white
        contentView.layer.shadowPath = UIBezierPath(rect: CGRect(x: 0, y: 2, width: cellWidth, height: cellHeight)).cgPath
        contentView.layer.shadowOpacity = 0.15
        
        contentsView.layer.masksToBounds = false
        
        contentsView.addSubview(img)

        contentsView.addSubview(title)

        contentsView.addSubview(closingTimeTitle)
        contentsView.addSubview(AMPMLabel)
        contentsView.addSubview(closingTimeValue)
        
        contentsView.addSubview(insufficientChargeTitle)
        contentsView.addSubview(insufficientChargeValueLabel)
        contentsView.addSubview(currency)
        
        contentsView.addSubview(progressBarBackground)
        contentsView.addSubview(progressBar)
        
        
        img.snp.makeConstraints { make in
            make.leading.equalTo(contentsView).offset(16)
            make.bottom.equalToSuperview().offset(-18)
            make.width.equalTo(64)
            make.height.equalTo(86)
        }
        
        title.snp.makeConstraints { make in
            make.centerX.equalToSuperview().offset(30)
            make.centerY.equalTo(img).offset(-30)
        }
        
        closingTimeTitle.snp.makeConstraints { make in
            make.width.equalTo(100)
            make.height.equalTo(21)
            make.centerX.equalToSuperview().offset(-20)
            make.centerY.equalToSuperview().offset(8)
        }
        
        AMPMLabel.snp.makeConstraints { make in
            make.width.equalTo(19)
            make.height.equalTo(21)
            make.left.equalTo(closingTimeTitle).offset(-10)
            make.bottom.equalTo(img)
            
        }
        closingTimeValue.snp.makeConstraints { make in
            make.width.equalTo(64)
            make.height.equalTo(32)
            make.centerX.equalToSuperview().offset(-15)
            make.bottom.equalTo(AMPMLabel).offset(3)
//            make.bottom.equalTo(foodImageView).offset(2)
            
        }
        insufficientChargeTitle.snp.makeConstraints { make in
            make.width.equalTo(100)
            make.height.equalTo(21)
            make.trailing.equalToSuperview().offset(-50)
            make.bottom.equalTo(closingTimeTitle)
        }
        insufficientChargeValueLabel.snp.makeConstraints { make in
            make.width.equalTo(88)
            make.height.equalTo(34)
            make.left.equalTo(insufficientChargeTitle).offset(4)
            make.bottom.equalTo(closingTimeValue)
        }
        
        currency.snp.makeConstraints { make in
            make.width.equalTo(12)
            make.height.equalTo(21)
            make.right.equalTo(insufficientChargeValueLabel)
            make.bottom.equalTo(AMPMLabel)
        }
        progressBarBackground.snp.makeConstraints { make in
            make.width.equalToSuperview()
            make.height.equalTo(7)
            make.bottom.equalToSuperview()
            
        }
        progressBar.snp.makeConstraints { make in
            make.width.equalTo(250)
            make.height.equalTo(7)
            make.bottom.equalToSuperview()
        }
    }
}

extension UIView {
    func roundCorners(cornerRadius: CGFloat, maskedCorners: CACornerMask) {
        clipsToBounds = true
        layer.cornerRadius = cornerRadius
        layer.maskedCorners = CACornerMask(arrayLiteral: maskedCorners)
    }
}
