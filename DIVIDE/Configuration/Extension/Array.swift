//
//  Array.swift
//  DIVIDE
//
//  Created by 정지윤 on 2022/07/04.
//

import Foundation

// 지정한 인덱스들 한 번에 삭제
extension Array {
    mutating func remove(at indexes: [Int]) {
        var lastIndex: Int? = nil
        for index in indexes.sorted(by: >) {
            guard lastIndex != index else {
                continue
            }
            remove(at: index)
            lastIndex = index
        }
    }
}
