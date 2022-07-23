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
import ReusableKit

enum Reusable {
    static let tagCell = ReusableCell<TagCollectionViewCell>()
  }


class PostRecruitingViewController: UIViewController {
    
    var tagList: [String] = ["한식", "중식", "양식", "태국식", "남원정", "정지윤", "정명진", "조병우", "홍유준", "패스파인더"]
    
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
    let categoryLabel = MainLabel(type: .gray).then {
        $0.text = "• 카테고리"
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
        $0.text = "명"
        $0.font = UIFont.AppleSDGothicNeo(.medium, size: 13)
    }
    let dueTimeLabel = MainLabel(type: .gray).then {
        $0.text = "• 마감 시간"
    }
    let photoLabel = MainLabel(type: .gray).then {
        $0.text = "• 사진"
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
    
    // UICollectionView 정의
    let categoryCollectionView = UICollectionView(frame: .zero, collectionViewLayout: .init()).then {
        let layout = LeftAlignedCollectionViewFlowLayout()
        layout.minimumLineSpacing = 7
        layout.minimumInteritemSpacing = 7
        layout.sectionInset = UIEdgeInsets(top: 20, left: 10, bottom: 10, right: 10)
        $0.backgroundColor = .viewBackgroundGray
        $0.layer.maskedCorners = CACornerMask(arrayLiteral: .layerMaxXMaxYCorner, .layerMinXMaxYCorner)
        $0.layer.cornerRadius = 20
        $0.isScrollEnabled = false
        $0.collectionViewLayout = layout
        $0.register(Reusable.tagCell)
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
    let categoryView = UIView().then {
        $0.backgroundColor = .white
        $0.layer.borderWidth = 0.2
        $0.layer.borderColor = UIColor.mainGray.cgColor
        $0.layer.cornerRadius = 18
        $0.layer.maskedCorners = CACornerMask(arrayLiteral: .layerMaxXMinYCorner, .layerMaxXMaxYCorner)
        $0.layer.addShadow(location: .all)
    }
    
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
        $0.addTarget(self, action: #selector(onTapButton), for: .touchUpInside)
    }
    
    let dropDownButton = UIButton().then {
        $0.setImage(UIImage(named: "dropDownButton"), for: .normal)
        $0.layer.cornerRadius = 18
        $0.addTarget(self, action: #selector(showCategory), for: .touchUpInside)
    }
    
    let imgUploadButton = UIButton().then {
        $0.setBackgroundImage(UIImage(named: "selectPhoto"), for: .normal)
        $0.tintColor = .lightGray
        $0.addTarget(self, action: #selector(selectPhoto), for: .touchUpInside)
    }
    
    // UIImageView 선언
    let imgForUpload = UIImageView().then {
        $0.image = UIImage(named: "defaultPhoto")
        $0.clipsToBounds = true
        $0.layer.cornerRadius = 13
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
        view.backgroundColor = .red
        

        let image = UIImage(named: "NavRecruitPost")
        
        navigationItem.titleView = UIImageView(image: image)
        navigationController?.additionalSafeAreaInsets.top = 40
//        navigationController?.navigationItem.title.font = UIFont.AppleSDGothicNeo(.bold, size: 20)
        
        view.addSubview(scrollView)
        scrollView.addSubview(scrollContentView)
        
        categoryCollectionView.delegate = self
        categoryCollectionView.dataSource = self
        
        //UILabel add
        scrollContentView.addSubviews([titleLabel, storeLabel, deliveryFeeLabel, dividerNumLabel, dueTimeLabel, placeLabel, contentLabel, categoryLabel, photoLabel])
        
        deliveryFeeTextField.addSubview(deliveryFeeUnitLabel)
        dividerNumTextField.addSubview(minimumDividerLabel)
    
        //UITextField add
        scrollContentView.addSubviews([categoryCollectionView, titleTextField, storeTextField, deliveryFeeTextField, dividerNumTextField, dueTimeTextField])
        
        // UIView add
        scrollContentView.addSubviews([dividerTouchView, contentTextView, mapView, categoryView])
        
        
        //UIButton add
        scrollContentView.addSubviews([uploadButton, dropDownButton, imgUploadButton, dividerTouchView])
        
        //UIImageView add
        scrollContentView.addSubviews([imgForUpload])
        
        
        dropDown.anchorView = dividerNumTextField
        dropDown.bottomOffset = CGPoint(x: 0, y:(dropDown.anchorView?.plainView.bounds.height)! + 36)
        dropDown.selectionAction = { [unowned self] (index: Int, item: String) in
            dividerNumTextField.text = item
            print("인덱스 : \(index)")
            self.dropDown.clearSelection()
        }
        
        //이거 then 안에 넣는 법
        dueTimeTextField.inputView = datePicker
        
        categoryCollectionView.isHidden = true

        setConstraints()
    
//        nav.snp.makeConstraints {
//            $0.edges.equalTo(view.safeAreaLayoutGuide)
//        }
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
            make.height.equalTo(900)
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
        categoryLabel.snp.makeConstraints { make in
            make.leading.equalTo(scrollContentView.snp.leading).offset(20)
            make.top.equalTo(storeLabel.snp.bottom).offset(30)
        }
        deliveryFeeLabel.snp.makeConstraints { make in
            make.leading.equalTo(scrollContentView.snp.leading).offset(20)
            make.top.equalTo(categoryLabel.snp.bottom).offset(30)
        }
        deliveryFeeUnitLabel.snp.makeConstraints { make in
            make.leading.equalTo(deliveryFeeTextField.snp.trailing).offset(-25)
            make.centerY.equalTo(deliveryFeeLabel.snp.centerY)
        }
        dividerNumLabel.snp.makeConstraints { make in
            make.leading.equalTo(scrollContentView.snp.leading).offset(20)
            make.top.equalTo(deliveryFeeLabel.snp.bottom).offset(30)
        }
        minimumDividerLabel.snp.makeConstraints { make in
            make.leading.equalTo(dividerNumTextField.snp.trailing).offset(-25)
            make.centerY.equalTo(dividerNumLabel.snp.centerY)
        }
        dueTimeLabel.snp.makeConstraints { make in
            make.leading.equalTo(scrollContentView.snp.leading).offset(20)
            make.top.equalTo(dividerNumLabel.snp.bottom).offset(30)
        }
        photoLabel.snp.makeConstraints { make in
            make.leading.equalTo(scrollContentView.snp.leading).offset(20)
            make.top.equalTo(dueTimeLabel.snp.bottom).offset(30)
        }
        placeLabel.snp.makeConstraints { make in
            make.leading.equalTo(scrollContentView.snp.leading).offset(20)
            make.top.equalTo(photoLabel.snp.bottom).offset(90)
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
            make.width.equalTo(251)
        }
        dividerNumTextField.snp.makeConstraints { make in
            make.centerY.equalTo(dividerNumLabel.snp.centerY)
            make.leading.equalTo(dividerNumLabel.snp.trailing).offset(20)
            make.height.equalTo(36)
            make.width.equalTo(251)
        }
        dueTimeTextField.snp.makeConstraints { make in
            make.centerY.equalTo(dueTimeLabel.snp.centerY)
            make.leading.equalTo(dividerNumLabel.snp.trailing).offset(20)
            make.trailing.equalToSuperview().offset(-20)
            make.height.equalTo(36)
            make.width.equalTo(251)
        }
        
        //UICollectionView
        categoryCollectionView.snp.makeConstraints { make in
            make.top.equalTo(categoryView.snp.bottom).offset(-10)
            make.leading.equalTo(categoryView.snp.leading)
            make.width.equalTo(251)
            make.height.equalTo(134)
        }
        
        
        //UIView
        categoryView.snp.makeConstraints { make in
            make.centerY.equalTo(categoryLabel.snp.centerY)
            make.leading.equalTo(dividerNumLabel.snp.trailing).offset(20)
            make.trailing.equalToSuperview().offset(-20)
            make.height.equalTo(36)
            make.width.equalTo(251)
        }
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
            make.top.greaterThanOrEqualTo(contentTextView.snp.bottom).offset(20)
            make.centerX.equalTo(scrollContentView)
            make.bottom.equalTo(scrollContentView.snp.bottom).offset(-20)
            make.width.equalTo(scrollContentView.snp.width).inset(20)
            make.height.equalTo(50)
        }
        dropDownButton.snp.makeConstraints { make in
            make.height.equalTo(36)
            make.width.equalTo(36)
            make.centerY.equalTo(categoryView.snp.centerY)
            make.trailing.equalTo(categoryView.snp.trailing)
        }
        imgUploadButton.snp.makeConstraints { make in
            make.centerY.equalTo(imgForUpload.snp.centerY)
            make.leading.equalTo(imgForUpload.snp.trailing).offset(10)
            make.height.equalTo(71)
            make.width.equalTo(77)
        }
        
        //UIImageView
        imgForUpload.snp.makeConstraints { make in
            make.top.equalTo(photoLabel.snp.top)
            make.leading.equalTo(dividerNumLabel.snp.trailing).offset(20)
            make.height.equalTo(71)
            make.width.equalTo(77)
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
    
    @objc func upload() {
        print("Button was tapped.")
        dropDown.show()
    }
    @objc func selectPhoto() {
        print("photo selected")
        presentAlbum()
    }
    
    @objc func showCategory() {
        if categoryCollectionView.isHidden {
            dropDownButton.setImage(UIImage(named: "dropUpButton"), for: .normal)
            deliveryFeeLabel.snp.remakeConstraints { make in
                make.top.equalTo(categoryCollectionView.snp.bottom).offset(20)
                make.leading.equalTo(scrollContentView.snp.leading).offset(20)
            }
            
            scrollContentView.snp.remakeConstraints { make in
                make.edges.equalToSuperview()
                make.width.equalTo(scrollView.snp.width)
                make.height.equalTo(1034)
            }
            
        } else {
            dropDownButton.setImage(UIImage(named: "dropDownButton"), for: .normal)
            deliveryFeeLabel.snp.remakeConstraints { make in
                make.top.equalTo(categoryLabel.snp.bottom).offset(30)
                make.leading.equalTo(scrollContentView.snp.leading).offset(20)
            }
            
            scrollContentView.snp.remakeConstraints { make in
                make.edges.equalToSuperview()
                make.width.equalTo(scrollView.snp.width)
                make.height.equalTo(900)
            }
        }
        
        categoryCollectionView.isHidden = !categoryCollectionView.isHidden
    }
}

extension PostRecruitingViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return tagList.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeue(Reusable.tagCell, for: indexPath)
        
        cell.tagLabel.text = tagList[indexPath.row]
        
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

        let label = MainLabel(type: .gray).then {
            $0.text = tagList[indexPath.item]
            $0.sizeToFit()
        }
        let size = label.frame.size

        return CGSize(width: size.width + 16, height: size.height + 10)
    }
}


extension PostRecruitingViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    // 앨범 띄우기
    func presentAlbum(){
        let vc = UIImagePickerController()
        vc.sourceType = .photoLibrary
        vc.delegate = self
        vc.allowsEditing = true
        
        present(vc, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
      
        if let image = info[.editedImage] as? UIImage {
            imgForUpload.image = image
        }
        dismiss(animated: true, completion: nil)
    }
}

