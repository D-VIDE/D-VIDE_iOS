//
//  Date.swift
//  DIVIDE
//
//  Created by 정지윤 on 2022/07/04.
//

import UIKit

extension Date {
    init(year: Int, month: Int, day: Int) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy:MM:dd"
        self = dateFormatter.date(from: "\(year):\(month):\(day)") ?? Date()
    }
    
    var text: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        return dateFormatter.string(from: self)
    }
    
    var detailText: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd hh:mm:ss"
        return dateFormatter.string(from: self)
    }
    
    var fileName: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyyMMddhhmmssSSS"
        return dateFormatter.string(from: self)
    }
}

