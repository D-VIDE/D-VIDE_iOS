//
//  ShowAroundPostResponse.swift
//  DIVIDE
//
//  Created by 임우섭 on 2022/08/22.
//

import Foundation

// parameter
struct UserPositionModel: Codable {
    var longitude, latitude: Double
}

// 받는 데이터
struct UserPostsModel: Decodable {
    let postID: Int
    let profileImgURL, nickname: String
    let longitude, latitude: Double
    let targetTime: [Int]
    let title: String
    let targetPrice: Int
    let category: String

}


