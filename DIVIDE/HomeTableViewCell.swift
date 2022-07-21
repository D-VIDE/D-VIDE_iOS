//
//  HomeTableViewCell.swift
//  DIVIDE
//
//  Created by 임우섭 on 2022/07/18.
//

import UIKit
import SnapKit
import Then
import SwiftUI

class HomeTableViewCell: UITableViewCell {
    
    static let titleText = "삼첩분식 드실분~ 저는 빨리..."
    let foodImage = "pizzeImage"
    
    let titleTextLabel = UILabel().then{
        $0.text = titleText
        $0.textColor = .mainGray
        $0.textAlignment = .center
        $0.font = .systemFont(ofSize: 16, weight: .regular)
    }
    
    let foodImageView = UIImageView().then{
        $0.backgroundColor = .red
        $0.image = UIImage(named: "pizzaImage.jpg")
        $0.contentMode = .scaleAspectFill
        $0.clipsToBounds = true
    }
    
    let remainTimeLabel = UILabel().then{
        $0.text = "마감시간"
        $0.textColor = .mainGray
        $0.textAlignment = .center
        $0.font = .systemFont(ofSize: 10, weight: .medium)
    }
    
    let AMPMLabel = UILabel().then{
        $0.text = "오후"
        $0.textColor = .mainYellow
        $0.textAlignment = .center
        $0.font = .boldSystemFont(ofSize: 10)
    }
    
    let remainTimeValueLabel = UILabel().then{
        $0.text  = "04:00"
        $0.textColor = .mainOrange
        $0.textAlignment = .center
        $0.font = .boldSystemFont(ofSize: 22)
    }
    
    let insufficientChargeLabel = UILabel().then{
        $0.text = "부족한 금액"
        $0.textColor = .mainGray
        $0.textAlignment = .center
        $0.font = .systemFont(ofSize: 10, weight: .medium)
    }
    
    let insufficientChargeValueLabel = UILabel().then{
        $0.text  = "0"
        $0.textColor = .mainOrange
        $0.textAlignment = .center
        $0.font = .boldSystemFont(ofSize: 22)
    }
    
    let currency = UILabel().then{
        $0.text = "원"
        $0.textColor = .mainYellow
        $0.textAlignment = .center
        $0.font = .boldSystemFont(ofSize: 10)
    }
    // 하단 progressbar
    
    let progressBarBackground = UIView().then{
        $0.backgroundColor = .mainGray
    }
    
    let progressBar = UIView().then{
        $0.backgroundColor = .mainOrange
    }
    //MARK: -- 화면 불러오기
    
    override func awakeFromNib() {
        super.awakeFromNib()
        //UI 초기화
        initUI()
        
        //타이틀 박스 레이아웃 및 크기 조정
        setTitleTextLayout()
        
        setImageViewLayout()
        
        setRemainTimeLabel()
        setAMPMLabel()
        setRemainTimeValueLabel()
        
        setInsufficientChargeLabel()
        setInsufficientChargeValueLabel()
        setCuncurrency()
        
        setProgressBarBackground()
        setProgressBar()
        //23강 19분 50초 참조
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    //UI subView로 넣기
    func initUI() {
        self.addSubview(titleTextLabel)
        
        self.addSubview(foodImageView)
        
        self.addSubview(remainTimeLabel)
        self.addSubview(AMPMLabel)
        self.addSubview(remainTimeValueLabel)
        
        self.addSubview(insufficientChargeLabel)
        self.addSubview(insufficientChargeValueLabel)
        self.addSubview(currency)
        
        self.addSubview(progressBarBackground)
        self.addSubview(progressBar)
    }
    // TitleText레이아웃 설정
    func setTitleTextLayout() {
        titleTextLabel.snp.makeConstraints { make in
            make.width.equalTo(200)
            make.height.equalTo(20)
            make.top.equalToSuperview().offset(45)
            make.trailing.equalToSuperview().offset(-90)
        }
    }
    // Image 크기 및 위치 지정
    func setImageViewLayout() {
        self.foodImageView.snp.makeConstraints { make in
            make.width.equalTo(64)
            make.height.equalTo(86)
            make.left.equalToSuperview().offset(25)
            make.bottom.equalToSuperview().offset(-25)
        }
    }
    
    func setRemainTimeLabel() {
        self.remainTimeLabel.snp.makeConstraints { make in
            make.width.equalTo(100)
            make.height.equalTo(10)
            make.left.equalTo(titleTextLabel)
            make.bottom.equalToSuperview().offset(-60)
        }
    }
    
    func setAMPMLabel() {
        self.AMPMLabel.snp.makeConstraints { make in
            make.width.equalTo(19)
            make.height.equalTo(21)
            make.left.equalTo(remainTimeLabel).offset(-1)
            make.bottom.equalTo(foodImageView)
            
        }
    }
    
    func setRemainTimeValueLabel() {
        self.remainTimeValueLabel.snp.makeConstraints { make in
            make.width.equalTo(88)
            make.height.equalTo(34)
            make.left.equalToSuperview().offset(131)
            make.bottom.equalTo(foodImageView).offset(2)
            
        }
    }
    
    func setInsufficientChargeLabel() {
        self.insufficientChargeLabel.snp.makeConstraints { make in
            make.width.equalTo(100)
            make.height.equalTo(10)
            make.right.equalTo(titleTextLabel)
            make.bottom.equalToSuperview().offset(-60)
        }
    }
    
    func setInsufficientChargeValueLabel(){
        self.insufficientChargeValueLabel.snp.makeConstraints { make in
            make.width.equalTo(88)
            make.height.equalTo(34)
            make.left.equalTo(insufficientChargeLabel).offset(4)
            make.bottom.equalTo(remainTimeValueLabel)
        }
    }
    
    func setCuncurrency() {
        self.currency.snp.makeConstraints { make in
            make.width.equalTo(12)
            make.height.equalTo(21)
            make.right.equalTo(insufficientChargeValueLabel)
            make.bottom.equalTo(AMPMLabel)
        }
    }
    
    func setProgressBarBackground() {
        self.progressBarBackground.snp.makeConstraints { make in
            make.width.equalTo(346)
            make.height.equalTo(7)
            make.bottom.equalToSuperview()
            make.left.equalToSuperview().offset(2)
            
        }
    }
    
    func setProgressBar() {
        self.progressBar.snp.makeConstraints { make in
            make.width.equalTo(170)
            make.height.equalTo(7)
            make.bottom.equalToSuperview()
            make.left.equalToSuperview().offset(2)
        }
    }
}
