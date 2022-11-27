//
//  ProfileViewController.swift
//  DIVIDE
//
//  Created by 임우섭 on 2022/11/13.
//

import UIKit
import SnapKit

class ProfileViewController: UIViewController {
    
    private let mainProfile = UIView().then {
        $0.borderColor = .mainYellow
        $0.borderWidth = 3
        $0.backgroundColor = .white
        $0.cornerRadius = 14
    }
    
    private let mainProfileImg = UIImageView().then{
        $0.backgroundColor = .clear
        $0.image = UIImage(named: "logo.png")!
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.clipsToBounds
        $0.cornerRadius = 53.5
        
    }
    private let mainProfileTag = MainLabel(type: .small3).then {
        $0.text = "디바이드 공식 돼지"
        $0.textColor = .mainOrange1
    }
    private let userNickName = MainLabel(type: .Point4).then {
        $0.text = "룡룡"
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setConstraint()
        setComponentsConstraint()
    }
    
    private func setConstraint(){
        self.view.backgroundColor = .gray0
    }
    
    private func setComponentsConstraint(){
        let widthBase = UIScreen.main.bounds.width * 0.85
        self.view.addSubview(mainProfile)
        
        mainProfile.addSubview(mainProfileTag)
        self.view.addSubview(mainProfileImg)
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
