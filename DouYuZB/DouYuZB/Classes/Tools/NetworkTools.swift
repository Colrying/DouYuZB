//
//  NetworkTools.swift
//  DouYuZB
//
//  Created by 皇坤鹏 on 17/4/13.
//  Copyright © 2017年 皇坤鹏. All rights reserved.
//

import UIKit
import Alamofire
enum MethodType {
    case GET
    case POST
}

// 删除集成，更轻量级
class NetworkTools {

    class func requestData(type: MethodType, urlString: String, parameters: [String: Any], finishedCallback: @escaping (_ result : AnyObject) -> ()) {
        // 1. 获取类型
        let method = type == .GET ? HTTPMethod.get : HTTPMethod.post
        
        Alamofire.request(urlString, method: method, parameters: parameters).responseJSON { (response) in
            guard let result = response.result.value else {
                print(response.result.error!)
                return
            }
            
            // 回调结果
            finishedCallback(result as AnyObject)
        }
    }
    
}
