//
//  TabBarController.swift
//  DIVIDE
//
//  Created by 임우섭 on 2022/07/27.
//

import UIKit

class TabBarController: UITabBarController {
    static let objectRatio  = 4.0 / 7.0
    let HomeIcon: UIImage = UIImage(imageLiteralResourceName: "Divide.png").resize(toTargetSize: CGSize(width: 52.22*objectRatio, height: 56.78*objectRatio))!.withRenderingMode(.alwaysOriginal)
    let HomeIconUnselected: UIImage = UIImage(imageLiteralResourceName: "DivideUnselected.png").resize(toTargetSize: CGSize(width: 52.22*objectRatio, height: 56.78*objectRatio))!.withRenderingMode(.alwaysOriginal)
    
    let ReviewIcon: UIImage = UIImage(imageLiteralResourceName: "리뷰.png").resize(toTargetSize: CGSize(width: 60.17*objectRatio, height: 56.86*objectRatio))!.withRenderingMode(.alwaysOriginal)
    let ReviewSelectedIcon: UIImage = UIImage(imageLiteralResourceName: "리뷰Unselected.png").resize(toTargetSize: CGSize(width: 60.17*objectRatio, height: 56.86*objectRatio))!.withRenderingMode(.alwaysOriginal)
    
    let ChatIcon: UIImage = UIImage(imageLiteralResourceName: "채팅.png").resize(toTargetSize: CGSize(width: 57.2*objectRatio, height: 52.22*objectRatio))!.withRenderingMode(.alwaysOriginal)
    let ChatIconUnselected: UIImage = UIImage(imageLiteralResourceName: "채팅Unselected.png").resize(toTargetSize: CGSize(width: 57.2*objectRatio, height: 52.22*objectRatio))!.withRenderingMode(.alwaysOriginal)
    
    let ProfileIcon: UIImage = UIImage(imageLiteralResourceName: "기본 프로필.png").resize(toTargetSize: CGSize(width: 57.69*objectRatio, height: 57.34*objectRatio))!.withRenderingMode(.alwaysOriginal)
    let ProfileIconUnselected: UIImage = UIImage(imageLiteralResourceName: "기본 프로필Unselected.png").resize(toTargetSize: CGSize(width: 57.69*objectRatio, height: 57.34*objectRatio))!.withRenderingMode(.alwaysOriginal)
    override func viewDidLoad() {
        super.viewDidLoad()
        let firstTab = HomeViewController()
        let secondTab = ReviewViewController()
        let thirdTab = ChatListViewController()
        let fourthTab = ProfileViewController()
        
        firstTab.tabBarItem = UITabBarItem(title: "디바이드", image: self.HomeIconUnselected, tag: 0)
        firstTab.tabBarItem.selectedImage = HomeIcon
        
        secondTab.tabBarItem = UITabBarItem(title: "리뷰  ", image: self.ReviewSelectedIcon, tag: 1)
        secondTab.tabBarItem.selectedImage = ReviewIcon
        
        thirdTab.tabBarItem = UITabBarItem(title: "채팅", image: self.ChatIconUnselected, tag: 2)
        thirdTab.tabBarItem.selectedImage = ChatIcon
        
        fourthTab.tabBarItem = UITabBarItem(title: "My", image: self.ProfileIconUnselected, tag: 3)
        fourthTab.tabBarItem.selectedImage = ProfileIcon
        let TabList = [firstTab, secondTab, thirdTab, fourthTab]
        
        self.tabBar.backgroundColor = .white
        self.tabBar.tintColor = .gray3
        self.tabBar.unselectedItemTintColor = .gray2
        self.tabBar.roundCorners(cornerRadius: 26, maskedCorners: [.layerMinXMinYCorner, .layerMaxXMinYCorner])
        
        TabList.forEach {
            $0.tabBarItem.imageInsets.top = 10
        }
        
        self.viewControllers = TabList
        // Do any additional setup after loading the view.
    }
    
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension UITabBar {
    override open func sizeThatFits(_ size: CGSize) -> CGSize {
        var sizeThatFits = super.sizeThatFits(size)
        sizeThatFits.height = 74
        return sizeThatFits
    }
}
