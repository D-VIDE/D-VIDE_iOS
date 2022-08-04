//
//  SNSViewController.swift
//  DIVIDE
//
//  Created by 임우섭 on 2022/07/27.
//

import UIKit

class SNSViewController: UIViewController {

    override func viewDidLoad() {
        let label = UILabel(frame: CGRect(x: 100, y: 200, width: 200, height: 100))
        
        label.text = "SNS 뷰컨트롤러"
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.textColor = .green
        label.sizeToFit()
        label.center.x = self.view.frame.width / 2
        self.view.addSubview(label)
        super.viewDidLoad()

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
