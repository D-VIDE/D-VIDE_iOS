//
//  SNSViewController.swift
//  DIVIDE
//
//  Created by 임우섭 on 2022/07/27.
//

import UIKit
import Then
import SnapKit
import ReusableKit

enum SNSReusable {
    static let snsCell = ReusableCell<SNSTableViewCell>()
    static let recommendCell = ReusableCell<SNSCollectionViewCell>()
  }


class SNSViewController: UIViewController {
    
    
    lazy var navigationView = UIView().then {
        $0.backgroundColor = .white
//        $0.layer.addBorder([.bottom], color: .borderGray, width: 1)
        $0.layer.cornerRadius = 18
        $0.layer.maskedCorners = CACornerMask(arrayLiteral: .layerMaxXMaxYCorner, .layerMinXMaxYCorner)
        $0.layer.addShadow(location: .bottom)
    }
    
    lazy var navigationLabel = MainLabel(type: .hopang).then {
        $0.text = "D/VIDE 맛집"
    }
    
    lazy var recommendLabel = MainLabel(type: .Point2).then {
        $0.text = "• 디/바이더 추천 맛집"
    }
    lazy var collectionView = UICollectionView().then {
        $0.dataSource = self
        $0.delegate = self
        $0.backgroundColor = .viewBackgroundGray
        $0.showsVerticalScrollIndicator = false
//        $0.refreshControl = UIRefreshControl()
//        $0.refreshControl?.addTarget(self, action: #selector(refreshTable(_:)), for: .valueChanged)
        $0.contentInset = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
        $0.register(SNSReusable.recommendCell)
    }
    
    lazy var tableView = UITableView().then {
        $0.dataSource = self
        $0.delegate = self
        $0.backgroundColor = .viewBackgroundGray
        $0.showsVerticalScrollIndicator = false
        $0.separatorStyle = .none
//        $0.refreshControl = UIRefreshControl()
//        $0.refreshControl?.addTarget(self, action: #selector(refreshTable(_:)), for: .valueChanged)
        $0.rowHeight = 146
        $0.contentInset = UIEdgeInsets(top: 20, left: 0, bottom: 0, right: 0)
        $0.register(SNSReusable.snsCell)
    }
    

    override func viewDidLoad() {
        
        super.viewDidLoad()
        self.view.backgroundColor = .viewBackgroundGray
        self.navigationController?.navigationBar.isHidden = true
        
        self.view.addSubviews([navigationView, tableView])
        navigationView.addSubview(navigationLabel)
        tableView.tableHeaderView?.addSubviews([recommendLabel, collectionView])
        
        setConstraints()
    }
    
    func setConstraints(){
        navigationView.snp.makeConstraints { make in
            make.height.equalTo(116)
            make.top.equalToSuperview()
            make.leading.trailing.equalToSuperview()
        }
        navigationLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalTo(navigationView.snp.bottom).offset(-20)
        }
        tableView.snp.makeConstraints { make in
            make.top.equalTo(navigationView.snp.bottom)
            make.horizontalEdges.equalTo(self.view)
            make.bottom.equalTo(self.view)
        }
        tableView.tableHeaderView?.snp.makeConstraints { make in
            make.height.equalTo(187)
        }
        recommendLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(15)
            make.leading.equalToSuperview().offset(20)
        }
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(recommendLabel.snp.bottom).offset(5)
            make.horizontalEdges.equalToSuperview()
            make.height.equalTo(137)
        }
    }
    
    func refreshTable() {
        return
    }
}

extension SNSViewController: UICollectionViewDelegate, UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeue(SNSReusable.recommendCell, for: indexPath)
        
        return cell
    }
}

extension SNSViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeue(SNSReusable.snsCell, for: indexPath)
        

        return cell
    }
    
}


