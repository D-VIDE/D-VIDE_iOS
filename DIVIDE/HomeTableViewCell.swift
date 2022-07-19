//
//  HomeTableViewCell.swift
//  DIVIDE
//
//  Created by 임우섭 on 2022/07/18.
//

import UIKit
import SnapKit
import Then

class HomeTableViewCell: UITableViewCell {

    
    @IBOutlet weak var titleText: UILabel!
    @IBOutlet weak var foodImage: UIImageView!
    @IBOutlet weak var progressBar: UIImageView!
    
    @IBOutlet weak var AMPM: UILabel!
    @IBOutlet weak var closingTime: UILabel!
    @IBOutlet weak var insufficientMoney: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        //23강 19분 50초 참조
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
