//
//  HomeViewController.swift
//  DIVIDE
//
//  Created by 임우섭 on 2022/07/18.
//

import UIKit

class HomeViewController: UIViewController{
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        let homeTableViewCellNib = UINib(nibName: "HomeTableViewCell", bundle: nil)
        tableView.register(homeTableViewCellNib, forCellReuseIdentifier: "HomeTableViewCell")
        // Do any additional setup after loading the view.
    }
    

}
extension HomeViewController : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        10
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "HomeTableViewCell", for: indexPath) as? HomeTableViewCell else {
            return UITableViewCell()
        }
        cell.selectionStyle = .none
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
}
