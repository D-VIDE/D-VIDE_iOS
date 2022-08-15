////
////  ViewController.swift
////  DIVIDE
////
////  Created by 정지윤 on 2022/06/28.
////
//

import UIKit
import Then
import SnapKit
import DropDown
import ReusableKit
import NMapsMap

enum PostReusable {
    static let tagCell = ReusableCell<TagCollectionViewCell>()
  }


public let imgWidth = (Device.width - 139 - 20) / 3

class PostRecruitingViewController: UIViewController {
    
    var tagList: [String] = ["한식", "중식", "양식", "태국식", "남원정", "정지윤", "정명진", "조병우", "홍유준", "패스파인더"]
    
    
    let apiManager = PostRecruitingAPIManager()
    
    // 위,경도
    var coordinate = NMGLatLng(lat: 37, lng: 127)
    lazy var CAMERA_POSITION = NMFCameraPosition(coordinate, zoom: 12, tilt: 0, heading: 0)
    lazy var marker = NMFMarker(position: NMGLatLng(lat: coordinate.lat, lng: coordinate.lng))


    // 사진 고른 횟수
    var imgSelectNum : Int!
    
    // 시간 milliseconds
    var milliseconds : Int?
    
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
    let titleLabel = MainLabel(type: .Basics5).then {
        $0.text = "• 제목"
    }
    let storeLabel = MainLabel(type: .Basics5).then {
        $0.text = "• 가게 이름"
    }
    let categoryLabel = MainLabel(type: .Basics5).then {
        $0.text = "• 카테고리"
    }
    let deliveryFeeLabel = MainLabel(type: .Basics5).then {
        $0.text = "• 배달비"
    }
    let deliveryFeeUnitLabel = MainLabel(type: .Point2).then {
        $0.text = "원"
        $0.textColor = .unitGray
    }
    let aimUnitLabel = MainLabel(type: .Point2).then {
        $0.text = "원"
        $0.textColor = .unitGray
    }
    let deliveryAimMoneyLabel = MainLabel(type: .Basics5).then {
        $0.text = "• 목표 금액"
    }
    let dueTimeLabel = MainLabel(type: .Basics5).then {
        $0.text = "• 마감 시간"
    }
    let photoLabel = MainLabel(type: .Basics5).then {
        $0.text = "• 사진"
    }
    let placeLabel = MainLabel(type: .Basics5).then {
        $0.text = "• 장소"
    }
    let contentLabel = MainLabel(type: .Basics5).then {
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
    let deliveryAimTextField = MainTextField(type: .main).then {
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
        $0.register(PostReusable.tagCell)
      }
    
    //UITextView 정의
    let contentTextView = UITextView().then {
        $0.textContainerInset = UIEdgeInsets(top: 18.0, left: 18.0, bottom: 18.0, right: 18.0)
        $0.backgroundColor = .white
//        $0.layer.borderWidth = 0.2
//        $0.layer.borderColor = UIColor.borderGray.cgColor
        $0.layer.cornerRadius = 18
        $0.layer.maskedCorners = CACornerMask(arrayLiteral: .layerMaxXMinYCorner, .layerMaxXMaxYCorner)
        $0.layer.addShadow(location: .all)
        $0.font = UIFont.NotoSansKR(.medium, size: 15)
//        $0.addTarget(self, action: #selector(textFieldTextChanged(_:)), for: .editingChanged)
    }
        
    let mapView = NMFMapView().then {
        $0.backgroundColor = .white
//        $0.layer.borderWidth = 0.2
//        $0.layer.borderColor = UIColor.borderGray.cgColor
        $0.layer.cornerRadius = 18
        $0.clipsToBounds = true
        $0.layer.maskedCorners = CACornerMask(arrayLiteral: .layerMaxXMinYCorner, .layerMaxXMaxYCorner)
        $0.layer.addShadow(location: .all)
    }
    
    //UIButton 정의
    let uploadButton =  MainButton(type: .mainAction).then {
        $0.setTitle("업로드 하기", for: .normal)
        $0.addTarget(self, action: #selector(post), for: .touchUpInside)
    }
    
    let dropDownButton = UIButton().then {
        $0.setImage(UIImage(named: "dropDownButton"), for: .normal)
        $0.layer.cornerRadius = 18
        $0.addTarget(self, action: #selector(showCategory), for: .touchUpInside)
    }
    
    //View for Button 정의
    lazy var imgUploadButton = UIView().then {
        $0.backgroundColor = .clear
        $0.isUserInteractionEnabled = true
        $0.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(selectPhoto)))
    }
    
    lazy var imgUploadButton2 = UIView().then {
        $0.backgroundColor = .clear
        $0.isUserInteractionEnabled = true
        $0.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(selectPhoto)))
    }
    
    // UIImageView 선언
    let imgForUpload = UIImageView().then {
        $0.image = UIImage(named: "defaultPhoto")
        $0.clipsToBounds = true
        $0.layer.cornerRadius = 13
    }
    let imgForUpload1 = UIImageView().then {
        $0.image = UIImage(named: "selectPhoto")
        $0.clipsToBounds = true
        $0.layer.cornerRadius = 13
    }
    let imgForUpload2 = UIImageView().then {
        $0.image = UIImage(named: "selectPhoto")
        $0.clipsToBounds = true
        $0.layer.cornerRadius = 13
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
        view.backgroundColor = .viewBackgroundGray
        

        let image = UIImage(named: "NavRecruitPost")
        
        navigationController?.view.backgroundColor = .white
        navigationController?.navigationBar.isTransparent = false
        navigationController?.navigationBar.backgroundColor = .white
        
        navigationController?.navigationBar.titleTextAttributes = [
            .foregroundColor: UIColor.mainOrange2,
            .font: UIFont.SDSamliphopang(.basic, size: 25)
        ]
        
        navigationController?.navigationBar.layer.addBorder([.bottom, .left, .right], color: .borderGray, width: 0.1)
        navigationController?.navigationBar.topItem?.title = "D/VIDE 모집글 작성"
        navigationController?.navigationBar.layer.cornerRadius = 18
        navigationController?.navigationBar.layer.maskedCorners = CACornerMask(arrayLiteral: .layerMaxXMaxYCorner, .layerMinXMaxYCorner)
        
//        navigationController?.additionalSafeAreaInsets.top = 40
        
        self.view.addSubview(scrollView)
        scrollView.addSubview(scrollContentView)
        
        categoryCollectionView.delegate = self
        categoryCollectionView.dataSource = self
        
        //UILabel add
        scrollContentView.addSubviews([titleLabel, storeLabel, deliveryFeeLabel, deliveryAimMoneyLabel, dueTimeLabel, placeLabel, contentLabel, categoryLabel, photoLabel])
        
        deliveryFeeTextField.addSubview(deliveryFeeUnitLabel)
        deliveryAimTextField.addSubview(aimUnitLabel)
    
        //UITextField add
        scrollContentView.addSubviews([categoryCollectionView, titleTextField, storeTextField, categoryTextField, deliveryFeeTextField, deliveryAimTextField, dueTimeTextField])
        
        // UIView add
        scrollContentView.addSubviews([contentTextView, mapView])
        
        //UIButton add
        scrollContentView.addSubviews([uploadButton, dropDownButton])
        imgForUpload1.addSubview(imgUploadButton)
        imgForUpload2.addSubview(imgUploadButton2)
        
        
        //UIImageView add
        scrollContentView.addSubviews([imgForUpload, imgForUpload1, imgForUpload2])
        
        imgUploadButton.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(selectPhoto)))

        
        dueTimeTextField.inputView = datePicker
        categoryCollectionView.isHidden = true
        imgUploadButton2.isHidden = true
        imgForUpload2.isHidden = true
        imgSelectNum = 0
        
        
        imgUploadButton.isUserInteractionEnabled = true
        imgUploadButton.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(selectPhoto)))
        imgUploadButton2.isUserInteractionEnabled = true
        imgUploadButton2.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(selectPhoto)))
        
        setConstraints()
        
        //카메라 이동
        mapView.touchDelegate = self
        mapView.moveCamera(NMFCameraUpdate(position: CAMERA_POSITION))

        // Creates a marker in the center of the map.
        marker.iconImage = NMF_MARKER_IMAGE_BLACK
        marker.mapView = mapView
        
        
        let longPressRecognizer = UILongPressGestureRecognizer(target: self, action: #selector(self.setMarker))
        longPressRecognizer.minimumPressDuration = 0.5
        mapView.addGestureRecognizer(longPressRecognizer)

        
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
        }
        
        // Label
        titleLabel.snp.makeConstraints { make in
            make.leading.equalTo(scrollContentView.snp.leading).offset(26)
            make.width.equalTo(93)
            make.centerY.equalTo(titleTextField.snp.centerY)
        }
        storeLabel.snp.makeConstraints { make in
            make.leading.equalTo(scrollContentView.snp.leading).offset(26)
            make.width.equalTo(93)
            make.centerY.equalTo(storeTextField.snp.centerY)
        }
        categoryLabel.snp.makeConstraints { make in
            make.leading.equalTo(scrollContentView.snp.leading).offset(26)
            make.width.equalTo(93)
            make.centerY.equalTo(categoryTextField.snp.centerY)
        }
        deliveryFeeLabel.snp.makeConstraints { make in
            make.leading.equalTo(scrollContentView.snp.leading).offset(26)
            make.width.equalTo(93)
            make.centerY.equalTo(deliveryFeeTextField.snp.centerY)
        }
        deliveryAimMoneyLabel.snp.makeConstraints { make in
            make.leading.equalTo(scrollContentView.snp.leading).offset(26)
            make.width.equalTo(93)
            make.centerY.equalTo(deliveryAimTextField.snp.centerY)
        }
        deliveryFeeUnitLabel.snp.makeConstraints { make in
            make.trailing.equalTo(deliveryFeeTextField.snp.trailing).offset(-18)
            make.centerY.equalTo(deliveryFeeTextField.snp.centerY)
        }
        aimUnitLabel.snp.makeConstraints { make in
            make.trailing.equalTo(deliveryAimTextField.snp.trailing).offset(-18)
            make.centerY.equalTo(deliveryAimTextField.snp.centerY)
        }
        dueTimeLabel.snp.makeConstraints { make in
            make.leading.equalTo(scrollContentView.snp.leading).offset(26)
            make.width.equalTo(93)
            make.centerY.equalTo(dueTimeTextField.snp.centerY)
        }
        photoLabel.snp.makeConstraints { make in
            make.leading.equalTo(scrollContentView.snp.leading).offset(26)
            make.width.equalTo(93)
            make.top.equalTo(imgForUpload.snp.top)
        }
        placeLabel.snp.makeConstraints { make in
            make.leading.equalTo(scrollContentView.snp.leading).offset(26)
            make.width.equalTo(93)
            make.top.equalTo(mapView.snp.top).offset(7)
        }
        contentLabel.snp.makeConstraints { make in
            make.leading.equalTo(scrollContentView.snp.leading).offset(26)
            make.width.equalTo(93)
            make.top.equalTo(contentTextView.snp.top).offset(7)
        }
        
        //TextField
        titleTextField.snp.makeConstraints { make in
            make.top.equalTo(scrollContentView.snp.top).offset(28)
            make.leading.equalTo(titleLabel.snp.trailing)
            make.trailing.equalToSuperview().offset(-20)
            make.height.equalTo(36)
//            make.width.equalTo(251)
        }
        storeTextField.snp.makeConstraints { make in
            make.top.equalTo(titleTextField.snp.bottom).offset(12)
            make.leading.equalTo(storeLabel.snp.trailing)
            make.trailing.equalToSuperview().offset(-20)
            make.height.equalTo(36)
//            make.width.equalTo(251)
        }
        categoryTextField.snp.makeConstraints { make in
            make.top.equalTo(storeTextField.snp.bottom).offset(12)
            make.leading.equalTo(categoryLabel.snp.trailing)
            make.trailing.equalToSuperview().offset(-20)
            make.height.equalTo(36)
//            make.width.equalTo(251)
        }
        deliveryFeeTextField.snp.makeConstraints { make in
            make.top.equalTo(categoryTextField.snp.bottom).offset(12)
            make.leading.equalTo(deliveryFeeLabel.snp.trailing)
            make.trailing.equalToSuperview().offset(-20)
            make.height.equalTo(36)
//            make.width.equalTo(251)
        }
        deliveryAimTextField.snp.makeConstraints { make in
            make.top.equalTo(deliveryFeeTextField.snp.bottom).offset(12)
            make.leading.equalTo(deliveryAimMoneyLabel.snp.trailing)
            make.trailing.equalToSuperview().offset(-20)
            make.height.equalTo(36)
//            make.width.equalTo(251)
        }
        dueTimeTextField.snp.makeConstraints { make in
            make.top.equalTo(deliveryAimTextField.snp.bottom).offset(12)
            make.leading.equalTo(dueTimeLabel.snp.trailing)
            make.trailing.equalToSuperview().offset(-20)
            make.height.equalTo(36)
//            make.width.equalTo(251)
        }
        
        //UICollectionView
        categoryCollectionView.snp.makeConstraints { make in
            make.top.equalTo(categoryTextField.snp.bottom).offset(-10)
            make.horizontalEdges.equalTo(categoryTextField.snp.horizontalEdges)
            make.height.equalTo(134)
        }
        
        
        //UIView
        mapView.snp.makeConstraints { make in
            make.top.equalTo(imgForUpload.snp.bottom).offset(17)
            make.leading.equalTo(placeLabel.snp.trailing)
            make.trailing.equalToSuperview().offset(-20)
            make.height.equalTo(178)
        }
        
        //UITextView
        contentTextView.snp.makeConstraints { make in
            make.top.equalTo(mapView.snp.bottom).offset(12)
            make.bottom.equalTo(uploadButton.snp.top).offset(-20)
            make.leading.equalTo(contentLabel.snp.trailing)
            make.trailing.equalToSuperview().offset(-20)
            make.height.equalTo(178)
        }
        
        
        //Button
        uploadButton.snp.makeConstraints { make in
            make.top.greaterThanOrEqualTo(contentTextView.snp.bottom).offset(20)
            make.centerX.equalTo(scrollContentView)
            make.bottom.equalTo(scrollContentView.snp.bottom).offset(-29)
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
            make.edges.equalTo(imgForUpload1.snp.edges)
        }
        imgUploadButton2.snp.makeConstraints { make in
            make.edges.equalTo(imgForUpload2.snp.edges)
        }
        
        //UIImageView
        imgForUpload.snp.makeConstraints { make in
            make.top.equalTo(dueTimeTextField.snp.bottom).offset(17)
            make.leading.equalTo(dueTimeLabel.snp.trailing)
            make.height.equalTo(71)
            make.width.equalTo(imgWidth)
        }
        imgForUpload1.snp.makeConstraints { make in
            make.centerY.equalTo(imgForUpload.snp.centerY)
            make.leading.equalTo(imgForUpload.snp.trailing).offset(10)
            make.height.equalTo(71)
            make.width.equalTo(imgWidth)
        }
        imgForUpload2.snp.makeConstraints { make in
            make.centerY.equalTo(imgForUpload.snp.centerY)
            make.leading.equalTo(imgUploadButton.snp.trailing).offset(10)
            make.height.equalTo(71)
            make.width.equalTo(imgWidth)
        }
    }
    

    func inOutCategory() {
        if categoryCollectionView.isHidden {
            dropDownButton.setImage(UIImage(named: "dropUpButton"), for: .normal)
            deliveryFeeTextField.snp.remakeConstraints { make in
                make.top.equalTo(categoryCollectionView.snp.bottom).offset(12)
                make.leading.equalTo(deliveryFeeLabel.snp.trailing)
                make.trailing.equalToSuperview().offset(-20)
                make.height.equalTo(36)
            }
        } else {
            dropDownButton.setImage(UIImage(named: "dropDownButton"), for: .normal)
            deliveryFeeTextField.snp.remakeConstraints { make in
                make.top.equalTo(categoryTextField.snp.bottom).offset(12)
                make.leading.equalTo(deliveryFeeLabel.snp.trailing)
                make.trailing.equalToSuperview().offset(-20)
                make.height.equalTo(36)
            }
        }
        
        categoryCollectionView.isHidden = !categoryCollectionView.isHidden
    }
    
    
    @objc func handleDatePicker(_ sender: UIDatePicker) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "a h 시 m 분"
        let dateString = dateFormatter.string(from: sender.date)
        milliseconds = Int(sender.date.timeIntervalSince1970)
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
        
        if sender.state == .began {
            
            marker.mapView = nil
            
            let coord = sender.location(in: mapView)
            let latlng = mapView.projection.latlng(from: coord)
            print(latlng)
            
            marker.position.lat = latlng.lat
            marker.position.lng = latlng.lng
            marker.mapView = mapView
            print("위치 변경")
        }
    }
    
    @objc func post() {
        
        print("post")
        
        if let title = titleTextField.text, let store = storeTextField.text, let category = categoryTextField.text, let deliveryFee = deliveryFeeTextField.text, let targetPrice = deliveryAimTextField.text, let content = contentTextView.text, let targetTime = milliseconds, let data = imgForUpload.image?.jpegData(compressionQuality: 1)
 {
            
            apiManager.requestpostRecruiting(title: title, storeName: store, content: content, targetPrice: Int(targetPrice)!, deliveryPrice: Int(deliveryFee)!, longitude: coordinate.lng, latitude: coordinate.lat, category: category, targetTime: targetTime) { [weak self] result in
                switch result {
                case .success(let response):
                    self?.presentAlert(title: "post 성공: \(response.postId)")
                case .failure(let err):
                    print(err)
                }
            }
        } else {
            self.presentAlert(title: "누락된 정보가 있습니다.")
        }
    }
}
extension PostRecruitingViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        // replacementString : 방금 입력된 문자 하나, 붙여넣기 시에는 붙여넣어진 문자열 전체
        // return -> 텍스트가 바뀌어야 한다면 true, 아니라면 false
        // 이 메소드 내에서 textField.text는 현재 입력된 string이 붙기 전의 string
        
        if textField == deliveryFeeTextField {
            let formatter = NumberFormatter()
            formatter.numberStyle = .decimal // 1,000,000
            formatter.locale = Locale.current
            formatter.maximumFractionDigits = 0 // 허용하는 소숫점 자리수
            
            // formatter.groupingSeparator // .decimal -> ,
            
            if let removeAllSeprator = textField.text?.replacingOccurrences(of: formatter.groupingSeparator, with: ""){
                var beforeForemattedString = removeAllSeprator + string
                if formatter.number(from: string) != nil {
                    if let formattedNumber = formatter.number(from: beforeForemattedString), let formattedString = formatter.string(from: formattedNumber){
                        textField.text = formattedString
                        return false
                    }
                }else{ // 숫자가 아닐 때
                    if string == "" { // 백스페이스일때
                        let lastIndex = beforeForemattedString.index(beforeForemattedString.endIndex, offsetBy: -1)
                        beforeForemattedString = String(beforeForemattedString[..<lastIndex])
                        if let formattedNumber = formatter.number(from: beforeForemattedString), let formattedString = formatter.string(from: formattedNumber){
                            textField.text = formattedString
                            return false
                        }
                    }else{ // 문자일 때
                        return false
                    }
                }

            }
            
            return true
        }
        
        //다른 textField일 때
        return true
    }
}


extension PostRecruitingViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return tagList.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeue(PostReusable.tagCell, for: indexPath)
        cell.tagLabel.text = tagList[indexPath.row]
        
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

        let label = MainLabel(type: .Point2).then {
            $0.text = tagList[indexPath.item]
            $0.sizeToFit()
        }
        let size = label.frame.size

        return CGSize(width: size.width + 16, height: size.height + 10)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.dequeue(PostReusable.tagCell, for: indexPath)
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
            
//            switch imgSelectNum{
//            case 0:
//                imgForUpload.contentMode = .scaleToFill
//                imgForUpload.image = pickedImage //4
//            case 1:
//                imgForUpload1.contentMode = .scaleToFill
//                imgForUpload1.image = pickedImage //4
//                imgForUpload2.isHidden = false
//                imgUploadButton2.isHidden = false
//            default:
//                imgForUpload2.contentMode = .scaleToFill
//                imgForUpload2.image = pickedImage //4
//            }
        }
        
//        imgSelectNum += 1
        dismiss(animated: true, completion: nil)
    }
        
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
}

extension PostRecruitingViewController: NMFMapViewTouchDelegate {
    func mapView(_ mapView: NMFMapView, didTapMap latlng: NMGLatLng, point: CGPoint) {
        
        print("마커찍기")
        marker.mapView = nil
        
        let newMarker = NMFMarker(position: NMGLatLng(lat: latlng.lat, lng: latlng.lng))
        marker = newMarker
        coordinate.lat = latlng.lat
        coordinate.lng = latlng.lng
        print(coordinate)
        newMarker.iconImage = NMF_MARKER_IMAGE_BLACK
        newMarker.mapView = mapView
        
   }
}

