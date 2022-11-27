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
    
    private let mainProfileImg = UIImageView()
    private let mainProfileTag = MainLabel(type: .small3)
    private let userNickName = MainLabel(type: .Point4)
    
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
        mainProfileImg.do {
            $0.backgroundColor = .clear
            $0.image = UIImage(named: "logo.png")!
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.cornerRadius = 53.5
        }
        mainProfileTag.do {
            $0.text = "디바이드 공식 돼지"
            $0.textColor = .mainOrange1
        }
        userNickName.do {
            $0.text = "룡룡"
        }
    }
    func addView() {
        view.addSubview(mainProfile)
        view.addSubview(mainProfileImg)
        mainProfile.addSubview(mainProfileTag)
    }
    func setLayout() {
        let widthBase = UIScreen.main.bounds.width * 0.85
        mainProfile.snp.makeConstraints { make in
            make.width.equalTo(widthBase)
            make.height.equalTo(167)
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(110)
        }
        mainProfileTag.snp.makeConstraints { make in
            make.width.equalTo(84)
            make.height.equalTo(14)
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview().offset(-10)
        }
        mainProfileImg.snp.makeConstraints { make in
            make.width.equalTo(107)
            make.height.equalTo(107)
            make.centerX.equalToSuperview()
            make.top.equalTo(mainProfile).offset(-53.5)
        }
        mainProfileImg.image =  mainProfileImg.image?.resize(toTargetSize: CGSize(width: 88, height: 88))
        mainProfileImg.layer.addShadow(location: .bottom, color: .gray0, opacity: 0.15, radius: 53.5)

    }
   

}
