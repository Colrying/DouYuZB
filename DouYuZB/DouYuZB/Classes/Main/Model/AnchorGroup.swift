//
//  AnchorGroup.swift
//  DouYuZB
//
//  Created by 皇坤鹏 on 17/4/13.
//  Copyright © 2017年 皇坤鹏. All rights reserved.
//

import UIKit

class AnchorGroup: NSObject {
    
    /// 房间类别
    var tag_name : String = ""
    /// 类别图片
    var icon_name : String = "home_header_normal"
    /// 组中的房间信息
    var room_list : [[String : NSObject]]? {
        didSet {
            for dic:[String : NSObject] in room_list! {
                let anchor = AnchorModel(dic: dic)
                anchor_list.append(anchor)
            }
        }
    }
    
    /// 存储分组下主播对象的数组
    lazy var anchor_list : [AnchorModel] = [AnchorModel]()
    
    // MARK:- 自定义构造方法
    init(dict : [String : NSObject]) {
        super.init()
        setValuesForKeys(dict)
    }
    override func setValue(_ value: Any?, forUndefinedKey key: String) {}
}
