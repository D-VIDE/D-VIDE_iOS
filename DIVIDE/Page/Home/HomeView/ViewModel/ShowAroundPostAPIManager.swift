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
        
        
        //        realProvider.request(.showAroundPost(param: param)) { result in
        //            switch result {
        //            case let.success(response):
        //                print(response.description)
        //                do {
        ////                    let filteredResponse = try response.filterSuccessfulStatusCodes()
        //                    let postsFromServer = try response.map(UserPostsModel.self,using: JSONDecoder())
        //                    self.postsFromServer.on(.next(postsFromServer.data))
        //                } catch let error {
        //                    print(error.localizedDescription)
        //                }
        //            case let .failure(error):
        //                print(error.localizedDescription)
        //            }
        //        }
    }
}

