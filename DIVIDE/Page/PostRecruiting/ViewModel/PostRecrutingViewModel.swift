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


class CustomImageView: UIImageView {
    var disposeBag = DisposeBag()
    
    func setOnEventListener(_ onTapCommand: @escaping (() -> Void)) {
        self.rx.tapGesture()
            .when(.recognized)
            .subscribe { event in
                onTapCommand()
            }.disposed(by: disposeBag)

    }
}
