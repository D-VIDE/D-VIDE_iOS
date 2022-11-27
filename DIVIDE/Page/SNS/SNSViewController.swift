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

    
    lazy var navigationView = UIView()
    lazy var navigationLabel = MainLabel(type: .hopang)
    lazy var tableView = UITableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setAttribute()
        addView()
        setLayout()
        
        self.navigationController?.navigationBar.isHidden = true
        
    }
    func setAttribute() {
        // UIView
        navigationView.do {
            $0.backgroundColor = .white
            $0.layer.addBorder([.bottom], color: .borderGray, width: 1)
            $0.layer.cornerRadius = 18
            $0.layer.maskedCorners = CACornerMask(arrayLiteral: .layerMaxXMaxYCorner, .layerMinXMaxYCorner)
            $0.layer.addShadow(location: .bottom)
        }
        tableView.do {
            $0.dataSource = self
            $0.delegate = self
            $0.backgroundColor = .viewBackgroundGray
            $0.showsVerticalScrollIndicator = false
            $0.separatorStyle = .none
            $0.contentInset = UIEdgeInsets(top: 15, left: 0, bottom: 0, right: 0)
            $0.register(UITableViewHeaderFooterView.self, forHeaderFooterViewReuseIdentifier: "customHeader")
            $0.register(SNSReusable.snsUpperCell)
            $0.register(SNSReusable.snsCell)
        }
        // Label
        navigationLabel.do {
            $0.text = "D/VIDE 맛집"
        }
    }
    func addView() {
        view.addSubview(navigationView)
        view.addSubview(tableView)
        
        navigationView.addSubview(navigationLabel)
        
    }
    func setLayout() {
        view.backgroundColor = .viewBackgroundGray
        // UIView
        navigationView.snp.makeConstraints { make in
            make.height.equalTo(116)
            make.top.equalToSuperview()
            make.leading.trailing.equalToSuperview()
        }
        tableView.snp.makeConstraints { make in
            make.top.equalTo(navigationView.snp.bottom)
            make.horizontalEdges.equalTo(self.view)
            make.bottom.equalTo(self.view)
        }
        
        
        // UILabel
        navigationLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalTo(navigationView.snp.bottom).offset(-20)
        }
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

}


