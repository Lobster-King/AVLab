//
//  AVLabTool.swift
//  AVLab
//
//  Created by lobster on 2021/9/4.
//

import UIKit
import Foundation
import CoreMedia

let screenH = UIScreen.main.bounds.size.height
let screenW = UIScreen.main.bounds.size.width

//MARK:FourCharCode转换String
extension FourCharCode {
    func toString() -> String {
        let n = Int(self)
        var s: String = String(UnicodeScalar((n >> 24) & 255)!)
        s.append(String(UnicodeScalar((n >> 16) & 255)!))
        s.append(String(UnicodeScalar((n >> 8) & 255)!))
        s.append(String(UnicodeScalar(n & 255)!))
        return s.trimmingCharacters(in: NSCharacterSet.whitespaces)
    }
}

extension CMTime {
    func toString(format: String)-> String {
        let seconds = CMTimeGetSeconds(self)
        let date = Date(timeIntervalSince1970: seconds)
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = TimeZone(identifier: "UTC")
        dateFormatter.dateFormat = format
        return dateFormatter.string(from: date)
    }
}

