//
//  ReviewModel.swift
//  DIVIDE
//
//  Created by 임우섭 on 2022/12/28.
//

import Foundation



// MARK: - UserReviwsModel
struct UserReviewsModel: Codable {
    let data: [ReviewData]
}

// MARK: - Datum
struct ReviewData: Codable {
    let user: UserInfo
    let review: Review
}

// MARK: - Reviews
struct Review: Codable {
    let reviewId: Int
    let longitude, latitude: Double
    let content: String
    let starRating: Double
    let reviewImgUrl: String
    let storeName: String
    let likeCount: Int
    let isLiked: Bool
}




