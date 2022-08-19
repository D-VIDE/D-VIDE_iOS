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
    static let snsUpperCell = ReusableCell<SNSUpperTableViewCell>()
    static let recommendCell = ReusableCell<SNSCollectionViewCell>()
  }


class SNSViewController: UIViewController {
    
    let viewModel = SNSViewModel()

    
    lazy var navigationView = UIView().then {
        $0.backgroundColor = .white
        $0.layer.addBorder([.bottom], color: .borderGray, width: 1)
        $0.layer.cornerRadius = 18
        $0.layer.maskedCorners = CACornerMask(arrayLiteral: .layerMaxXMaxYCorner, .layerMinXMaxYCorner)
        $0.layer.addShadow(location: .bottom)
    }
    
    lazy var navigationLabel = MainLabel(type: .hopang).then {
        $0.text = "D/VIDE 맛집"
    }
    
   
    
    lazy var tableView = UITableView().then {
        $0.dataSource = self
        $0.delegate = self
        $0.backgroundColor = .viewBackgroundGray
        $0.showsVerticalScrollIndicator = false
        $0.separatorStyle = .none
//        $0.refreshControl = UIRefreshControl()
//        $0.refreshControl?.addTarget(self, action: #selector(refreshTable(_:)), for: .valueChanged)
        $0.contentInset = UIEdgeInsets(top: 15, left: 0, bottom: 0, right: 0)
        $0.register(UITableViewHeaderFooterView.self, forHeaderFooterViewReuseIdentifier: "customHeader")
        $0.register(SNSReusable.snsUpperCell)
        $0.register(SNSReusable.snsCell)
    }
    
    
    

    override func viewDidLoad() {
        
        super.viewDidLoad()
        self.view.backgroundColor = .viewBackgroundGray
        self.navigationController?.navigationBar.isHidden = true
        
        self.view.addSubviews([navigationView, tableView])
        navigationView.addSubview(navigationLabel)
//        headerView.addSubviews([recommendLabel, collectionView])
        
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
        
    }
    
    func refreshTable() {
        return
    }
}


extension SNSViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        } else {
            return 10
        }

    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return indexPath.section == 0 ? 172 : 161
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch indexPath.section {
        case 0:
            let cell = tableView.dequeue(SNSReusable.snsUpperCell, for: indexPath)
            
            return cell
        case 1:
            let cell = tableView.dequeue(SNSReusable.snsCell, for: indexPath)
            if indexPath.row == 1 {
                cell.likeView.isHidden = false
            }
        
            return cell
        default :
            return UITableViewCell()
        }
        
        
    }
//    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
//        let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: "customHeader")
//
//        lazy var headerView = UIView().then {
//            $0.backgroundColor = .red
//        }
////        headerView.addSubviews([recommendLabel, collectionView])
////
//        headerView.snp.makeConstraints { make in
//            make.height.equalTo(300)
//        }
//
////        recommendLabel.snp.makeConstraints { make in
////            make.top.equalToSuperview().offset(15)
////            make.leading.equalToSuperview().offset(20)
////        }
////        collectionView.snp.makeConstraints { make in
////            make.top.equalTo(recommendLabel.snp.bottom).offset(5)
////            make.horizontalEdges.equalToSuperview()
////            make.height.equalTo(137)
////            make.bottom.equalToSuperview()
////        }
//
//
//        header?.backgroundView = headerView
//
//
//        return header
//    }
//
}


