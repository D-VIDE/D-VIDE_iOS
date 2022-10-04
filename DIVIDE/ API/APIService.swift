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
    case postRecruiting(param: PostRecruitingInput, img: [Data])
    case showAroundPost(param: UserPositionModel)
}

extension APIService: TargetType {
    var baseURL: URL {
            return URL(string: "http://divide.kro.kr/api")!
    }
        
    var path: String {
        switch self { //path에 쓰일 parameter 받을 때만 let
        case .postRecruiting, .showAroundPost:
            return "/v2/posts"
        
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .postRecruiting:
            return .post
        case .showAroundPost:
            return .get
        }
    }
    
    // 테스트 request - 있어도 되고 없어도 됨
    var sampleData: Data {
        switch self {
        case .postRecruiting, .showAroundPost:
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
                
                for i in img {
                    let imgData = MultipartFormData(provider: .data(i), name: "postImgFiles", fileName: "postImage.jpeg", mimeType: "image/jpeg")
                    multipartFormData.append(imgData)
                }
                print("DEBUG: \(multipartFormData)")
                return .uploadMultipart(multipartFormData)
            
            } catch {
                print("절대 안돼")
                print(error.localizedDescription)
                return .requestData(img[0])
            }
            
        case let .showAroundPost(param):
            return .requestParameters(parameters: [
                "longitude" : param.longitude,
                "latitude" : param.latitude], encoding: URLEncoding.queryString)
        }
    }
    var headers: [String : String]? {
        switch self{
        case .postRecruiting, .showAroundPost:
            return [
                "Authorization" : "Bearer \(token)"
            ]
        }
    }
    }
