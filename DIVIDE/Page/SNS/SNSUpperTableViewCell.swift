//
//  SNSUpperTableViewCell.swift
//  DIVIDE
//
//  Created by 정지윤 on 2022/08/19.
//

import UIKit
import Then
import SnapKit


class SNSUpperTableViewCell: UITableViewCell {
    
    static let reuseIdentifier = "SNSUpperTableViewCell"
    
    lazy var collectionView = UICollectionView(
        frame: .zero,
        collectionViewLayout: UICollectionViewFlowLayout().then{
            $0.scrollDirection = .horizontal
            $0.itemSize = CGSize(width: 114, height: 137)
            $0.minimumLineSpacing = 0
        }
    ).then {
        $0.dataSource = self
        $0.delegate = self
        $0.backgroundColor = .viewBackgroundGray
        $0.showsHorizontalScrollIndicator = false
//        $0.refreshControl = UIRefreshControl()
//        $0.refreshControl?.addTarget(self, action: #selector(refreshTable(_:)), for: .valueChanged)
        $0.contentInset = UIEdgeInsets(top: 0, left: 20, bottom: 15, right: 12)
        $0.register(SNSReusable.recommendCell)
    }
    
    lazy var recommendLabel = MainLabel(type: .Point2).then {
        $0.text = "• 디/바이더 추천 맛집"
    }
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.backgroundColor = .viewBackgroundGray
        contentView.addSubviews([collectionView, recommendLabel])
        
        recommendLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(20)
            make.top.equalToSuperview()
        }
        
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(recommendLabel.snp.bottom).offset(5)
            make.horizontalEdges.equalToSuperview()
            make.height.equalTo(137)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

extension SNSUpperTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeue(SNSReusable.recommendCell, for: indexPath)
        
        return cell
    }
}
