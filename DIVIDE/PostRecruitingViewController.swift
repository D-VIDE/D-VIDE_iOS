//
//  ViewController.swift
//  DIVIDE
//
//  Created by 정지윤 on 2022/06/28.
//

import UIKit
import Then
import SnapKit

class PostRecruitingViewController: UIViewController {
    
    // UILabel 정의
    let titleLabel = UILabel().then {
        $0.text = "• 제목"
        $0.textColor = .mainGray
        $0.font = UIFont.AppleSDGothicNeo(.bold, size: 15)
    }
    
    let storeLabel = UILabel().then {
        $0.text = "• 가게 이름"
        $0.textColor = .mainGray
        $0.font = UIFont.AppleSDGothicNeo(.bold, size: 15)
    }
    
    let deliveryFeeLabel = UILabel().then {
        $0.text = "• 배달비"
        $0.textColor = .mainGray
        $0.font = UIFont.AppleSDGothicNeo(.bold, size: 15)
    }
    
    let deliveryFeeUnitLabel = UILabel().then {
        $0.text = "원"
        $0.textColor = .mainGray
        $0.font = UIFont.AppleSDGothicNeo(.medium, size: 13)
    }
    
    let dividerNumLabel = UILabel().then {
        $0.text = "• 주문자 수"
        $0.textColor = .mainGray
        $0.font = UIFont.AppleSDGothicNeo(.bold, size: 15)
    }
    
    let minimumDividerLabel = UILabel().then {
        $0.text = "명 (최소)"
        $0.textColor = .mainGray
        $0.font = UIFont.AppleSDGothicNeo(.medium, size: 13)
    }
    
    let dueTimeLabel = UILabel().then {
        $0.text = "• 마감 시간"
        $0.textColor = .mainGray
        $0.font = UIFont.AppleSDGothicNeo(.bold, size: 15)
    }
    let placeLabel = UILabel().then {
        $0.text = "• 장소"
        $0.textColor = .mainGray
        $0.font = UIFont.AppleSDGothicNeo(.bold, size: 15)
    }
    let contentLabel = UILabel().then {
        $0.text = "• 내용"
        $0.textColor = .mainGray
        $0.font = UIFont.AppleSDGothicNeo(.bold, size: 15)
    }
    
    //UITextField 정의
    let titleTextField = UITextField().then {
        $0.setPaddingFor(left: 18, right: 18)
        $0.layer.borderWidth = 2
        $0.layer.borderColor = UIColor.mainOrange.cgColor
        $0.layer.cornerRadius = 18
        $0.layer.maskedCorners = CACornerMask(arrayLiteral: .layerMaxXMinYCorner, .layerMaxXMaxYCorner)
        $0.layer.makeShadow(color: .black, x: 1, y: 1, blur: 1, spread: 1)
    }
    let storeTextField = UITextField().then {
        $0.setPaddingFor(left: 18, right: 18)
        $0.layer.borderWidth = 2
        $0.layer.borderColor = UIColor.mainOrange.cgColor
        $0.layer.cornerRadius = 18
        $0.layer.maskedCorners = CACornerMask(arrayLiteral: .layerMaxXMinYCorner, .layerMaxXMaxYCorner)
        $0.layer.makeShadow(color: .black, x: 1, y: 1, blur: 1, spread: 1)
    }
    let deliveryFeeTextField = UITextField().then {
        $0.setPaddingFor(left: 18, right: 18)
        $0.layer.borderWidth = 2
        $0.layer.borderColor = UIColor.mainOrange.cgColor
        $0.layer.cornerRadius = 18
        $0.layer.maskedCorners = CACornerMask(arrayLiteral: .layerMaxXMinYCorner, .layerMaxXMaxYCorner)
        $0.layer.makeShadow(color: .black, x: 1, y: 1, blur: 1, spread: 1)
    }
    let dividerNumTextField = UITextField().then {
        $0.setPaddingFor(left: 18, right: 18)
        $0.layer.borderWidth = 2
        $0.layer.borderColor = UIColor.mainOrange.cgColor
        $0.layer.cornerRadius = 18
        $0.layer.maskedCorners = CACornerMask(arrayLiteral: .layerMaxXMinYCorner, .layerMaxXMaxYCorner)
        $0.layer.makeShadow(color: .black, x: 1, y: 1, blur: 1, spread: 1)
    }
    let dueTimeTextField = UITextField().then {
        $0.setPaddingFor(left: 18, right: 18)
        $0.layer.borderWidth = 2
        $0.layer.borderColor = UIColor.mainOrange.cgColor
        $0.layer.cornerRadius = 18
        $0.layer.maskedCorners = CACornerMask(arrayLiteral: .layerMaxXMinYCorner, .layerMaxXMaxYCorner)
        $0.layer.makeShadow(color: .black, x: 1, y: 1, blur: 1, spread: 1)
    }
    let contentTextField = UITextField().then {
        $0.setPaddingFor(left: 18, right: 18)
        $0.layer.borderWidth = 2
        $0.layer.borderColor = UIColor.mainOrange.cgColor
        $0.layer.cornerRadius = 18
        $0.layer.maskedCorners = CACornerMask(arrayLiteral: .layerMaxXMinYCorner, .layerMaxXMaxYCorner)
        $0.layer.makeShadow(color: .black, x: 1, y: 1, blur: 1, spread: 1)
    }
    
    //UIView 정의
    let mapView = UIView().then {
        $0.layer.borderWidth = 2
        $0.layer.borderColor = UIColor.mainOrange.cgColor
        $0.layer.cornerRadius = 18
        $0.layer.maskedCorners = CACornerMask(arrayLiteral: .layerMaxXMinYCorner, .layerMaxXMaxYCorner)
        $0.layer.makeShadow(color: .black, x: 1, y: 1, blur: 1, spread: 1)
    }
    
    //UIButton 정의
    let uploadButton =  UIButton().then {
        $0.setTitle("업로드 하기", for: .normal)
        $0.setTitleColor(.white, for: .normal)
        $0.backgroundColor = .mainOrange
        $0.layer.cornerRadius = 18
        $0.layer.maskedCorners = CACornerMask(arrayLiteral: .layerMaxXMinYCorner, .layerMinXMinYCorner)
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        view.backgroundColor = .white
        navigationItem.title = "D/VIDE 모집글 작성"
//        navigationItem.title?.font = UIFont.AppleSDGothicNeo(.bold, size: 20)
        navigationItem.titleView?.tintColor = .mainOrange
        navigationController?.navigationBar.layer.cornerRadius = 18
        navigationController?.navigationBar.layer.borderWidth = 1
        navigationController?.navigationBar.layer.borderColor = UIColor.mainGray.cgColor
        navigationController?.navigationBar.layer.maskedCorners = CACornerMask(arrayLiteral: .layerMaxXMaxYCorner, .layerMinXMaxYCorner)
        navigationController?.navigationBar.layer.makeShadow(color: .black)
        
        view.addSubview(titleLabel)
        view.addSubview(storeLabel)
        view.addSubview(deliveryFeeLabel)
        view.addSubview(deliveryFeeUnitLabel)
        view.addSubview(dividerNumLabel)
        view.addSubview(minimumDividerLabel)
        view.addSubview(dueTimeLabel)
        view.addSubview(placeLabel)
        view.addSubview(contentLabel)
        
        view.addSubview(titleTextField)
        view.addSubview(storeTextField)
        view.addSubview(deliveryFeeTextField)
        view.addSubview(dividerNumTextField)
        view.addSubview(dueTimeTextField)
        view.addSubview(contentTextField)

        view.addSubview(mapView)

        view.addSubview(uploadButton)
        
        
        setConstraints()
    }
    
    func setConstraints() {
        
        
        // Label
        titleLabel.snp.makeConstraints { make in
            make.leading.equalTo(view.safeAreaLayoutGuide.snp.leading).offset(20)
            make.top.equalTo(view.safeAreaLayoutGuide).offset(40)
        }
        storeLabel.snp.makeConstraints { make in
            make.leading.equalTo(view.safeAreaLayoutGuide.snp.leading).offset(20)
            make.top.equalTo(titleLabel.snp.bottom).offset(20)
        }
        deliveryFeeLabel.snp.makeConstraints { make in
            make.leading.equalTo(view.safeAreaLayoutGuide.snp.leading).offset(20)
            make.top.equalTo(storeLabel.snp.bottom).offset(20)
        }
        deliveryFeeUnitLabel.snp.makeConstraints { make in
            make.leading.equalTo(deliveryFeeTextField.snp.trailing).offset(10)
            make.centerY.equalTo(deliveryFeeLabel.snp.centerY)
        }
        dividerNumLabel.snp.makeConstraints { make in
            make.leading.equalTo(view.safeAreaLayoutGuide.snp.leading).offset(20)
            make.top.equalTo(deliveryFeeLabel.snp.bottom).offset(20)
        }
        minimumDividerLabel.snp.makeConstraints { make in
            make.leading.equalTo(dividerNumTextField.snp.trailing).offset(10)
            make.centerY.equalTo(dividerNumLabel.snp.centerY)
        }
        dueTimeLabel.snp.makeConstraints { make in
            make.leading.equalTo(view.safeAreaLayoutGuide.snp.leading).offset(20)
            make.top.equalTo(dividerNumLabel.snp.bottom).offset(20)
        }
        placeLabel.snp.makeConstraints { make in
            make.leading.equalTo(view.safeAreaLayoutGuide.snp.leading).offset(20)
            make.top.equalTo(dueTimeLabel.snp.bottom).offset(20)
        }
        contentLabel.snp.makeConstraints { make in
            make.leading.equalTo(view.safeAreaLayoutGuide.snp.leading).offset(20)
            make.top.equalTo(placeLabel.snp.bottom).offset(251 - contentLabel.frame.size.height)
        }
        
        //TextField
        titleTextField.snp.makeConstraints { make in
            make.centerY.equalTo(titleLabel.snp.centerY)
            make.leading.equalTo(dividerNumLabel.snp.trailing).offset(20)
            make.trailing.equalToSuperview().offset(-20)
            make.height.equalTo(36)
            make.width.equalTo(251)
        }
        storeTextField.snp.makeConstraints { make in
            make.centerY.equalTo(storeLabel.snp.centerY)
            make.leading.equalTo(dividerNumLabel.snp.trailing).offset(20)
            make.trailing.equalToSuperview().offset(-20)
            make.height.equalTo(36)
            make.width.equalTo(251)
        }
        deliveryFeeTextField.snp.makeConstraints { make in
            make.centerY.equalTo(deliveryFeeLabel.snp.centerY)
            make.leading.equalTo(dividerNumLabel.snp.trailing).offset(20)
            make.height.equalTo(36)
            make.width.equalTo(134)
        }
        dividerNumTextField.snp.makeConstraints { make in
            make.centerY.equalTo(dividerNumLabel.snp.centerY)
            make.leading.equalTo(dividerNumLabel.snp.trailing).offset(20)
            make.height.equalTo(36)
            make.width.equalTo(134)
        }
        dueTimeTextField.snp.makeConstraints { make in
            make.centerY.equalTo(dueTimeLabel.snp.centerY)
            make.leading.equalTo(dividerNumLabel.snp.trailing).offset(20)
            make.trailing.equalToSuperview().offset(-20)
            make.height.equalTo(36)
            make.width.equalTo(251)
        }
        contentTextField.snp.makeConstraints { make in
            make.top.equalTo(contentLabel.snp.top)
            make.leading.equalTo(dividerNumLabel.snp.trailing).offset(20)
            make.trailing.equalToSuperview().offset(-20)
            make.height.equalTo(178)
            make.width.equalTo(251)
        }
        
        //UIView
        mapView.snp.makeConstraints { make in
            make.top.equalTo(placeLabel.snp.top)
            make.leading.equalTo(dividerNumLabel.snp.trailing).offset(20)
            make.trailing.equalToSuperview().offset(-20)
            make.height.equalTo(178)
            make.width.equalTo(251)
        }
        
        
        
        //Button
        uploadButton.snp.makeConstraints { make in
            make.centerX.equalTo(view)
            make.bottom.equalTo(view.snp.bottom)
            make.width.equalTo(view.snp.width).inset(20)
            make.height.equalTo(70)
        }
    }
}



