//
//  CollectionViewCell.swift
//  DIVIDE
//
//  Created by 임우섭 on 2022/09/02.
//

import UIKit

class CarouselCell: UICollectionViewCell {
    let customView: UIView = {
            let view = UIView()
            view.translatesAutoresizingMaskIntoConstraints = false
            view.layer.cornerRadius = 12
            view.backgroundColor = .red
            return view
        }()
    

        override init(frame: CGRect) {
            super.init(frame: frame)

            self.addSubview(self.customView)
            
            self.customView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
            self.customView.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
            self.customView.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 1).isActive = true
            self.customView.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 1).isActive = true
            
        }

        required init?(coder aDecoder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
}
