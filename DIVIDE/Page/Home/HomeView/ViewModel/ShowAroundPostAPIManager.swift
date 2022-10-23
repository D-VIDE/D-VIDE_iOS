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
    
    //    var postsFromServer = PublishSubject<[Datum]>()
    
    func requestAroundPosts(param: UserPositionModel) -> Single<[Datum]> {
        realProvider.rx.request(.showAroundPost(param: param))
            .filterSuccessfulStatusCodes()
            .map(UserPostsModel.self) // Single<UserPostsModel>
            .flatMap { result in
                    .just(result.data) // .just({something}) -> Single<{something}.type>
            }
        
    }
    func requestAroundPostsWithCategory(param: UserPositionModel, category: String) -> Single<[Datum]> {
        realProvider.rx.request(.showAroundPostWithCategory(param: param, category: category))
            .filterSuccessfulStatusCodes()
            .map(UserPostsModel.self)
            .flatMap { result in
                    .just(result.data)
            }
    }
}

