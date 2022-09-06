//
//  ShowAroundPostAPIManager.swift
//  DIVIDE
//
//  Created by 임우섭 on 2022/08/22.
//

import Foundation
import Moya
import RxSwift

class ShowAroundPosts {
    var realProvider = MoyaProvider<APIService>(plugins: [MoyaInterceptor()])
    
    var postsFromServer = BehaviorSubject(value: [UserPostsModel]())
    
    func requestAroundPosts(param: UserPositionModel) -> Void {
        realProvider.request(.showAroundPost(param: param)) { result in
            switch result {
            case let.success(response):
                print(response.description)
                do {
                    let responseData = try JSONDecoder().decode([UserPostsModel].self, from: response.data)
                    self.postsFromServer.on(.next(responseData))
                } catch let error {
                    print(error.localizedDescription)
                }
            case let .failure(error):
                print(error.localizedDescription)
            }
        }
    }
}
