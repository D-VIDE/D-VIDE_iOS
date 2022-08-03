//
//  String.swift
//  DIVIDE
//
//  Created by 정지윤 on 2022/07/04.
//

import UIKit

extension String {
    var isEmpty: Bool {
        return self.count == 0
    }
    var isExists: Bool {
        return self.count > 0
    }
    var trim: String? {
        return self.trimmingCharacters(in: .whitespacesAndNewlines)
    }
    
    func substring(from: Int, to: Int) -> String {
        guard (to >= 0) && (from <= self.count) && (from <= to) else {
            return ""
        }
        let start = index(startIndex, offsetBy: max(from, 0))
        let end = index(start, offsetBy: min(to, self.count) - from)
        return String(self[start ..< end])
    }
    
    func substring(range: Range<Int>) -> String {
        return substring(from: range.lowerBound, to: range.upperBound)
    }
    
    func get(_ index: Int) -> String {
        return self.substring(range: index..<index + 1)
    }
    
    func replace(target: String, with withString: String) -> String{
        return self.replacingOccurrences(of: target, with: withString, options: .literal, range: nil)
    }
    
    
    var insertComma: String {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        if let _ = self.range(of: ".") {
            let numberArray = self.components(separatedBy: ".")
            if numberArray.count == 1 {
                var numberString = numberArray[0]
                if numberString.isEmpty {
                    numberString = "0"
                }
                guard let doubleValue = Double(numberString)
                    else { return self }
                return numberFormatter.string(from: NSNumber(value: doubleValue)) ?? self
            } else if numberArray.count == 2 {
                var numberString = numberArray[0]
                if numberString.isEmpty {
                    numberString = "0"
                }
                guard let doubleValue = Double(numberString)
                    else {
                        return self
                }
                return (numberFormatter.string(from: NSNumber(value: doubleValue)) ?? numberString) + ".\(numberArray[1])"
            }
        }
        else {
            guard let doubleValue = Double(self)
                else {
                    return self
            }
            return numberFormatter.string(from: NSNumber(value: doubleValue)) ?? self
        }
        return self
    }
    
    func regex(pattern: String) -> Bool {
        let regexTest = NSPredicate(format: "SELF MATCHES %@", pattern)
        return regexTest.evaluate(with: self)
    }
}

