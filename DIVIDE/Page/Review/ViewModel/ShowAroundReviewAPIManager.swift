//
//  ShowAroundReviewAPIManager.swift
//  DIVIDE
//
//  Created by 임우섭 on 2022/12/22.
//

import Foundation
import Moya
import RxSwift

class ShowAroundReviews {
    var realProvider = MoyaProvider<APIService>(plugins: [MoyaInterceptor()])
    
    //    var postsFromServer = PublishSubject<[Datum]>()
    
    func requestAroundReviews(param: UserPositionModel) -> Single<[ReviewData]> {
        realProvider.rx.request(.showAroundReviews(param: param))
            .filterSuccessfulStatusCodes()
            .map(UserReviewsModel.self) // Single<UserReviewsModel>
            .flatMap { result in
                    .just(result.data) // .just({something}) -> Single<{something}.type>
            }
        
    }
}

