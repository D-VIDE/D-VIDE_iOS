//
//  ViewController.swift
//  DIVIDE
//
//  Created by 정지윤 on 2022/06/28.
//

import UIKit
import Then
import SnapKit
import Moya
import RxCocoa
import RxSwift
import CoreLocation

class HomeViewController: UIViewController {
    private var disposeBag = DisposeBag()
    
    private var viewModel =  ShowAroundPosts()
    
    let dateFormatter = DateFormatter().then{
        $0.dateFormat = "H:mm"
    }
    
    var realTime = Int(Date().timeIntervalSince1970)
    private let userPosition = UserPositionModel(longitude: 127.030767490, latitude: 37.49015482509)
    
    private let searchBtn = UIButton().then{
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.setImage(#imageLiteral(resourceName: "Search.png"), for: .normal)// 이미지 넣기
        $0.imageView?.contentMode = .scaleAspectFit
        $0.contentHorizontalAlignment = .center
        $0.semanticContentAttribute = .forceRightToLeft //<- 중요
    }
    private let topMenuBar = UIView().then{
        $0.backgroundColor = .none
    }
    
    private let backgroundImage = UIImageView().then{
        $0.image = UIImage(named: "HomeBackgroundImage")
        $0.backgroundColor = .orange
    }
    let menuList: [String] = ["분식", "KOREAN_FOOD", "양식", "일식", "디저트", "---", "------" ]
    let categoryName : [String] = ["KOREAN_FOOD", "CHINESE_FOOD", ]
    private let topMenuCollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout()).then{
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        $0.backgroundColor = .white
        $0.contentInset = UIEdgeInsets.init(top: 0, left: 20, bottom: 0, right: 0)
        $0.showsHorizontalScrollIndicator = false
        $0.collectionViewLayout = layout
    }
    
    lazy var tableView: UITableView = {
        
        let tableview = UITableView()
        tableview.backgroundColor = .viewBackgroundGray
        tableview.showsVerticalScrollIndicator = false
        return tableview

    }()
    let DVIDEBtn = MainButton(type: .mainAction).then {
        $0.setTitle("지금 D/VIDE 하기", for: .normal)
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.cornerRadius = 15
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        topMenuCollectionView.delegate = self
        topMenuCollectionView.dataSource = self
        topMenuCollectionView.register(HomeTopMenuCell.self, forCellWithReuseIdentifier: HomeTopMenuCell.identifier)
        tableView.register(HomeTableViewCell.self, forCellReuseIdentifier: "HomeTableViewCell")
        bindTableView()
        
        setHomeViewConstraint()
        
        setTopMenuBar()
        setTopMenuCollection()
        
        setTableViewConstraint()
        setDVIDEBtn()
        
    }
    func changePositionToLocation(latitude: Double, longitude: Double) -> String {
        var result : String = ""
        let location = CLLocation(latitude: latitude, longitude: longitude)
        let geocoder = CLGeocoder()
        let locale = Locale(identifier: "Ko-kr")
        geocoder.reverseGeocodeLocation(location, preferredLocale: locale) { (placemarks, error) in
            if let address: [CLPlacemark] = placemarks {
                print("address : \(address.last?.administrativeArea as Any)")
                result = (address.last?.administrativeArea)!
            }
        }

        return result
    }
    
    func bindTableView(){
        tableView.rx.setDelegate(self).disposed(by: disposeBag)
        viewModel.requestAroundPosts(param: userPosition)
            .asObservable()
            .bind(to: tableView.rx.items(cellIdentifier: "HomeTableViewCell", cellType: HomeTableViewCell.self)) { (row, item, cell) in
                cell.img.image = UIImage(named: "logo.png")
//                cell.userLocation.text = self.changePositionToLocation(latitude: item.post.latitude, longitude: item.post.longitude)
                cell.userName.text = String(item.user.id)
                cell.title.text = item.post.title
                cell.remainTimeUnderOneHour.text = self.calculatedRemainTime(targetTime: item.post.targetTime)
                cell.closingTimeValue.text = self.setAMPMTime(closingTime: item.post.targetTime)
                cell.AMPMLabel.text = self.setAMPM(closingTime: item.post.targetTime)
                cell.insufficientChargeValueLabel.text = String(item.post.targetPrice).insertComma
            }.disposed(by: disposeBag)
    }
    
    private func calculatedRemainTime(targetTime : Int) -> String {
        let remainTime = targetTime - Int(Date().timeIntervalSince1970)
        if remainTime > 86400 {
            return "D - 1 이후 주문예정"
        } else if remainTime > 3600 {
            return String(remainTime / 3600) + " 시간 " + String(remainTime % 3600 / 60) + "분 후 주문 예정"
        } else if remainTime > 0 {
            return String(remainTime / 60)
        } else {
            return "주문 시간이 지났습니다"
        }
    }
    private func setAMPMTime(closingTime: Int) -> String{
        if (closingTime % 1440) / 60 == 12 {
            return String((closingTime % 1440) / 60) + ":" + String(closingTime % 60)
        } else if (closingTime % 1440) / 60 > 12 {
            return String((closingTime % 1440) / 60 - 12) + ":" + String(closingTime % 60)
        } else {
            return String((closingTime % 1440) / 60) + ":" + String(closingTime % 60)
        }
    }
    private func setAMPM(closingTime: Int) -> String {
        if (closingTime % 1440) / 60 == 12 {
            return "PM"
        } else if (closingTime % 1440) / 60 > 12 {
            return "PM"
        } else {
            return "AM"
        }
    }
    private func setHomeViewConstraint() {
        self.view.backgroundColor = .viewBackgroundGray
    }
    
    private func setTopMenuBar() {
        self.view.addSubview(topMenuBar)
        topMenuBar.backgroundColor = .white
        topMenuBar.addSubview(searchBtn)
        topMenuBar.snp.makeConstraints { make in
            make.leading.equalToSuperview()
            make.top.equalToSuperview()
            make.trailing.equalToSuperview()
            make.height.equalTo(113)
        }
        
        //그림자
        topMenuBar.roundCorners(cornerRadius: 26, maskedCorners: [.layerMinXMaxYCorner, .layerMaxXMaxYCorner])
        topMenuBar.layer.shadowPath = UIBezierPath(rect: CGRect(x: 0, y: 1, width: topMenuBar.intrinsicContentSize.width, height: topMenuBar.intrinsicContentSize.height)).cgPath
        topMenuBar.layer.shadowOpacity = 0.15
        
        searchBtn.snp.makeConstraints { make in
            make.width.equalTo(20)
            make.height.equalTo(20)
            make.top.equalToSuperview().offset(48)
            make.trailing.equalToSuperview().offset(-40)
        }
    }
    private func setTopMenuCollection() {
        topMenuBar.addSubview(topMenuCollectionView)
        topMenuCollectionView.snp.makeConstraints { make in
            make.width.equalToSuperview()
            make.height.equalTo(40)
            make.leading.equalToSuperview()
            make.bottom.equalToSuperview()
        }
    }
    
    private func setTableViewConstraint() {
        self.view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
            make.top.equalToSuperview().offset(113)
            make.bottom.equalToSuperview()
        }
        
    }
    private func setTableViewBackground() {
        tableView.addSubview(backgroundImage)
        backgroundImage.snp.makeConstraints { make in
            make.bottom.equalToSuperview()
            make.trailing.equalToSuperview()
            make.leading.equalToSuperview()
            make.height.equalTo(300)
        }
    }
    
    private func setDVIDEBtn() {
        view.addSubview(DVIDEBtn)
        DVIDEBtn.snp.makeConstraints { make in
            make.width.equalTo(350)
            make.height.equalTo(50)
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview().offset(-90)
        }
    }
}

//컬렉션
extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        menuList.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HomeTopMenuCell.identifier, for: indexPath) as? HomeTopMenuCell else { return UICollectionViewCell() }
        cell.menuLabel.text = menuList[indexPath.row]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let label = UILabel().then {
            $0.font = .systemFont(ofSize: 12, weight: .bold)
            $0.text = menuList[indexPath.item]
            $0.sizeToFit()
        }
        let size = label.frame.size
        
        
        return CGSize(width: size.width+24, height: size.height+10)
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.tableView.delegate = nil
        self.tableView.dataSource = nil
        let selectedCatagory = menuList[indexPath.item]
        tableView.rx.setDelegate(self).disposed(by: disposeBag)
        viewModel.requestAroundPostsWithCategory(param: userPosition, category: selectedCatagory)
            .asObservable()
            .bind(to: tableView.rx.items(cellIdentifier: "HomeTableViewCell", cellType: HomeTableViewCell.self)) { (row, item, cell) in
                cell.img.image = UIImage(named: "logo.png")
//                cell.userLocation.text = self.changePositionToLocation(latitude: item.post.latitude, longitude: item.post.longitude)
                cell.userName.text = String(item.user.id)
                cell.title.text = item.post.title
                cell.remainTimeUnderOneHour.text = self.calculatedRemainTime(targetTime: item.post.targetTime)
                cell.closingTimeValue.text = self.setAMPMTime(closingTime: item.post.targetTime)
                cell.AMPMLabel.text = self.setAMPM(closingTime: item.post.targetTime)
                cell.insufficientChargeValueLabel.text = String(item.post.targetPrice).insertComma
            }.disposed(by: disposeBag)
    }
}

//테이블
extension HomeViewController:  UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "HomeTableViewCell", for: indexPath) as? HomeTableViewCell else { return UITableViewCell() }
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 168
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.navigationController?.navigationBar.topItem?.title = ""
        self.navigationController?.pushViewController(DetailViewController(), animated: true)
        print(indexPath)
        

    }
}


