//
//  SNSViewController.swift
//  DIVIDE
//
//  Created by 임우섭 on 2022/07/27.
//

import UIKit
import Then
import SnapKit



class SNSViewController: UIViewController {
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setAttribute()
        addView()
        setLayout()
        
        self.navigationController?.navigationBar.isHidden = true
        
    }
    func setAttribute() {
       
    }
    func addView() {
        
    }
    func setLayout() {
       
    }
    
}
//
//extension SNSViewController: UITableViewDelegate, UITableViewDataSource {
//    func numberOfSections(in tableView: UITableView) -> Int {
//        return 2
//    }
//    
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        if section == 0 {
//            return 1
//        } else {
//            return 10
//        }
//
//    }
//    
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        return indexPath.section == 0 ? 172 : 161
//    }
//    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
//        return 0
//    }
//    
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        
//        switch indexPath.section {
//        case 0:
//            
//            return cell
//        case 1:
//            
//        
//            return cell
//        default :
//            return UITableViewCell()
//        }
//        
//        
//    }
//
//}


