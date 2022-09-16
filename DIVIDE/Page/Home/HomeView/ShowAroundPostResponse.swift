//
//  ShowAroundPostResponse.swift
//  DIVIDE
//
//  Created by 임우섭 on 2022/08/22.
//

//import Foundation
//
//// parameter

//
//// 받는 데이터
//struct UserPostsModel: Decodable {
//    struct User: Decodable {
//        let postID: Int
//        let profileImgURL, nickname: String
//    }
//    struct Post: Decodable {
//        let longitude, latitude: Double
//        let title: String
//        let targetTime: Int
//        let targetPrice: Int
//        let orderedPrice: Int
//        let status : String
//        let postImgUrl: String
//    }
//}
// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let welcome = try? newJSONDecoder().decode(Welcome.self, from: jsonData)

// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let userPostsModel = try? newJSONDecoder().decode(UserPostsModel.self, from: jsonData)

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



