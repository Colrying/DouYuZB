//
//  NSDate-Extension.swift
//  DouYuZB
//
//  Created by 皇坤鹏 on 17/4/13.
//  Copyright © 2017年 皇坤鹏. All rights reserved.
//

import Foundation
extension NSDate {
    class func getCurrentTime() -> String {
        let date = NSDate()
        let instDate = Int(date.timeIntervalSince1970)
        return "\(instDate)"
    }
}
