//
//  RecommendViewModel.swift
//  DouYuZB
//
//  Created by 皇坤鹏 on 17/4/13.
//  Copyright © 2017年 皇坤鹏. All rights reserved.
//

import UIKit

class RecommendViewModel: NSObject {
    
    lazy var totalDataArray : [AnchorGroup] = [AnchorGroup]()
    
    lazy var cycleDataArray : [RecommendCycleModel] = [RecommendCycleModel]()
    
    lazy var hotDataGroup = AnchorGroup(dict: ["" : "" as NSObject])
    
    lazy var prettyDataGroup = AnchorGroup(dict: ["" : "" as NSObject])
    
    func requestData(requestSuccess: @escaping() -> ()) {
        
        // 创建线程group
        let dis_group = DispatchGroup()
        
        // 请求推荐数据
        dis_group.enter() // 进入线程
        NetworkTools.requestData(type: .GET, urlString: "https://capi.douyucdn.cn/api/v1/getbigDataRoom", parameters: ["time" : NSDate.getCurrentTime()]) { (result) in
            guard let resultDic = result as? [String : NSObject] else {return}
            
            guard let dataArr = resultDic["data"] as? [[String : NSObject]] else {return}
            
            self.hotDataGroup.icon_name = "home_header_hot"
            self.hotDataGroup.tag_name = "热门"
            for dic in dataArr {
                let anchor = AnchorModel(dic: dic)
                self.hotDataGroup.anchor_list.append(anchor)
            }
            dis_group.leave() // 离开线程
        }
        
        // 请求颜值数据
        dis_group.enter()
        NetworkTools.requestData(type: .GET, urlString: "https://capi.douyucdn.cn/api/v1/getVerticalRoom", parameters: ["limit" : "4","offset":"0","time":NSDate.getCurrentTime()]) { (result) in
            guard let resultDic = result as? [String : NSObject] else {return}
            
            guard let dataArr = resultDic["data"] as? [[String : NSObject]] else {return}
            
            self.prettyDataGroup.icon_name = "home_header_phone"
            self.prettyDataGroup.tag_name = "颜值"
            for dic in dataArr {
                let anchor = AnchorModel(dic: dic)
                self.prettyDataGroup.anchor_list.append(anchor)
            }
            dis_group.leave()
        }
        
        // 请求后面所有数据
        dis_group.enter()
        NetworkTools.requestData(type: .GET, urlString: "https://capi.douyucdn.cn/api/v1/getHotCate", parameters: ["limit" : "4","offset":"0","time":NSDate.getCurrentTime()]) {(result) in
            
            // 1.获取到数据
            guard let resultDict = result as? [String : Any] else {return}
            guard let dataArray = resultDict["data"] as? [[String : Any]] else {return}
            
            // 2. 判断是否是分组数据
            // 2.1 字典转模型
            for dict in dataArray {
                self.totalDataArray.append(AnchorGroup(dict: dict as! [String : NSObject]))
            }
            
            // 离开线程
            dis_group.leave()
        }
        
        dis_group.notify(queue: DispatchQueue.main) {
            self.totalDataArray.insert(self.prettyDataGroup, at: 0)
            self.totalDataArray.insert(self.hotDataGroup, at: 0)
            requestSuccess()
        }
        
    }
    
    // MARK:- 请求轮播图数据 http://capi.douyucdn.cn/api/v1/slide/6?version=2.300
    func requestCycleViewData(requestSuccess: @escaping() -> ()) {
        NetworkTools.requestData(type: .GET, urlString: "http://capi.douyucdn.cn/api/v1/slide/6", parameters: ["version" : "2.300"]) { (result) in
            guard let resultDic = result as? [NSString : NSObject] else {return}
            guard let dataArr = resultDic["data"] as? [[NSString : NSObject]] else {return}
            for dic in dataArr {
                let model = RecommendCycleModel(dic: dic)
                self.cycleDataArray.append(model)
            }
            requestSuccess()
        }
    }
    
}
