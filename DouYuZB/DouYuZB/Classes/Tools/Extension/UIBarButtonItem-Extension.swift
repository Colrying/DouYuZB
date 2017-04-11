//
//  UIBarButtonItem-Extension.swift
//  DouYuZB
//
//  Created by 皇坤鹏 on 17/4/11.
//  Copyright © 2017年 皇坤鹏. All rights reserved.
//

import UIKit

extension UIBarButtonItem {
    
    // 构造方法
    convenience init(imageName:String, hightImageName:String = "", size:CGSize = .zero) {
        let btn = UIButton();
        btn.setImage(UIImage(named:imageName), for: .normal);
        if hightImageName != "" {
            btn.setImage(UIImage(named:hightImageName), for: .highlighted);
        }
        if size == .zero {
            btn.sizeToFit();
        } else {
            btn.frame = CGRect(origin: .zero, size: size);
        }
        self.init(customView : btn);
    }
    
}
