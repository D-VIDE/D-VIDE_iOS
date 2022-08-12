//
//  DivideAPI.swift
//  DIVIDE
//
//  Created by 정지윤 on 2022/08/09.
//

import Foundation
import Moya

public let token = "eyJhbGciOiJIUzUxMiJ9.eyJzdWIiOiJlbWFpbEBnbWFpbC5jb20iLCJhdXRoIjoiVVNFUiIsImV4cCI6MjY2MDEyOTMxMH0.vbzMK8T0YUKb3TTc-y-t_fQfRJaiGV2dHxQqk-Hvim8Qkoryzw9Rs5sLg-NC9j6FFL_l5fFoPwOLIjuMtm7fQA"

enum APIService {
    case postRecruiting(userId: Int, title: String, storeName: String, content: String, targetPrice: Int, deliveryPrice: Int, longitude: Double, latitude: Double, category: String, targetTime: Int)
}

extension APIService: TargetType {
    var baseURL: URL {
            return URL(string: "http://divide.kro.kr")!
    }
        
    var path: String {
        switch self { //path에 쓰일 parameter 받을 때만 let
        case .postRecruiting(_, _, _, _, _, _, _, _, _, _):
            return "/api/v1/post"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .postRecruiting(_, _, _, _, _, _, _, _, _, _):
            return .post
        }
    }
    
    var sampleData: Data {
        switch self {
        case .postRecruiting(_, _, _, _, _, _, _, _, _, _):
            
            return Data(
                """
                {
                    "title": "테스트용입니다",
                    "storeName": "신불 떡볶이2",
                    "content": "게시글 내용2",

                    "targetPrice": 1000,
                    "deliveryPrice": 5000,
                    "longitude": 37.49015482509,
                    "latitude": 127.030767490,

                    "category": "KOREAN_FOOD",
                    "targetTime": "2022-08-30 15:12:35"
                }
                """.utf8
            )
        }
    }
    
    var task: Task {
        switch self {
        case .postRecruiting(let userId, let title, let storeName, let content, let targetPrice, let deliveryPrice, let longitude, let latitude, let category, let targetTime):
            let params: [String: Any] = [
                "title": title,
                "storeName": storeName,
                "content": content,

                "targetPrice": targetPrice,
                "deliveryPrice": deliveryPrice,
                "longitude": longitude,
                "latitude": latitude,

                "category": category,
                "targetTime": targetTime
            ]
            
            
            return .requestParameters(parameters: params, encoding: JSONEncoding.default)
        }
    }
    
    var headers: [String : String]? {
        return ["Authorization" : "Bearer \(token)"]
    }
}
