//
//  UIColor-Extension.swift
//  DouYuZB
//
//  Created by 皇坤鹏 on 17/4/12.
//  Copyright © 2017年 皇坤鹏. All rights reserved.
//

import UIKit

extension UIColor {
    
    // MARK:- 自定义构造方法
    convenience init(r: CGFloat, g: CGFloat, b:CGFloat) {
        self.init(red: r / 255.0, green: g / 255.0, blue: b / 255.0, alpha: 1.0)
    }
    
}

