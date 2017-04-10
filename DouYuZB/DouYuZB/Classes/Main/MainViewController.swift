//
//  MainViewController.swift
//  DouYuZB
//
//  Created by 皇坤鹏 on 17/4/10.
//  Copyright © 2017年 皇坤鹏. All rights reserved.
//

import UIKit

class MainViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        addChildVC(storyName: "Home");
        addChildVC(storyName: "Live");
        addChildVC(storyName: "Follow");
        addChildVC(storyName: "Profile");
        
    }
    
    private func addChildVC(storyName : String) {
        // 1. 获取子视图控制器
        let childVC = UIStoryboard(name: storyName, bundle: nil).instantiateInitialViewController()!;
        // 2. 添加
        addChildViewController(childVC);
    }
    
}
