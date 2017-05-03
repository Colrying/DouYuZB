//
//  RecommendCycleModel.swift
//  DouYuZB
//
//  Created by 皇坤鹏 on 17/4/19.
//  Copyright © 2017年 皇坤鹏. All rights reserved.
//

import UIKit

class RecommendCycleModel: NSObject {
    /// 标题
    var title : String = ""
    
    /// 图片url
    var pic_url : String = ""
    
    /// 对应的房间信息
    var room : [NSString : NSObject]? {
        didSet {
            guard let room = room else {return}
            anchor = AnchorModel.init(dic: room as [String : NSObject])
        }
    }
    
    /// 房间信息对应的模型
    var anchor : AnchorModel?
    
    init(dic : [NSString : NSObject]) {
        super.init()
        setValuesForKeys(dic as [String : Any])
    }
    override func setValue(_ value: Any?, forUndefinedKey key: String) {}
}
