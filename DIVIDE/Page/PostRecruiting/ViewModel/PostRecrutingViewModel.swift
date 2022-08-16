//
//  PostRecrutingResponse.swift
//  DIVIDE
//
//  Created by 정지윤 on 2022/08/09.
//

import Foundation

import RxSwift
import RxCocoa
import RxGesture
import RxRelay
import UIKit


class CustomImageView: UIImageView {
    var disposeBag = DisposeBag()
    
    //tap인지 longPress인지 구분
    func setOnEventListener(_ onTapCommand: @escaping ((_ gesture: UIGestureRecognizer) -> Void)) {
        self.rx.anyGesture(.tap(), .longPress())
            .when(.recognized)
            .subscribe(onNext: { [weak self] gesture in
                if let tap = gesture as? UITapGestureRecognizer {
                    onTapCommand(tap)
                } else if let longPress = gesture as? UILongPressGestureRecognizer {
                    onTapCommand(longPress)
                }
            }).disposed(by: disposeBag)
    }
    
//    func postRecruitingPost()
    
}


class PostRecruitingViewModel {
    
    var disposeBag = DisposeBag()
    
    var imgArray : BehaviorRelay<[Int]> = BehaviorRelay(value: [])
    
//    imgArray.subscribe(onNext: {
//        print($0)
//    })
    
}
