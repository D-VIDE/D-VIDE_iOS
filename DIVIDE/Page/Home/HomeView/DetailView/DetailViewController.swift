//
//  DetailViewController.swift
//  DIVIDE
//
//  Created by 임우섭 on 2022/08/19.
//

import UIKit
import SnapKit
import Then

class DetailViewController: UIViewController {
    
    private let proposerImage = UIImageView().then {
        $0.image = UIImage(named: "logo.png")
        $0.sizeToFit()
    }
    lazy var proposerNickName = MainLabel(type: .Basics5).then {
        $0.text = "NICKNAME"
        $0.textColor = .white
    }
    
    private let foodBackgroundImage = UIImageView().then {
        $0.image = UIImage(named: "pizzaImage.jpg")
        $0.sizeToFit()
    }
    
    private let bottomSheetView = BottomSheetView().then {
        $0.bottomSheetColor = .white
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("pushedDetailView")
        
        setBackground()
        setComponentsConstraints()
    }
    
    func setBackground() {
        self.view.addSubview(foodBackgroundImage)
        
        foodBackgroundImage.snp.makeConstraints { make in
            make.width.equalToSuperview()
            make.height.equalTo(300)
            make.top.equalToSuperview()
            make.centerX.equalToSuperview()
        }
    }
    func setComponentsConstraints() {
        self.view.addSubview(proposerImage)
        self.view.addSubview(proposerNickName)
        self.view.addSubview(self.bottomSheetView)
        
        self.proposerImage.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(50)
            make.leading.equalToSuperview().offset(40)
            make.width.equalTo(37)
            make.height.equalTo(38)
        }
        self.proposerNickName.snp.makeConstraints { make in
            make.top.equalTo(proposerImage)
            make.leading.equalTo(proposerImage).offset(44)
            make.width.equalTo(150)
            make.height.equalTo(38)
            
        }
        
        self.bottomSheetView.snp.makeConstraints {
              $0.edges.equalToSuperview()
        }
        
        self.navigationController?.navigationBar.tintColor = .white
        
    }


}
