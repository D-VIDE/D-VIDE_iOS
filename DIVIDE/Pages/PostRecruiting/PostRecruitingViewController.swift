//
//  ViewController.swift
//  DIVIDE
//
//  Created by 정지윤 on 2022/06/28.
//

import UIKit
import Then
import SnapKit
import DropDown

class PostRecruitingViewController: UIViewController {
    
    // UIScrollView 정의
    let scrollView = UIScrollView().then {
        $0.backgroundColor = .backgroundGray
        $0.showsVerticalScrollIndicator = false
        $0.showsHorizontalScrollIndicator = false
    }
    
    let scrollContentView = UIView().then {
        $0.backgroundColor = .backgroundGray
    }
    
    // 중복 선언
    let navBar = MainNavBar().then {
        $0.backgroundColor = .white
    }
    
    
    // UILabel 정의
    let titleLabel = MainLabel(type: .gray).then {
        $0.text = "• 제목"
    }
    let storeLabel = MainLabel(type: .gray).then {
        $0.text = "• 가게 이름"
    }
    let deliveryFeeLabel = MainLabel(type: .gray).then {
        $0.text = "• 배달비"
    }
    let deliveryFeeUnitLabel = MainLabel(type: .gray).then {
        $0.text = "원"
        $0.font = UIFont.AppleSDGothicNeo(.medium, size: 13)
    }
    let dividerNumLabel = MainLabel(type: .gray).then {
        $0.text = "• 주문자 수"
    }
    let minimumDividerLabel = MainLabel(type: .gray).then {
        $0.text = "명 (최소)"
        $0.font = UIFont.AppleSDGothicNeo(.medium, size: 13)
    }
    let dueTimeLabel = MainLabel(type: .gray).then {
        $0.text = "• 마감 시간"
    }
    let placeLabel = MainLabel(type: .gray).then {
        $0.text = "• 장소"
    }
    let contentLabel = MainLabel(type: .gray).then {
        $0.text = "• 내용"
    }
    
    //UITextField 정의
    let titleTextField = MainTextField(type: .main).then {
        $0.textFieldTextChanged($0)
    }
    let storeTextField = MainTextField(type: .main).then {
        $0.textFieldTextChanged($0)

    }
    let deliveryFeeTextField = MainTextField(type: .main).then {
        $0.textFieldTextChanged($0)

    }
    let dividerNumTextField = MainTextField(type: .main).then {
        $0.textFieldTextChanged($0)
        $0.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(onTapButton)))
        
    }
    let dueTimeTextField = MainTextField(type: .main).then {
        $0.textFieldTextChanged($0)
    }
    
    
    //UITextView 정의
    let contentTextView = UITextView().then {
        $0.textContainerInset = UIEdgeInsets(top: 18.0, left: 18.0, bottom: 18.0, right: 18.0)
        $0.backgroundColor = .white
        $0.layer.borderWidth = 0.2
        $0.layer.borderColor = UIColor.mainGray.cgColor
        $0.layer.cornerRadius = 18
        $0.layer.maskedCorners = CACornerMask(arrayLiteral: .layerMaxXMinYCorner, .layerMaxXMaxYCorner)
        $0.layer.addShadow(location: .all)
//        $0.addTarget(self, action: #selector(textFieldTextChanged(_:)), for: .editingChanged)

    }
    
    //UIView 정의
    //중복 선언
    let dividerTouchView = MainView(type: .touch).then {
        $0.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(onTapButton)))
    }
//    let timeTouchView = MainView(type: .touch).then {
//    }
    let mapView = UIView().then {
        $0.backgroundColor = .white
        $0.layer.borderWidth = 0.2
        $0.layer.borderColor = UIColor.mainGray.cgColor
        $0.layer.cornerRadius = 18
        $0.layer.maskedCorners = CACornerMask(arrayLiteral: .layerMaxXMinYCorner, .layerMaxXMaxYCorner)
        $0.layer.addShadow(location: .all)
    }
    
    //UIButton 정의
    let uploadButton =  MainButton(type: .mainAction).then {
        $0.setTitle("업로드 하기", for: .normal)
    }
    
    let recruitNumSelectButton = UIButton().then {
        $0.backgroundColor = .lightGray
        $0.layer.cornerRadius = 18
        $0.addTarget(self, action: #selector(onTapButton), for: .touchUpInside)
    }
    
    //DropDown 정의
    let dropDown = DropDown().then {
        $0.dataSource = ["1", "2", "3", "4", "5"]
    }
    
    //DatePicker 정의
    let datePicker = UIDatePicker().then {
        $0.preferredDatePickerStyle = .wheels
        $0.datePickerMode = .time
        $0.locale = Locale(identifier: "ko-KR")
        $0.timeZone = .autoupdatingCurrent
        $0.addTarget(self, action: #selector(handleDatePicker(_:)), for: .valueChanged)
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        view.backgroundColor = .white
        
        // 준영햄 도와줭
        let navController = UINavigationController(navigationBarClass: MainNavBar.self, toolbarClass: nil)
        navController.additionalSafeAreaInsets.top = 40
        navController.navigationItem.title = "D/VIDE 모집글 작성"
//        navController.navigationItem.title?.font = UIFont.AppleSDGothicNeo(.bold, size: 20)
        navController.navigationItem.titleView?.tintColor = .mainOrange
        
        view.addSubview(scrollView)
        scrollView.addSubview(scrollContentView)
        
        //UILabel add
        scrollContentView.addSubview(titleLabel)
        scrollContentView.addSubview(storeLabel)
        scrollContentView.addSubview(deliveryFeeLabel)
        scrollContentView.addSubview(deliveryFeeUnitLabel)
        scrollContentView.addSubview(dividerNumLabel)
        scrollContentView.addSubview(minimumDividerLabel)
        scrollContentView.addSubview(dueTimeLabel)
        scrollContentView.addSubview(placeLabel)
        scrollContentView.addSubview(contentLabel)
        //UITextField add
        scrollContentView.addSubview(titleTextField)
        scrollContentView.addSubview(storeTextField)
        scrollContentView.addSubview(deliveryFeeTextField)
        scrollContentView.addSubview(dividerNumTextField)
        scrollContentView.addSubview(dueTimeTextField)
        
        scrollContentView.addSubview(dividerTouchView)
        scrollContentView.addSubview(contentTextView)
        scrollContentView.addSubview(mapView)
        //UIButton add
        scrollContentView.addSubview(uploadButton)
        scrollContentView.addSubview(recruitNumSelectButton)
        
        dropDown.anchorView = dividerNumTextField
        dropDown.bottomOffset = CGPoint(x: 0, y:(dropDown.anchorView?.plainView.bounds.height)! + 36)
        dropDown.selectionAction = { [unowned self] (index: Int, item: String) in
            dividerNumTextField.text = item
            print("인덱스 : \(index)")
            self.dropDown.clearSelection()
        }
        
        //이거 then 안에 넣는 법
        dueTimeTextField.inputView = datePicker
        
        setConstraints()
    }
    
    func setConstraints() {
        
        // ScrollView
        scrollView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.leading.equalTo(view.safeAreaLayoutGuide)
            make.trailing.equalTo(view.safeAreaLayoutGuide)
            make.bottom.equalTo(view.snp.bottom)
        }
        scrollContentView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
            make.width.equalTo(scrollView.snp.width)
            make.height.equalTo(720)
        }
        
        // Label
        titleLabel.snp.makeConstraints { make in
            make.leading.equalTo(scrollContentView.snp.leading).offset(20)
            make.top.equalTo(scrollContentView).offset(40)
        }
        storeLabel.snp.makeConstraints { make in
            make.leading.equalTo(scrollContentView.snp.leading).offset(20)
            make.top.equalTo(titleLabel.snp.bottom).offset(30)
        }
        deliveryFeeLabel.snp.makeConstraints { make in
            make.leading.equalTo(scrollContentView.snp.leading).offset(20)
            make.top.equalTo(storeLabel.snp.bottom).offset(30)
        }
        deliveryFeeUnitLabel.snp.makeConstraints { make in
            make.leading.equalTo(deliveryFeeTextField.snp.trailing).offset(10)
            make.centerY.equalTo(deliveryFeeLabel.snp.centerY)
        }
        dividerNumLabel.snp.makeConstraints { make in
            make.leading.equalTo(scrollContentView.snp.leading).offset(20)
            make.top.equalTo(deliveryFeeLabel.snp.bottom).offset(30)
        }
        minimumDividerLabel.snp.makeConstraints { make in
            make.leading.equalTo(dividerNumTextField.snp.trailing).offset(10)
            make.centerY.equalTo(dividerNumLabel.snp.centerY)
        }
        dueTimeLabel.snp.makeConstraints { make in
            make.leading.equalTo(scrollContentView.snp.leading).offset(20)
            make.top.equalTo(dividerNumLabel.snp.bottom).offset(30)
        }
        placeLabel.snp.makeConstraints { make in
            make.leading.equalTo(scrollContentView.snp.leading).offset(20)
            make.top.equalTo(dueTimeLabel.snp.bottom).offset(30)
        }
        contentLabel.snp.makeConstraints { make in
            make.leading.equalTo(scrollContentView.snp.leading).offset(20)
            make.top.equalTo(placeLabel.snp.bottom).offset(175)
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
        
        
        //UIView
        dividerTouchView.snp.makeConstraints { make in
            make.edges.equalTo(dividerNumTextField)
        }
//        timeTouchView.snp.makeConstraints { make in
//            make.edges.equalTo(dueTimeTextField)
//        }
        
        mapView.snp.makeConstraints { make in
            make.top.equalTo(placeLabel.snp.top).offset(-7)
            make.leading.equalTo(dividerNumLabel.snp.trailing).offset(20)
            make.trailing.equalToSuperview().offset(-20)
            make.height.equalTo(178)
            make.width.equalTo(251)
        }
        
        //UITextView
        contentTextView.snp.makeConstraints { make in
            make.top.equalTo(contentLabel.snp.top).offset(-7)
            make.leading.equalTo(dividerNumLabel.snp.trailing).offset(20)
            make.trailing.equalToSuperview().offset(-20)
            make.height.equalTo(178)
            make.width.equalTo(251)
        }
        
        
        //Button
        uploadButton.snp.makeConstraints { make in
            make.centerX.equalTo(scrollContentView)
            make.bottom.equalTo(scrollContentView.snp.bottom)
            make.width.equalTo(scrollContentView.snp.width).inset(20)
            make.height.equalTo(50)
        }
        recruitNumSelectButton.snp.makeConstraints { make in
            make.height.equalTo(36)
            make.width.equalTo(36)
            make.centerY.equalTo(dividerNumTextField.snp.centerY)
            make.trailing.equalTo(dividerNumTextField.snp.trailing)
        }
    }
    
    
    @objc func onTapButton() {
        print("Button was tapped.")
        dropDown.show()
    }
    
    @objc func handleDatePicker(_ sender: UIDatePicker) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "H 시 m 분"
        let dateString = dateFormatter.string(from: sender.date)
        self.dueTimeTextField.text = dateString
        self.dueTimeTextField.resignFirstResponder()
    }
}


