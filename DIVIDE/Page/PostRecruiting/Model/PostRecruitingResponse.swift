//
//  PostRecruitingReponse.swift
//  DIVIDE
//
//  Created by 정지윤 on 2022/08/09.
//

import Foundation


struct PostRecruitingInput: Codable {
    var title : String
    var storeName : String
    var content : String
    var targetPrice : Int
    var deliveryPrice : Int
    var longitude : Double
    var latitude : Double
    var category : String
    var targetTime : Int
}

struct PostRecruitingResponse: Decodable {
    let postId: Int
}
