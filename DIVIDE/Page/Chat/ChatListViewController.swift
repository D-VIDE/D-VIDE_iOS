//
//  ChatListViewController.swift
//  DIVIDE
//
//  Created by 정지윤 on 2022/08/05.
//

import Foundation
import UIKit
import Then
import SnapKit
import ReusableKit


enum ChatReusable {
    static let chatCell = ReusableCell<ChatListTableViewCell>()
  }


class ChatListViewController: UIViewController {
    
    lazy var navigationView = UIView().then {
        $0.backgroundColor = .white
        $0.layer.addBorder([.bottom], color: .mainLightGray, width: 1)
        $0.layer.cornerRadius = 18
        $0.layer.maskedCorners = CACornerMask(arrayLiteral: .layerMaxXMaxYCorner, .layerMinXMaxYCorner)
        $0.layer.addShadow(location: .bottom)
    }
    
    lazy var navigationLabel = MainLabel(type: .hopang).then {
        $0.text = "D/VIDE 채팅"
    }
    
    lazy var chatListTableView = UITableView().then {
        $0.dataSource = self
        $0.delegate = self
        $0.backgroundColor = .viewBackgroundGray
        $0.showsVerticalScrollIndicator = false
        $0.separatorStyle = .none
        $0.refreshControl = UIRefreshControl()
        $0.refreshControl?.addTarget(self, action: #selector(refreshTable(_:)), for: .valueChanged)
        $0.rowHeight = 93
        $0.contentInset = UIEdgeInsets(top: 20, left: 0, bottom: 0, right: 0)
        $0.register(ChatReusable.chatCell)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .viewBackgroundGray
        self.navigationController?.navigationBar.isHidden = true
        
        self.view.addSubviews([navigationView, chatListTableView])
        navigationView.addSubview(navigationLabel)
        
        
        setConstraints()
            
    }
    
    
    func setConstraints() {
        navigationView.snp.makeConstraints { make in
            make.height.equalTo(116)
            make.top.equalToSuperview()
            make.leading.trailing.equalToSuperview()
        }
        navigationLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalTo(navigationView.snp.bottom).offset(-20)
        }
        chatListTableView.snp.makeConstraints { make in
            make.top.equalTo(navigationView.snp.bottom).offset(3)
            make.bottom.trailing.leading.equalToSuperview()
                .inset(UIEdgeInsets(top: 23, left: 0, bottom: 0, right: 0))
        }
    }
    
    @objc func refreshTable(_ sender: UIRefreshControl) {
        print("refresh")
    }
}

extension ChatListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 20
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeue(ChatReusable.chatCell, for: indexPath)
        
        if indexPath.row == 0 {
            cell.cellView.layer.borderWidth = 2
            cell.cellView.layer.borderColor = UIColor.mainYellow.cgColor
        }
        
        return cell
    }
}

