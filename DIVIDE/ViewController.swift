//
//  ViewController.swift
//  DIVIDE
//
//  Created by 정지윤 on 2022/06/28.
//

import UIKit
import Then
import SnapKit

class ViewController: UIViewController {
   
    
    private let tableView: UITableView = {

        let tableview = UITableView()
        tableview.backgroundColor = .homeBackgroundGray
        tableview.showsVerticalScrollIndicator = false
        return tableview

    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self

            

        tableView.register(HomeTableViewCell.self, forCellReuseIdentifier: "HomeTableViewCell")

        setConstraint()

               
           // autoHeight
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = UITableView.automaticDimension
        // Do any additional setup after loading the view.
    }
    private func setConstraint() {
        self.view.backgroundColor = .homeBackgroundGray
        self.view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
            make.top.equalToSuperview().offset(113)
            make.bottom.equalToSuperview()
        }
    }

}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 20
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "HomeTableViewCell", for: indexPath) as? HomeTableViewCell else { return UITableViewCell() }
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 168
    }
}


