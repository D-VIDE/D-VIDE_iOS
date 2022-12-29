//
//  ShowAroundReviewResponse.swift
//  DIVIDE
//
//  Created by 임우섭 on 2022/12/22.
//

import Foundation

struct UserPositionModel: Codable {
    var longitude, latitude: Double
}

// MARK: - UserPostsModel
struct UserPostsModel: Codable {
    let data: [Datum]
}

// MARK: - Datum
struct Datum: Codable {
    let user: UserInfo
    let post: Post
}

// MARK: - Post
struct Post: Codable {
    let id: Int
    let longitude, latitude: Double
    let title: String
    let targetTime, targetPrice, orderedPrice: Int
    let status: String
    let postImgUrl: String

}


// MARK: - User
struct UserInfo: Codable {
    let id: Int
    let nickname: String
    let profileImgUrl: String

}



