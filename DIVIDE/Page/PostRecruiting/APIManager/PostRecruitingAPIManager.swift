//
//  PostRecruitingAPIManager.swift
//  DIVIDE
//
//  Created by 정지윤 on 2022/08/09.
//

import Foundation
import Moya

struct PostRecruitingAPIManager {
    fileprivate let provider = MoyaProvider<APIService>()
    
    func requestpostRecruiting(title: String, storeName: String, content: String, targetPrice: Int, deliveryPrice: Int, longitude: Double, latitude: Double, category: String, targetTime: String, completion: @escaping (Result<PostRecruitingResponse, Error>) -> Void) {
        provider.request(.postRecruiting(title: title, storeName: storeName, content: content, targetPrice: targetPrice, deliveryPrice: deliveryPrice, longitude: longitude, latitude: latitude, category: category, targetTime: targetTime)) { result in
            switch result {
            case let .success(response):
                do {
                    let decoded = try JSONDecoder().decode(PostRecruitingResponse.self, from: response.data)
                    completion(.success(decoded))
                } catch let error {
                    completion(.failure(error))
                }
            case let .failure(error):
                completion(.failure(error))
                print(error.localizedDescription)
            }
        }
    }
}
