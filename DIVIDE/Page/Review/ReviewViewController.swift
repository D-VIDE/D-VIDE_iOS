//
//  ReviewViewController.swift
//  DIVIDE
//
//  Created by 임우섭 on 2022/12/22.
//

import UIKit
import Moya
import SnapKit
import Then
import RxCocoa
import RxSwift
import RxDataSources

class ReviewViewController: UIViewController {
    
    private var disposeBag = DisposeBag()
    private var viewModel =  ShowAroundReviews()
    private let userPosition = UserPositionModel(longitude: 127.030767490, latitude: 37.49015482509)

    //상단
    private let topTitleView = UIView()
    private let reviewTitleImg = UIImageView()
    private let reviewSearchBtn = UIButton()
    
    
    //tableView
    private let reviewTableView = UITableView()
    private var allReviewDataFromServer = [ReviewData]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setAttribute()
        addView()
        setLayout()
        reviewTableView.register(ReviewRecommendTableViewCell.self, forCellReuseIdentifier: "ReviewRecommendTableViewCell")
        reviewTableView.register(ReviewTableViewCell.self, forCellReuseIdentifier: "ReviewTableViewCell")
        bindTableView()
        
    }
    
    private func setAttribute() {
        self.view.backgroundColor = .viewBackgroundGray
        topTitleView.do {
            $0.backgroundColor = .white
            $0.layer.addBorder([.bottom], color: .borderGray, width: 1)
            $0.layer.cornerRadius = 18
            $0.layer.maskedCorners = CACornerMask(arrayLiteral: .layerMaxXMaxYCorner, .layerMinXMaxYCorner)
            $0.layer.addShadow(location: .bottom)
        }
        reviewTitleImg.do {
            $0.image = UIImage(named: "ReviewTitle.png")
        }
        reviewSearchBtn.do {
            $0.setImage(UIImage(named: "Search.png"), for: .normal)
        }
        
        
        reviewTableView.do {
            $0.showsVerticalScrollIndicator = false
            $0.backgroundColor = .viewBackgroundGray
        }
        
    }
    private func addView() {
        self.view.addSubview(topTitleView)
        topTitleView.addSubviews([reviewTitleImg, reviewSearchBtn])
        
        self.view.addSubview(reviewTableView)
    }
    private func setLayout() {
        topTitleView.snp.makeConstraints { make in
            make.height.equalTo(113)
            make.leading.trailing.equalToSuperview()
            make.top.equalToSuperview()
        }
        reviewTitleImg.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview().offset(15)
            make.height.equalTo(28.7)
            make.width.equalTo(127.37)
        }
        reviewSearchBtn.snp.makeConstraints { make in
            make.width.equalTo(20)
            make.height.equalTo(20)
            make.top.equalToSuperview().offset(65)
            make.trailing.equalToSuperview().offset(-30)
        }
        reviewTableView.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
            make.top.equalToSuperview().offset(143)
            make.bottom.equalToSuperview()
        }
        
    }
    private func bindTableView(){
        reviewTableView.rx.setDelegate(self).disposed(by: disposeBag)
        viewModel.requestAroundReviews(param: userPosition)
            .asObservable()
            .bind(to: reviewTableView.rx.items(cellIdentifier: "ReviewTableViewCell", cellType: ReviewTableViewCell.self)) { (row, item, cell) in
                self.allReviewDataFromServer.append(item)
                cell.userImg.load(url: URL(string: item.user.profileImgUrl)!)
                
                cell.userID.text = item.user.nickname
//                cell.userLocation.text = changePositionToLocation(latitude: <#T##Double#>, longitude: <#T##Double#>)
                cell.reviewLikeCount.text = String(Int(item.review.likeCount))
                cell.foodImg.load(url: URL(string: item.review.reviewImgUrl)!)
                cell.storeNameTag.text = "#" + item.review.storeName
                cell.contentText.text = item.review.content
//
            }.disposed(by: disposeBag)
    }

}

extension ReviewViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        1
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ReviewTableViewCell", for: indexPath) as? ReviewTableViewCell else { return UITableViewCell() }
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 168
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath)
    }
}
