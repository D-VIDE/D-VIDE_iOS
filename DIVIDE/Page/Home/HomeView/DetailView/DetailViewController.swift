//
//  DetailViewController.swift
//  DIVIDE
//
//  Created by 임우섭 on 2022/08/19.
//

import UIKit
import SnapKit
import Then

class DetailViewController: UIViewController, UIScrollViewDelegate{
    
    // MARK: property
    private let carouselView = UICollectionView(frame: .zero, collectionViewLayout: CarouselLayout()).then{
        let layout = CarouselLayout()
        layout.itemSize = CGSize(width: 301.0 , height: 203.0)
        layout.sideItemScale = 0.8
        layout.spacing = 11
        layout.isPagingEnabled = true
        layout.sideItemAlpha = 0.5
        $0.collectionViewLayout = layout
        $0.backgroundColor = .clear
    }
    
    private var sampleImages = [UIImage]()
    var imageViews = [UIImageView]()
    
    private var pageControl = UIPageControl().then {
        $0.pageIndicatorTintColor = .lightGray
        $0.currentPageIndicatorTintColor = .white
        $0.currentPage = 0
    }
    
    private let topBackground = UIView().then {
        $0.backgroundColor = .mainOrange1
    }
    private let proposerImage = UIImageView().then {
        $0.image = UIImage(named: "logo.png")
        $0.sizeToFit()
        $0.cornerRadius = 20
    }
    lazy var proposerNickName = MainLabel(type: .Basics5).then {
        $0.text = "NICKNAME"
        $0.textColor = .white
    }
    
    private let mainScrollView = UIScrollView().then {
        $0.backgroundColor = .white
        $0.showsVerticalScrollIndicator = false
        
    }
   
    private let informationView = UIView().then {
        $0.backgroundColor = .white
    }
    
    lazy var titleLabel = MainLabel(type: .Big1).then {
        $0.text = "교촌치킨 드실 분~"
        $0.textColor = .black
    }
    
    lazy var dueTimeLabel = MainLabel(type: .Point4).then {
        $0.text = "• 마감 시간"
        $0.textColor = .gray3
    }
    lazy var dueTime = MainLabel(type: .Point4).then {
        $0.text = "04:00"
        $0.textColor = .gray3
    }
    lazy var AMPM = MainLabel(type: .Basics2).then {
        $0.text = "PM"
        $0.textColor = .unitGray
    }
    
    
    lazy var deliveryFeeLabel = MainLabel(type: .Point4).then {
        $0.text = "• 배달비"
        $0.textColor = .gray3
    }
    lazy var deliveryFee = MainLabel(type: .Point4).then {
        $0.text = "30,000"
        $0.textColor = .gray3
    }
    lazy var deliveryFeeUnitLabel = MainLabel(type: .Basics2).then {
        $0.text = "원"
        $0.textColor = .unitGray
    }
    
    lazy var deliveryAimMoneyLabel = MainLabel(type: .Point4).then {
        $0.text = "• 목표 주문 금액"
        $0.textColor = .gray3
    }
    lazy var deliveryAimMoney = MainLabel(type: .Big1).then {
        $0.text = "30,000"
        $0.textColor = .mainOrange1
    }
    lazy var aimUnitLabel = MainLabel(type: .Basics2).then {
        $0.text = "원"
        $0.textColor = .unitGray
    }
    
    
    lazy var presentOrderMoneyLabel = MainLabel(type: .Point4).then {
        $0.text = "• 현재 주문 금액"
        $0.textColor = .gray3
    }
    lazy var presentOrderMoney = MainLabel(type: .Big1).then {
        $0.text = "16,000"
        $0.textColor = .mainOrange1
    }
    lazy var presentUnitLabel = MainLabel(type: .Basics2).then {
        $0.text = "원"
        $0.textColor = .unitGray
    }
    
    private let progressBarBackground = UIView().then {
        $0.backgroundColor = .gray
        $0.cornerRadius = 8
    }
    
    private var progressBar = UIView().then {
        $0.backgroundColor = .mainOrange2
        $0.cornerRadius = 8
    }
    
    lazy var contentLabel  = MainLabel(type: .Point4).then {
        $0.text = "• 내용"
    }
    
    lazy var content = MainLabel(type: .Basics4).then {
        $0.backgroundColor = .blue
    }
    
    lazy var placeLabel = MainLabel(type: .Point4).then {
        $0.text = "• 장소"
    }
    
    let imgScreenViewWidth = UIScreen.main.bounds.width * ( 302 / UIScreen.main.bounds.width)
    let imgScreenViewHeight = UIScreen.main.bounds.width * ( 302 / UIScreen.main.bounds.width) * 213 / 302
    
    // MARK: viewLoaded
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setBackground()
        getResizedImages()
        setPageControl()
        setInformationView()
        setComponentsConstraints()
        
        self.carouselView.delegate = self
        self.carouselView.dataSource = self
        self.carouselView.register(CarouselCell.self, forCellWithReuseIdentifier: "CarouselCell")
    }
    
    
    func setBackground() {
        self.view.backgroundColor = .white
        
        self.view.addSubview(topBackground)
        self.view.addSubview(mainScrollView)
        
        
        topBackground.snp.makeConstraints { make in
            make.width.equalToSuperview()
            make.height.equalTo(55)
            make.top.equalToSuperview().offset(40)
            make.centerX.equalToSuperview()
        }
        mainScrollView.snp.makeConstraints { make in
            make.height.equalToSuperview()
            make.width.equalToSuperview()
            make.leading.equalToSuperview()
            make.top.equalToSuperview().offset(95)
        }
        
        mainScrollView.addSubview(carouselView)
        
        carouselView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview()
            make.height.equalTo(233)
            make.width.equalToSuperview()
        }
        
    }
    
    func getResizedImages() {
        let targetWidth = 301.0
        let targetHeight = 213.0
        
        let getImage = [resizeImage(image: UIImage(named: "pizzaImage.jpg")!, width: targetWidth, height: targetHeight),
                        resizeImage(image: UIImage(named: "HomeBackgroundImage.png")!, width: targetWidth, height: targetHeight),
                        resizeImage(image: UIImage(named: "pizzaImage.jpg")!, width: targetWidth, height: targetHeight)]
        var countNum = 0
        getImage.forEach { image in
            sampleImages.append(image)
            countNum += 1
        }
        print("sampleImage is successfully resized and appended.")
    }
    
    func resizeImage(image: UIImage, width: CGFloat, height: CGFloat) -> UIImage {
         UIGraphicsBeginImageContext(CGSize(width: width, height: height))
         image.draw(in: CGRect(x: 0, y: 0, width: width, height: height))
         let newImage = UIGraphicsGetImageFromCurrentImageContext()
         UIGraphicsEndImageContext()
         return newImage!
     }

    private func setPageControl() {
        self.view.addSubview(pageControl)
        pageControl.hidesForSinglePage = true
        pageControl.numberOfPages = sampleImages.count
        pageControl.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalTo(carouselView).offset(-12)
        }
    }
   
    
    func scrollViewDidScroll(_ imageScrollView: UIScrollView) {
        let value = imageScrollView.contentOffset.x/imageScrollView.frame.size.width
        pageControl.currentPage =  Int(round(value))
        
    }
    
    func setComponentsConstraints() {
        self.view.addSubview(proposerImage)
        self.view.addSubview(proposerNickName)
        
        
        self.proposerImage.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(50)
            make.leading.equalToSuperview().offset(35)
            make.width.equalTo(37)
            make.height.equalTo(38)
        }
        self.proposerNickName.snp.makeConstraints { make in
            make.top.equalTo(proposerImage)
            make.leading.equalTo(proposerImage).offset(44)
            make.width.equalTo(150)
            make.height.equalTo(38)
            
        }
        
        self.navigationController?.navigationBar.tintColor = .white
        
    }

    func setInformationView() {
        mainScrollView.addSubview(informationView)
        
        informationView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(233)
            make.width.equalToSuperview()
            make.height.greaterThanOrEqualToSuperview()
        }
        
        informationView.addSubview(titleLabel)
        informationView.addSubview(dueTimeLabel)
        informationView.addSubview(dueTime)
        informationView.addSubview(AMPM)
        informationView.addSubview(deliveryFeeLabel)
        informationView.addSubview(deliveryFee)
        informatio  nView.addSubview(deliveryFeeUnitLabel)
        informationView.addSubview(deliveryAimMoneyLabel)
        informationView.addSubview(deliveryAimMoney)
        informationView.addSubview(aimUnitLabel)
        informationView.addSubview(presentOrderMoneyLabel)
        informationView.addSubview(presentOrderMoney)
        informationView.addSubview(presentUnitLabel)
        informationView.addSubview(progressBarBackground)
        informationView.addSubview(progressBar)
        informationView.addSubview(contentLabel)
        informationView.addSubview(content)
        informationView.addSubview(placeLabel)
        
        
        self.titleLabel.snp.makeConstraints { make in
            make.width.equalTo(171)
            make.height.equalTo(32)
            make.top.equalToSuperview().offset(30)
            make.leading.equalToSuperview().offset(25)
        }
        self.dueTimeLabel.snp.makeConstraints { make in
            make.width.equalTo(89)
            make.height.equalTo(23)
            make.top.equalToSuperview().offset(90)
            make.leading.equalToSuperview().offset(30)
        }
        
        self.dueTime.snp.makeConstraints { make in
            make.width.equalTo(54)
            make.height.equalTo(23)
            make.trailing.equalToSuperview().offset(-30)
            make.top.equalToSuperview().offset(90)
        }
        
        self.AMPM.snp.makeConstraints { make in
            make.width.equalTo(29)
            make.height.equalTo(21)
            make.trailing.equalToSuperview().offset(-7)
            make.top.equalToSuperview().offset(92)
        }
        
        self.deliveryFeeLabel.snp.makeConstraints { make in
            make.width.equalTo(60)
            make.height.equalTo(23)
            make.leading.equalTo(dueTimeLabel)
            make.top.equalTo(dueTimeLabel).offset(35)
        }
        
        self.deliveryFee.snp.makeConstraints { make in
            make.width.equalTo(63)
            make.height.equalTo(23)
            make.trailing.equalTo(dueTime)
            make.centerY.equalTo(deliveryFeeLabel)
        }
        
        self.deliveryFeeUnitLabel.snp.makeConstraints { make in
            make.width.equalTo(12)
            make.height.equalTo(21)
            make.trailing.equalToSuperview().offset(-18)
            make.centerY.equalTo(deliveryFee)
        }
        
        self.deliveryAimMoneyLabel.snp.makeConstraints { make in
            make.width.equalTo(107)
            make.height.equalTo(23)
            make.leading.equalTo(deliveryFeeLabel)
            make.top.equalTo(deliveryFeeLabel).offset(46)
        }
        
        self.deliveryAimMoney.snp.makeConstraints { make in
            make.width.equalTo(86)
            make.height.equalTo(32)
            make.trailing.equalTo(deliveryFee).offset(5)
            make.centerY.equalTo(deliveryAimMoneyLabel)
        }
        
        self.aimUnitLabel.snp.makeConstraints { make in
            make.width.equalTo(12)
            make.height.equalTo(21)
            make.trailing.equalTo(deliveryFeeUnitLabel)
            make.centerY.equalTo(deliveryAimMoney).offset(2)
        }
        
        self.presentOrderMoneyLabel.snp.makeConstraints { make in
            make.width.equalTo(deliveryAimMoneyLabel)
            make.height.equalTo(deliveryAimMoneyLabel)
            make.trailing.equalTo(deliveryAimMoneyLabel)
            make.top.equalTo(deliveryAimMoneyLabel).offset(37)
        }
        
        self.presentOrderMoney.snp.makeConstraints { make in
            make.width.equalTo(deliveryAimMoney)
            make.height.equalTo(deliveryAimMoney)
            make.leading.equalTo(deliveryAimMoney)
            make.centerY.equalTo(presentOrderMoneyLabel)
        }
        
        self.presentUnitLabel.snp.makeConstraints { make in
            make.width.equalTo(aimUnitLabel)
            make.height.equalTo(aimUnitLabel)
            make.trailing.equalTo(aimUnitLabel)
            make.centerY.equalTo(presentOrderMoney).offset(2)
        }
        
        self.progressBarBackground.snp.makeConstraints { make in
            make.width.equalTo(320)
            make.height.equalTo(16)
            make.centerX.equalToSuperview()
            make.top.equalTo(presentOrderMoneyLabel).offset(40)
        }
        
        self.progressBar.snp.makeConstraints { make in
            make.width.equalTo(150)
            make.height.equalTo(16)
            make.leading.equalTo(progressBarBackground)
            make.top.equalTo(progressBarBackground)
        }
        
        self.contentLabel.snp.makeConstraints { make in
            make.width.equalTo(40)
            make.height.equalTo(23)
            make.leading.equalTo(presentOrderMoneyLabel)
            make.top.equalTo(presentOrderMoneyLabel).offset(71)
        }
        
        self.content.snp.makeConstraints { make in
            make.leading.equalTo(contentLabel).offset(10)
            make.top.equalTo(contentLabel).offset(39)
            make.width.equalTo(288)
            make.height.equalTo(20)
        }
        
        self.placeLabel.snp.makeConstraints { make in
            make.width.equalTo(40)
            make.height.equalTo(23)
            make.leading.equalTo(presentOrderMoneyLabel)
            make.top.equalTo(content).offset(124)
        }
    }

}

extension DetailViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
           
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CarouselCell", for: indexPath) as? CarouselCell else { return UICollectionViewCell() }
        return cell
    }
    
    
}
