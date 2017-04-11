//
//  HomeViewController.swift
//  DouYuZB
//
//  Created by 皇坤鹏 on 17/4/11.
//  Copyright © 2017年 皇坤鹏. All rights reserved.
//

import UIKit

private var kPageTitleViewH : CGFloat = 40

class HomeViewController: UIViewController {

    // MARK:- 懒加载属性
    lazy var pageTitleView : PageTitleView = {
        let titleFrame = CGRect(x: 0, y: kStatusBarH + kNavigationBarH, width: kScreenW, height: kPageTitleViewH)
        let titles = ["推荐", "游戏", "娱乐", "趣玩"]
        let titleView = PageTitleView(frame: titleFrame, titles: titles)
        return titleView
    }()
    
    // MARK:- 系统回调函数
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI();
        
    }
}

// MARK:- 设置UI界面
extension HomeViewController {
    
    func setupUI() {
        // 0. 关闭scrollView自动设置内边距属性
        automaticallyAdjustsScrollViewInsets = false
        
        // 1. 设置导航栏
        setupNavigationBar();
        
        // 2. 设置titleView
        view.addSubview(pageTitleView)
    }
    
    func setupNavigationBar() {
        // 1. 设置左侧item
        navigationItem.leftBarButtonItem = UIBarButtonItem(imageName: "logo");
        
        // 2. 设置右侧item
        let size = CGSize(width: 40, height: 40);
        let hestoryItem = UIBarButtonItem(imageName: "image_my_history", hightImageName: "Image_my_history_click", size: size);
        let searchItem = UIBarButtonItem(imageName: "btn_search", hightImageName: "btn_search_clicked", size: size);
        let qrcodeItem = UIBarButtonItem(imageName: "Image_scan", hightImageName: "Image_scan_click", size: size);
        navigationItem.rightBarButtonItems = [hestoryItem, searchItem, qrcodeItem];
    }
    
    
}
