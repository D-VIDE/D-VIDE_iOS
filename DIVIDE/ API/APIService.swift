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
    case postRecruiting(param: PostRecruitingInput, img: Data)
}

extension APIService: TargetType {
    var baseURL: URL {
            return URL(string: "http://divide.kro.kr")!
    }
        
    var path: String {
        switch self { //path에 쓰일 parameter 받을 때만 let
        case .postRecruiting:
            return "/api/v1/post"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .postRecruiting:
            return .post
        }
    }
    
    // 테스트 request - 있어도 되고 없어도 됨
    var sampleData: Data {
        switch self {
        case .postRecruiting:
            return Data()
        }
    }
    
    var task: Task {
        switch self {
        case .postRecruiting(let param, let img):
            do {
                let jsonData = try JSONEncoder().encode(param)
                var multipartFormData = [MultipartFormData]()
                let requestData = MultipartFormData(provider: .data(jsonData), name: "request", mimeType: "application/json")
                multipartFormData.append(requestData)
                
                let imgData = MultipartFormData(provider: .data(img), name: "postImageFiles", fileName: "postImage.jpeg", mimeType: "image/jpeg")
                multipartFormData.append(imgData)
//                for i in img {
//
//                }
                print("DEBUG \(multipartFormData)")
                return .uploadMultipart(multipartFormData)

            
            } catch {
                print("절대 안돼")
                print(error.localizedDescription)
                return .requestData(img)
            }
        }
    }
    
    var headers: [String : String]? {
        switch self{
        case .postRecruiting:
            return [
                "Authorization" : "Bearer \(token)"
            ]
        }
    }
}
