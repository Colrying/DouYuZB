//
//  GameCellModel.swift
//  DouYuZB
//
//  Created by 皇坤鹏 on 17/5/2.
//  Copyright © 2017年 皇坤鹏. All rights reserved.
//

import UIKit

class GameCellModel: NSObject {
    
    /// 标题名称
    var tag_name : String = ""
    /// 标题图片URL
    var icon_url : String = ""
    /// 标题ID
    var tag_id : Int = 0
    

    
    init(dic : [String : Any]) {
        super.init()
        setValuesForKeys(dic)
    }
    override func setValue(_ value: Any?, forUndefinedKey key: String) {}
}
