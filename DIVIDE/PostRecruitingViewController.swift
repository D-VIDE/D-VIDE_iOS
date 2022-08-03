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
import GoogleMaps

enum Reusable {
    static let tagCell = ReusableCell<TagCollectionViewCell>()
  }


class PostRecruitingViewController: UIViewController {
    
    var tagList: [String] = ["한식", "중식", "양식", "태국식", "남원정", "정지윤", "정명진", "조병우", "홍유준", "패스파인더"]
    
    // 위,경도
//    var arrayCoordinates : [CLLocationCoordinate2D] = []
    
    // UIScrollView 정의
    let scrollView = UIScrollView().then {
        $0.backgroundColor = .viewBackgroundGray
        $0.showsVerticalScrollIndicator = false
        $0.showsHorizontalScrollIndicator = false
    }
    
    let scrollContentView = UIView().then {
        $0.backgroundColor = .viewBackgroundGray
    }
    
    // 중복 선언
    let navBar = MainNavBar().then {
        $0.backgroundColor = .white
    }
    
    
    // UILabel 정의
    let titleLabel = MainLabel(type: .bold).then {
        $0.text = "• 제목"
    }
    let storeLabel = MainLabel(type: .bold).then {
        $0.text = "• 가게 이름"
    }
    let categoryLabel = MainLabel(type: .bold).then {
        $0.text = "• 카테고리"
    }
    let deliveryFeeLabel = MainLabel(type: .bold).then {
        $0.text = "• 배달비"
    }
    let deliveryFeeUnitLabel = MainLabel(type: .bold).then {
        $0.text = "원"
        $0.textColor = .mainLightGray
        $0.font = UIFont.NotoSansKR(.bold, size: 12)
    }
    let dueTimeLabel = MainLabel(type: .bold).then {
        $0.text = "• 마감 시간"
    }
    let photoLabel = MainLabel(type: .bold).then {
        $0.text = "• 사진"
    }
    let placeLabel = MainLabel(type: .bold).then {
        $0.text = "• 장소"
    }
    let contentLabel = MainLabel(type: .bold).then {
        $0.text = "• 내용"
    }
    
    //UITextField 정의
    let titleTextField = MainTextField(type: .main).then {
        $0.textFieldTextChanged($0)
    }
    let storeTextField = MainTextField(type: .main).then {
        $0.textFieldTextChanged($0)
    }
    let categoryTextField = MainTextField(type: .main).then {
        $0.isUserInteractionEnabled = false
    }
    let deliveryFeeTextField = MainTextField(type: .main).then {
        $0.textFieldTextChanged($0)
        $0.keyboardType = .numberPad
        $0.text = $0.text?.insertComma
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
        $0.layer.borderColor = UIColor.mainLightGray.cgColor
        $0.layer.cornerRadius = 18
        $0.layer.maskedCorners = CACornerMask(arrayLiteral: .layerMaxXMinYCorner, .layerMaxXMaxYCorner)
        $0.layer.addShadow(location: .all)
        $0.font = UIFont.NotoSansKR(.medium, size: 15)
//        $0.addTarget(self, action: #selector(textFieldTextChanged(_:)), for: .editingChanged)

    }
    
    //UIView 정의
    
//    let timeTouchView = MainView(type: .touch).then {
//    }
//    GMSMapView.map(withFrame: self.view.frame, camera: camera)
    
    let mapView = GMSMapView().then {
        $0.backgroundColor = .white
        $0.layer.borderWidth = 0.2
        $0.layer.borderColor = UIColor.mainLightGray.cgColor
        $0.layer.cornerRadius = 18
        $0.clipsToBounds = true
        $0.layer.maskedCorners = CACornerMask(arrayLiteral: .layerMaxXMinYCorner, .layerMaxXMaxYCorner)
        $0.layer.addShadow(location: .all)
    }
    
    //UIButton 정의
    let uploadButton =  MainButton(type: .mainAction).then {
        $0.setTitle("업로드 하기", for: .normal)
//        $0.addTarget(self, action: #selector(onTapButton), for: .touchUpInside)
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
//    let dropDown = DropDown().then {
//        $0.dataSource = ["1", "2", "3", "4", "5"]
//    }
    
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
        view.backgroundColor = .viewBackgroundGray
        

        let image = UIImage(named: "NavRecruitPost")
        
        navigationController?.view.backgroundColor = .white
        navigationController?.navigationBar.isTransparent = false
        navigationController?.navigationBar.backgroundColor = .white
        
        navigationController?.navigationBar.titleTextAttributes = [
            .foregroundColor: UIColor.mainOrange2,
            .font: UIFont.SDSamliphopang(.basic, size: 25)
        ]
        
        navigationController?.navigationBar.layer.addBorder([.bottom, .left, .right], color: .mainLightGray, width: 0.1)
        navigationController?.navigationBar.topItem?.title = "D/VIDE 모집글 작성"
//        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: UIFont(name: "BM DoHyeon OTF", size: 12)!]
        navigationController?.navigationBar.layer.cornerRadius = 18
        navigationController?.navigationBar.layer.maskedCorners = CACornerMask(arrayLiteral: .layerMaxXMaxYCorner, .layerMinXMaxYCorner)
        
//        navigationController?.additionalSafeAreaInsets.top = 40
//        navigationController?.navigationItem.title.font = UIFont.AppleSDGothicNeo(.bold, size: 20)
        
        view.addSubview(scrollView)
        scrollView.addSubview(scrollContentView)
        
        categoryCollectionView.delegate = self
        categoryCollectionView.dataSource = self
        
        //UILabel add
        scrollContentView.addSubviews([titleLabel, storeLabel, deliveryFeeLabel, dueTimeLabel, placeLabel, contentLabel, categoryLabel, photoLabel])
        
        deliveryFeeTextField.addSubview(deliveryFeeUnitLabel)
    
        //UITextField add
        scrollContentView.addSubviews([categoryCollectionView, titleTextField, storeTextField, categoryTextField, deliveryFeeTextField, dueTimeTextField])
        
        // UIView add
        scrollContentView.addSubviews([contentTextView, mapView])
        
        
        //UIButton add
        scrollContentView.addSubviews([uploadButton, dropDownButton, imgUploadButton])
        
        //UIImageView add
        scrollContentView.addSubviews([imgForUpload])
        
        
//        dropDown.anchorView = dividerNumTextField
//        dropDown.bottomOffset = CGPoint(x: 0, y:(dropDown.anchorView?.plainView.bounds.height)! + 36)
//        dropDown.selectionAction = { [unowned self] (index: Int, item: String) in
//            dividerNumTextField.text = item
//            print("인덱스 : \(index)")
//            self.dropDown.clearSelection()
//        }
        
        //이거 then 안에 넣는 법
        dueTimeTextField.inputView = datePicker
        
        categoryCollectionView.isHidden = true

        setConstraints()
    
//        nav.snp.makeConstraints {
//            $0.edges.equalTo(view.safeAreaLayoutGuide)
//        }
        
//        // 카메라 이동
//        let camera = GMSCameraPosition.camera(withLatitude: 35.232234, longitude: 129.085211, zoom: 17.0)
//        mapView.camera = camera
//
//        // Creates a marker in the center of the map.
//        let marker = GMSMarker()
//        marker.position = CLLocationCoordinate2D(latitude: 35.232234, longitude: 129.085211)
//        marker.title = "우리 집"
//        marker.snippet = "Australia"
//        marker.map = mapView
//        
//        
//        let longPressRecognizer = UILongPressGestureRecognizer(target: self, action: #selector(self.setMarker))
//        longPressRecognizer.minimumPressDuration = 0.5
//        mapView.addGestureRecognizer(longPressRecognizer)

//        mapView.isMyLocationEnabled = true
//        mapView.settings.compassButton = true
        
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
            make.height.equalTo(850)
        }
        
        // Label
        titleLabel.snp.makeConstraints { make in
            make.leading.equalTo(scrollContentView.snp.leading).offset(26)
            make.centerY.equalTo(titleTextField.snp.centerY)
        }
        storeLabel.snp.makeConstraints { make in
            make.leading.equalTo(scrollContentView.snp.leading).offset(26)
            make.centerY.equalTo(storeTextField.snp.centerY)
        }
        categoryLabel.snp.makeConstraints { make in
            make.leading.equalTo(scrollContentView.snp.leading).offset(26)
            make.centerY.equalTo(categoryTextField.snp.centerY)
        }
        deliveryFeeLabel.snp.makeConstraints { make in
            make.leading.equalTo(scrollContentView.snp.leading).offset(26)
            make.centerY.equalTo(deliveryFeeTextField.snp.centerY)
        }
        deliveryFeeUnitLabel.snp.makeConstraints { make in
            make.leading.equalTo(deliveryFeeTextField.snp.trailing).offset(-25)
            make.centerY.equalTo(deliveryFeeTextField.snp.centerY)
        }
        dueTimeLabel.snp.makeConstraints { make in
            make.leading.equalTo(scrollContentView.snp.leading).offset(26)
            make.centerY.equalTo(dueTimeTextField.snp.centerY)
        }
        photoLabel.snp.makeConstraints { make in
            make.leading.equalTo(scrollContentView.snp.leading).offset(26)
            make.top.equalTo(imgForUpload.snp.top)
        }
        placeLabel.snp.makeConstraints { make in
            make.leading.equalTo(scrollContentView.snp.leading).offset(26)
            make.top.equalTo(mapView.snp.top).offset(7)
        }
        contentLabel.snp.makeConstraints { make in
            make.leading.equalTo(scrollContentView.snp.leading).offset(26)
            make.top.equalTo(contentTextView.snp.top).offset(7)
        }
        
        //TextField
        titleTextField.snp.makeConstraints { make in
            make.top.equalTo(scrollContentView.snp.top).offset(28)
            make.leading.equalTo(dueTimeLabel.snp.trailing).offset(20)
            make.trailing.equalToSuperview().offset(-20)
            make.height.equalTo(36)
            make.width.equalTo(251)
        }
        storeTextField.snp.makeConstraints { make in
            make.top.equalTo(titleTextField.snp.bottom).offset(12)
            make.leading.equalTo(dueTimeLabel.snp.trailing).offset(20)
            make.trailing.equalToSuperview().offset(-20)
            make.height.equalTo(36)
            make.width.equalTo(251)
        }
        categoryTextField.snp.makeConstraints { make in
            make.top.equalTo(storeTextField.snp.bottom).offset(12)
            make.leading.equalTo(dueTimeLabel.snp.trailing).offset(20)
            make.trailing.equalToSuperview().offset(-20)
            make.height.equalTo(36)
            make.width.equalTo(251)
        }
        deliveryFeeTextField.snp.makeConstraints { make in
            make.top.equalTo(categoryTextField.snp.bottom).offset(12)
            make.leading.equalTo(dueTimeLabel.snp.trailing).offset(20)
            make.height.equalTo(36)
            make.width.equalTo(251)
        }
        dueTimeTextField.snp.makeConstraints { make in
            make.top.equalTo(deliveryFeeTextField.snp.bottom).offset(12)
            make.leading.equalTo(dueTimeLabel.snp.trailing).offset(20)
            make.trailing.equalToSuperview().offset(-20)
            make.height.equalTo(36)
            make.width.equalTo(251)
        }
        
        //UICollectionView
        categoryCollectionView.snp.makeConstraints { make in
            make.top.equalTo(categoryTextField.snp.bottom).offset(-10)
            make.leading.equalTo(categoryTextField.snp.leading)
            make.width.equalTo(251)
            make.height.equalTo(134)
        }
        
        
        //UIView
        
        mapView.snp.makeConstraints { make in
            make.top.equalTo(imgForUpload.snp.bottom).offset(17)
            make.leading.equalTo(dueTimeLabel.snp.trailing).offset(20)
            make.trailing.equalToSuperview().offset(-20)
            make.height.equalTo(178)
            make.width.equalTo(251)
        }
        
        //UITextView
        contentTextView.snp.makeConstraints { make in
            make.top.equalTo(mapView.snp.bottom).offset(12)
            make.leading.equalTo(dueTimeLabel.snp.trailing).offset(20)
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
            make.centerY.equalTo(categoryTextField.snp.centerY)
            make.trailing.equalTo(categoryTextField.snp.trailing)
        }
        imgUploadButton.snp.makeConstraints { make in
            make.centerY.equalTo(imgForUpload.snp.centerY)
            make.leading.equalTo(imgForUpload.snp.trailing).offset(10)
            make.height.equalTo(71)
            make.width.equalTo(77)
        }
        
        //UIImageView
        imgForUpload.snp.makeConstraints { make in
            make.top.equalTo(dueTimeTextField.snp.bottom).offset(17)
            make.leading.equalTo(dueTimeLabel.snp.trailing).offset(20)
            make.height.equalTo(71)
            make.width.equalTo(77)
        }
    }
    
    
    
    
//    @objc func onTapButton() {
//        print("Button was tapped.")
//        dropDown.show()
//    }
    func inOutCategory() {
        if categoryCollectionView.isHidden {
            dropDownButton.setImage(UIImage(named: "dropUpButton"), for: .normal)
            deliveryFeeTextField.snp.remakeConstraints { make in
                make.top.equalTo(categoryCollectionView.snp.bottom).offset(12)
                make.leading.equalTo(dueTimeLabel.snp.trailing).offset(20)
                make.height.equalTo(36)
                make.width.equalTo(251)
            }
            
            scrollContentView.snp.remakeConstraints { make in
                make.edges.equalToSuperview()
                make.width.equalTo(scrollView.snp.width)
                make.height.equalTo(984)
            }
            
        } else {
            dropDownButton.setImage(UIImage(named: "dropDownButton"), for: .normal)
            deliveryFeeTextField.snp.remakeConstraints { make in
                make.top.equalTo(categoryTextField.snp.bottom).offset(12)
                make.leading.equalTo(dueTimeLabel.snp.trailing).offset(20)
                make.height.equalTo(36)
                make.width.equalTo(251)
            }
            
            scrollContentView.snp.remakeConstraints { make in
                make.edges.equalToSuperview()
                make.width.equalTo(scrollView.snp.width)
                make.height.equalTo(850)
            }
        }
        
        categoryCollectionView.isHidden = !categoryCollectionView.isHidden
    }
    
    
    @objc func handleDatePicker(_ sender: UIDatePicker) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "a h 시 m 분"
        let dateString = dateFormatter.string(from: sender.date)
        self.dueTimeTextField.text = dateString
        self.dueTimeTextField.resignFirstResponder()
    }
    
//    @objc func upload() {
//        print("Button was tapped.")
//        dropDown.show()
//    }
    @objc func selectPhoto() {
        print("photo selected")
        let imagePicker = UIImagePickerController()
        imagePicker.sourceType = .photoLibrary
        imagePicker.delegate = self //3
        // imagePicker.allowsEditing = true
        present(imagePicker, animated: true)
    }
    
    @objc func showCategory() {
        inOutCategory()
    }
    
    @objc func setMarker(_ sender: UILongPressGestureRecognizer) {
        print("Long Pressed")
        
        let newMarker = GMSMarker(position: mapView.projection.coordinate(for: sender.location(in: mapView)))
        self.arrayCoordinates.append(newMarker.position)
        newMarker.map = mapView
    }
}
extension PostRecruitingViewController: UITextFieldDelegate {
    func textField(_ textField: MainTextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
    
        if textField == deliveryFeeTextField {
            let allowedCharacters = CharacterSet.decimalDigits
            let characterSet = CharacterSet(charactersIn: string)
            return allowedCharacters.isSuperset(of: characterSet)
        }
        return true
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

        let label = MainLabel(type: .bold).then {
            $0.text = tagList[indexPath.item]
            $0.sizeToFit()
        }
        let size = label.frame.size

        return CGSize(width: size.width + 16, height: size.height + 10)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.dequeue(Reusable.tagCell, for: indexPath)
        categoryTextField.text = tagList[indexPath.row]
        inOutCategory()

//        collectionView.reloadData()
    }
}


extension PostRecruitingViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let pickedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            imgForUpload.contentMode = .scaleToFill
            imgForUpload.image = pickedImage //4
        }
        dismiss(animated: true, completion: nil)
    }
        
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
}
