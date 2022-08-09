//
//  DivideAPI.swift
//  DIVIDE
//
//  Created by 정지윤 on 2022/08/09.
//

import Foundation
import Moya


enum APIService {
    case postRecruiting(title: String, storeName: String, content: String, targetPrice: Int, deliveryPrice: Int, longitude: Double, latitude: Int, category: String, targetTime: String)
}

extension APIService: TargetType {
    var baseURL: URL {
            return URL(string: "divide.kro.kr:8080/api/v1")!
    }
        
    var path: String {
        switch self { //path에 쓰일 parameter 받을 때만 let
        case .postRecruiting(_, _, _, _, _, _, _, _, _):
            return "/post"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .postRecruiting(_, _, _, _, _, _, _, _, _):
            return .post
        }
    }
    
    var sampleData: Data {
        switch self {
        case .postRecruiting(_, _, _, _, _, _, _, _, _):
            
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
        case .postRecruiting(let title, let storeName, let content, let targetPrice, let deliveryPrice, let longitude, let latitude, let category, let targetTime):
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
            return .requestParameters(parameters: params, encoding: URLEncoding.queryString)
        }
    }
    
    var headers: [String : String]? {
        return nil
    }
}
