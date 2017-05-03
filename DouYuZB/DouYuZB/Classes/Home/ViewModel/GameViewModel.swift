//
//  GameViewModel.swift
//  DouYuZB
//
//  Created by 皇坤鹏 on 17/5/2.
//  Copyright © 2017年 皇坤鹏. All rights reserved.
//

import UIKit

class GameViewModel: NSObject {
    
    lazy var dataSource : [GameCellModel] = [GameCellModel]()
    
    
    func requestData(finishedCallBack : @escaping () -> ()) {
        NetworkTools.requestData(type: .GET, urlString: "http://capi.douyucdn.cn/api/v1/getColumnDetail", parameters: ["shortName" : "game"]) { (result) in
            var dataDic : [String : Any] = result as! [String : Any]
            let dataArr = dataDic["data"] as! [[String : Any]]
            for dic in dataArr {
                let gameModel = GameCellModel(dic: dic as [String : Any])
                self.dataSource.append(gameModel)
            }
            finishedCallBack()
        }
    }
}
