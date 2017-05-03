//
//  AnchorModel.swift
//  DouYuZB
//
//  Created by 皇坤鹏 on 17/4/13.
//  Copyright © 2017年 皇坤鹏. All rights reserved.
//

import UIKit

class AnchorModel: NSObject {
    // MARK:- 共有属性
    /// 房间ID
    var room_id : Int = 0
    /// 房间名称
    var room_name : String = ""
    /// 直播类型 0:电脑直播 1:手机直播
    var isVertical : Int = 0
    /// 房间对应URL
    var vertical_src : String = ""
    /// 在线人数
    var online : Int = 0
    /// 主播昵称
    var nickname : String = ""
    
    // MARK:- 特殊属性
    /// 所在城市
    var anchor_city : String = ""
    
    
    
    
    // MARK:- 自定义构造函数
    init(dic : [String : NSObject]) {
        super.init()
        setValuesForKeys(dic)
    }
    override func setValue(_ value: Any?, forUndefinedKey key: String) {}
    
}
