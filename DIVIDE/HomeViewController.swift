//
//  ViewController.swift
//  DIVIDE
//
//  Created by 정지윤 on 2022/06/28.
//

import UIKit
import Then
import SnapKit
class HomeViewController: UIViewController {
    
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
    let menuList: [String] = ["분식", "한식", "양식", "일식", "디저트", "---", "------" ]
    
    private let topMenuCollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout()).then{
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        $0.backgroundColor = .white
        $0.contentInset = UIEdgeInsets.init(top: 0, left: 20, bottom: 0, right: 0)
        $0.showsHorizontalScrollIndicator = false
        $0.collectionViewLayout = layout
    }
    
    private let tableView: UITableView = {
        
        let tableview = UITableView()
        tableview.backgroundColor = .homeBackgroundGray
        tableview.showsVerticalScrollIndicator = false
        return tableview

    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        topMenuCollectionView.delegate = self
        topMenuCollectionView.dataSource = self
        tableView.delegate = self
        tableView.dataSource = self

            
        topMenuCollectionView.register(HomeTopMenuCell.self, forCellWithReuseIdentifier: HomeTopMenuCell.identifier)
        tableView.register(HomeTableViewCell.self, forCellReuseIdentifier: "HomeTableViewCell")
        
        setHomeViewConstraint()
        
        setTopMenuBar()
        setTopMenuCollection()
        
        setTableViewConstraint()
//        setTableViewBackground()
        
           // autoHeight
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = UITableView.automaticDimension
        // Do any additional setup after loading the view.
    }
    
    private func setHomeViewConstraint() {
        self.view.backgroundColor = .backgroundGray
       
        

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
//    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        let cell = collectionView.cellForItem(at: indexPath)
//        if cell?.isSelected {
//            collectionView.cellForItem(at: indexPath)?.backgroundColor = .mainOrange
//            cell.menuLabel.textColor = .white
//            print("Orange")
//            collectionView.deselectItem(at: indexPath, animated: true)
//            
//        } else {
//            collectionView.cellForItem(at: indexPath)?.backgroundColor = .tagBackgroundGray
//            cell.menuLabel.textColor = .tagGray
//            print("Gray")
//            
//        }
//    }
    
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
        performSegue(withIdentifier: "DetailPage", sender: nil)
    }
}


