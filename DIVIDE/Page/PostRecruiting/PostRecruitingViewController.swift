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
import CoreLocation

import RxSwift
import RxCocoa
import RxGesture



enum PostReusable {
    static let tagCell = ReusableCell<TagCollectionViewCell>()
  }


public let imgWidth = (Device.width - 139 - 20) / 3
public let textfieldWidth = Device.width - 139

class PostRecruitingViewController: UIViewController, CLLocationManagerDelegate {
    
    private let navigationView = UIView()

    private let navigationLabel = MainLabel(type: .hopang)
    var tagList: [String] = ["분식", "한식", "일식", "디저트", "양식"]


    let viewModel = PostRecruitingViewModel()
    let apiManager = PostRecruitingAPIManager()
    var disposeBag = DisposeBag()

    // 사진
    var currentTag : Int!
    var imgArray: [UIImage]? = []
    let imgDropDown1 = DropDown()
    let imgDropDown2 = DropDown()
    let imgDropDown3 = DropDown()

    // 시간 milliseconds
    var milliseconds : Int?
   
    // UIScrollView 정의
    lazy var scrollView = UIScrollView()

    lazy var scrollContentView = UIView()

    // 중복 선언
    lazy var navBar = MainNavBar()


    // UILabel 정의
    lazy var titleLabel = MainLabel(type: .Basics5)
    lazy var storeLabel = MainLabel(type: .Basics5)
    lazy var categoryLabel = MainLabel(type: .Basics5)
    lazy var deliveryFeeLabel = MainLabel(type: .Basics5)
    lazy var deliveryFeeUnitLabel = MainLabel(type: .Point2)
    lazy var aimUnitLabel = MainLabel(type: .Point2)
    lazy var deliveryAimMoneyLabel = MainLabel(type: .Basics5)
    lazy var dueTimeLabel = MainLabel(type: .Basics5)
    lazy var photoLabel = MainLabel(type: .Basics5)
    lazy var placeLabel = MainLabel(type: .Basics5)
    lazy var contentLabel = MainLabel(type: .Basics5)

    //UITextField 정의
    lazy var titleTextField = MainTextField(type: .main)
    lazy var storeTextField = MainTextField(type: .main)
    lazy var categoryTextField = MainTextField(type: .main)
    lazy var deliveryFeeTextField = MainTextField(type: .main)
    lazy var deliveryAimTextField = MainTextField(type: .main)
    lazy var dueTimeTextField = MainTextField(type: .main)

    // UICollectionView 정의
    lazy var categoryCollectionView = UICollectionView(frame: .zero, collectionViewLayout: .init())

    //UITextView 정의
    lazy var contentTextView = UITextView()

    

    //UIButton 정의
    lazy var uploadButton =  MainButton(type: .mainAction)

    lazy var dropDownButton = UIButton()

    //StackView 정의
    lazy var imgStackView = UIStackView()


    // UIImageView 선언
    lazy var imgForUpload1 = CustomImageView()
    lazy var imgForUpload2 = CustomImageView()
    lazy var imgForUpload3 = CustomImageView()

    // Location
    
    var locationManager = CLLocationManager()
    
    // Naver Maps
    lazy var mapView = NMFMapView(frame: view.frame)
    let cameraPos = NMFCameraPosition()
    private let markerImg = UIImageView()
    private let markerPointer = UIImageView()
    //DatePicker 정의
    lazy var datePicker = UIDatePicker()

    var isContentTextViewTapped = PublishRelay<Bool>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setAttributes()
        addView()
        setLayout()
        
        categoryCollectionView.delegate = self
        categoryCollectionView.dataSource = self
 
        dueTimeTextField.inputView = datePicker
        categoryCollectionView.isHidden = true


        initDropDown(dropDown: imgDropDown1, anchor: imgForUpload1)
        initDropDown(dropDown: imgDropDown2, anchor: imgForUpload2)
        initDropDown(dropDown: imgDropDown3, anchor: imgForUpload3)
        
        setLocation()
        bind()
    }
    
    
    func setAttributes() {
        view.backgroundColor = .viewBackgroundGray
        // 상단 메뉴 바 설정
        navigationView.do {
            $0.backgroundColor = .white
            $0.layer.addBorder([.bottom], color: .borderGray, width: 1)
            $0.layer.cornerRadius = 18
            $0.layer.maskedCorners = CACornerMask(arrayLiteral: .layerMaxXMaxYCorner, .layerMinXMaxYCorner)
            $0.layer.addShadow(location: .bottom)
        }
        navigationLabel.do {
           $0.text = "D/VIDE 모집글 작성"
        }
        
        scrollView.do {
            $0.backgroundColor = .viewBackgroundGray
            $0.showsVerticalScrollIndicator = false
            $0.showsHorizontalScrollIndicator = false
        }
        scrollContentView.do {
            $0.backgroundColor = .viewBackgroundGray
        }
        navBar.do {
            $0.backgroundColor = .white
        }
        
        // Label
        titleLabel.do {
            $0.text = "• 제목"
        }
        storeLabel.do {
            $0.text = "• 가게 이름"
        }
        categoryLabel.do {
            $0.text = "• 카테고리"
        }
        deliveryFeeLabel.do {
            $0.text = "• 배달비"
        }
        deliveryFeeUnitLabel.do {
            $0.text = "원"
            $0.textColor = .unitGray
        }
        aimUnitLabel.do {
            $0.text = "원"
            $0.textColor = .unitGray
        }
        deliveryAimMoneyLabel.do {
            $0.text = "• 목표 금액"
        }
        dueTimeLabel.do {
            $0.text = "• 마감 시간"
        }
        photoLabel.do {
            $0.text = "• 사진"
        }
        placeLabel.do {
            $0.text = "• 장소"
        }
        contentLabel.do {
            $0.text = "• 내용"
        }
        
        // UITextField
        
        titleTextField.do {
            $0.textFieldTextChanged($0)
            $0.resignFirstResponder()
        }
        storeTextField.do {
            $0.textFieldTextChanged($0)
            $0.resignFirstResponder()
        }
        categoryTextField.do {
            $0.isUserInteractionEnabled = false
            $0.resignFirstResponder()
        }
        deliveryFeeTextField.do {
            $0.textFieldTextChanged($0)
            $0.keyboardType = .numberPad
            $0.delegate = self
            $0.resignFirstResponder()
        }
        deliveryAimTextField.do {
            $0.textFieldTextChanged($0)
            $0.keyboardType = .numberPad
            $0.delegate = self
            $0.resignFirstResponder()
        }
        dueTimeTextField.do {
            $0.textFieldTextChanged($0)
            $0.inputView = datePicker
            $0.resignFirstResponder()
        }
        
        // UICollectionView
        categoryCollectionView.do {
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
        
        //UITextView
        
        contentTextView.do {
            $0.textContainerInset = UIEdgeInsets(top: 18.0, left: 18.0, bottom: 18.0, right: 18.0)
            $0.backgroundColor = .white
            $0.layer.cornerRadius = 18
            $0.layer.maskedCorners = CACornerMask(arrayLiteral: .layerMaxXMinYCorner, .layerMaxXMaxYCorner)
            $0.layer.addShadow(location: .all)
            $0.font = UIFont.NotoSansKR(.medium, size: 15)
        }
        
        
        
        // UIButton
        
        uploadButton.do {
            $0.setTitle("업로드 하기", for: .normal)
            $0.addTarget(self, action: #selector(post), for: .touchUpInside)
        }
        dropDownButton.do {
            $0.setImage(UIImage(named: "dropDownButton"), for: .normal)
            $0.layer.cornerRadius = 18
            $0.addTarget(self, action: #selector(showCategory), for: .touchUpInside)
        }
        // StackView
        imgStackView.do {
            $0.axis = .horizontal
    //        $0.alignment = .fill
            $0.distribution = .equalSpacing
            $0.spacing = 10
        }
        
        // UIImageView
        imgForUpload1.do {
            $0.image = UIImage(named: "defaultPhoto")
            $0.clipsToBounds = true
            $0.layer.cornerRadius = 13
            $0.setOnEventListener { gesture in
                self.currentTag = 0
                if type(of: gesture) == UITapGestureRecognizer.self {
                    print("photo selected")
                    let imagePicker = UIImagePickerController()
                    imagePicker.sourceType = .photoLibrary
                    imagePicker.delegate = self //3
                    self.present(imagePicker, animated: true)
                } else {
                    print("LongPressed")
                    self.imgDropDown1.show()
                }
            }
            $0.isUserInteractionEnabled = false
        }
        imgForUpload2.do {
            $0.image = UIImage(named: "selectPhoto")
            $0.clipsToBounds = true
            $0.layer.cornerRadius = 13

            $0.setOnEventListener { gesture in
                self.currentTag = 1
                if type(of: gesture) == UITapGestureRecognizer.self {
                    print("photo selected")
                    let imagePicker = UIImagePickerController()
                    imagePicker.sourceType = .photoLibrary
                    imagePicker.delegate = self //3
                    // imagePicker.allowsEditing = true
                    self.present(imagePicker, animated: true)
                } else {
                    print("LongPressed")
                    self.imgDropDown2.show()
                }
            }
        }
        imgForUpload3.do {
            $0.image = UIImage(named: "selectPhoto")
            $0.clipsToBounds = true
            $0.layer.cornerRadius = 13

            $0.setOnEventListener { gesture in
                self.currentTag = 2
                if type(of: gesture) == UITapGestureRecognizer.self {
                    print("photo selected")
                    let imagePicker = UIImagePickerController()
                    imagePicker.sourceType = .photoLibrary
                    imagePicker.delegate = self //3
                    // imagePicker.allowsEditing = true
                    self.present(imagePicker, animated: true)
                } else {
                    print("LongPressed")
                    self.imgDropDown3.show()
                }
            }
        }
        
        // Map 관련
        mapView.do {
            $0.backgroundColor = .white
            $0.layer.cornerRadius = 18
            $0.clipsToBounds = true
            $0.layer.maskedCorners = CACornerMask(arrayLiteral: .layerMaxXMinYCorner, .layerMaxXMaxYCorner)
            $0.layer.addShadow(location: .all)
        }
        markerImg.do {
            $0.image = UIImage(named: "mSNormalBlue.png")
        }
        markerPointer.do {
            $0.image = UIImage(named: "pointer.png")
        }
        
        // DatePicker
        datePicker.do {
            $0.preferredDatePickerStyle = .wheels
            $0.minimumDate = .now
            $0.minuteInterval = 5
            $0.datePickerMode = .time
            $0.locale = Locale(identifier: "ko-KR")
            $0.timeZone = .autoupdatingCurrent
            $0.addTarget(self, action: #selector(handleDatePicker(_:)), for: .valueChanged)
        }
        
    } // then
    
    func addView() {
        view.addSubview(scrollView)
        view.addSubview(navigationView)
        
        navigationView.addSubview(navigationLabel)
        scrollView.addSubview(scrollContentView)
        
        //UILabel add
        scrollContentView.addSubviews([titleLabel, storeLabel, deliveryFeeLabel, deliveryAimMoneyLabel, dueTimeLabel, placeLabel, contentLabel, categoryLabel, photoLabel])
        deliveryFeeTextField.addSubview(deliveryFeeUnitLabel)
        deliveryAimTextField.addSubview(aimUnitLabel)
        
        //UITextField add
        scrollContentView.addSubviews([categoryCollectionView, titleTextField, storeTextField, categoryTextField, deliveryFeeTextField, deliveryAimTextField, dueTimeTextField])

        // UIView add
        scrollContentView.addSubviews([contentTextView, mapView])
        
        // MapView's subView
        mapView.addSubviews([markerImg, markerPointer])
        
        //UIButton add
        scrollContentView.addSubviews([uploadButton, dropDownButton])
        
        //UIImageView add
        scrollContentView.addSubview(imgStackView)
        [imgForUpload1, imgForUpload2].forEach { img in
            imgStackView.addArrangedSubview(img)
        }
        

    } // self.addSubview...
    func setLayout() {
        navigationView.snp.makeConstraints { make in
            make.height.equalTo(100)
            make.top.equalToSuperview()
            make.leading.trailing.equalToSuperview()
        }
        navigationLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalTo(navigationView.snp.bottom).offset(-20)
        }
        // ScrollView
        scrollView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(100)
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
            make.top.equalTo(imgForUpload1.snp.top)
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


        //MapView
        mapView.snp.makeConstraints { make in
            make.top.equalTo(imgForUpload1.snp.bottom).offset(17)
            make.leading.equalTo(placeLabel.snp.trailing)
            make.trailing.equalToSuperview().offset(-20)
            make.height.equalTo(178)
        }
        markerImg.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview().offset(-25)
            make.height.equalTo(50)
            make.width.equalTo(35)
        }
        markerPointer.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.width.equalTo(20)
            make.height.equalTo(20)
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




        //UIImageView
        imgStackView.snp.makeConstraints { make in
            make.top.equalTo(dueTimeTextField.snp.bottom).offset(17)
            make.leading.equalTo(photoLabel.snp.trailing)
//            make.height.equalTo(71)
//            make.trailing.lessThanOrEqualToSuperview().offset(-20)
        }
        imgForUpload1.snp.makeConstraints { make in
            make.height.equalTo(71)
            make.width.equalTo(imgWidth)
        }
        imgForUpload2.snp.makeConstraints { make in
            make.height.equalTo(71)
            make.width.equalTo(imgWidth)
        }
        imgForUpload3.snp.makeConstraints { make in
            make.height.equalTo(71)
            make.width.equalTo(imgWidth)
        }


        
    } // SnapKit
    
    func bind() {
        contentTextView.rx.tapGesture()
            .when(.recognized)
            .subscribe(onNext: { [unowned self] _ in
                self.isContentTextViewTapped.accept(true)
            }).disposed(by: disposeBag)
        
        isContentTextViewTapped
            .subscribe(onNext: { [unowned self] isTapped in
                if isTapped == true {
                    // 화면 올리기
                    print("self.view.frame.origin is : \(self.view.frame.origin)")
                    dismissKeyboardWhenTappedAround()
                    self.view.frame.origin.y -= 150
                } else {
                    self.view.frame.origin.y += 150
                    deleteGeusture()
                }
        }).disposed(by: disposeBag)
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

    func initDropDown(dropDown: DropDown, anchor: UIImageView) {
        dropDown.anchorView = anchor
        dropDown.bottomOffset = CGPoint(x: 0, y:(dropDown.anchorView?.plainView.bounds.height)!)
        dropDown.direction = .bottom

        dropDown.dataSource = ["삭제"]
        dropDown.selectionAction = { [unowned self] (index: Int, item: String) in
            imgArray?.remove(at: currentTag)

            switch imgArray?.count {
            case 2:
                imgForUpload1.image = imgArray?[0]
                imgForUpload2.image = imgArray?[1]
                imgForUpload3.image = UIImage(named: "selectPhoto")
            case 1:
                print("1")
                imgForUpload1.image = imgArray?[0]
                imgForUpload2.image = UIImage(named: "selectPhoto")
                imgStackView.removeArrangedSubview(imgForUpload3)
//                imgForUpload1.isUserInteractionEnabled = false
            default:
                imgForUpload1.image = UIImage(named: "defaultPhoto")
                imgForUpload2.image = UIImage(named: "selectPhoto")
            }


            //선택한 아이템 초기화
            dropDown.clearSelection()
        }
    }
    func setLocation() {
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        if CLLocationManager.locationServicesEnabled() {
            print("위치 서비스 On 상태")
            locationManager.startUpdatingLocation()
            print(locationManager.location?.coordinate)
            
            let cameraUpdate = NMFCameraUpdate(scrollTo: NMGLatLng(lat: locationManager.location?.coordinate.latitude ?? 0, lng: locationManager.location?.coordinate.longitude ?? 0))
            cameraUpdate.animation = .easeIn
            mapView.moveCamera(cameraUpdate)
            
        } else {
            print("위치 서비스 Off 상태")
        }
    }

    @objc func handleDatePicker(_ sender: UIDatePicker) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "a h 시 m 분"
        let dateString = dateFormatter.string(from: sender.date)
        milliseconds = Int(sender.date.timeIntervalSince1970) + 32400
        self.dueTimeTextField.text = dateString
        self.dueTimeTextField.resignFirstResponder()
    }



    @objc func showCategory() {
        inOutCategory()
    }
    
    @objc func post() {

        print("post")

        // Check 1: 있는지 없는지
        if let title = titleTextField.text, let store = storeTextField.text, let category = categoryTextField.text, let deliveryFee = deliveryFeeTextField.text, let targetPrice = deliveryAimTextField.text, let content = contentTextView.text, let targetTime = milliseconds {

            var imgList : [Data] = []
            imgArray?.forEach({ img in
                if let jpegImg = img.jpegData(compressionQuality: 0.5) {
                    imgList.append(jpegImg)
                    print("img List is : \(imgList)")
                } else {
                    print("사진 변환 오류")
                    return
                }
            })

            // Check 2: 타입에 맞게 변환
            // 일단은 KOREAN_FOOD만 넣어놓음
            let inputData = PostRecruitingInput(title: title,
                                                storeName: store,
                                                content: content,
                                                targetPrice: Int(deliveryFee.split(separator: ",").joined())!,
                                                deliveryPrice: Int(targetPrice.split(separator: ",").joined())!,
                                                longitude: mapView.cameraPosition.target.lng,
                                                latitude: mapView.cameraPosition.target.lat,
                                                category: "KOREAN_FOOD",
                                                targetTime: targetTime)

            apiManager.requestpostRecruiting(param: inputData, img: imgList) { [weak self] result in
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

        if textField == deliveryFeeTextField || textField == deliveryAimTextField {
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
        
        categoryTextField.text = tagList[indexPath.row]
        inOutCategory()
    }
}


extension PostRecruitingViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let pickedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {

            //img 변경
            if imgArray?.count == 3 {
                imgArray?[currentTag] = pickedImage
                switch currentTag{
                case 0:
                    imgForUpload1.contentMode = .scaleToFill
                    imgForUpload1.image = imgArray?[0] //4
                case 1:
                    imgForUpload2.contentMode = .scaleToFill
                    imgForUpload2.image = imgArray?[1] //4
                default:
                    imgForUpload3.contentMode = .scaleToFill
                    imgForUpload3.image = imgArray?[2] //4
                }
            } else {
                //img 추가
                imgArray?.append(pickedImage)

                switch imgArray?.count{
                case 1:
                    imgForUpload1.contentMode = .scaleToFill
                    imgForUpload1.image = pickedImage //4
                case 2:
                    imgForUpload2.contentMode = .scaleToFill
                    imgForUpload2.image = pickedImage //4
                    imgStackView.addArrangedSubview(imgForUpload3)
                default:
                    imgForUpload3.contentMode = .scaleToFill
                    imgForUpload3.image = pickedImage //4
                    imgForUpload1.isUserInteractionEnabled = true
                }
            }
        }

        dismiss(animated: true, completion: nil)
    }

    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
}

