//
//  PageTitleView.swift
//  DouYuZB
//
//  Created by 皇坤鹏 on 17/4/11.
//  Copyright © 2017年 皇坤鹏. All rights reserved.
//

import UIKit


let kScrollLineH : CGFloat = 2

class PageTitleView: UIView {

    // MARK:- 定义属性
    var titles : [String]
    
    // MARK:- 懒加载
    lazy var titleLabels : [UILabel] = [UILabel]()
    lazy var scrollView : UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.scrollsToTop = false
        scrollView.bounces = false
        return scrollView
    }()
    lazy var scrollLine : UIView = {
        let scrollLine = UIView()
        scrollLine.backgroundColor = UIColor.orange
        return scrollLine
    }()
    
    // MARK:- 自定义构造函数
    init(frame: CGRect, titles : [String]) {
        self.titles = titles
        super.init(frame: frame)
        
        // 1. 设置UI界面
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

extension PageTitleView {
    
    func setupUI() {
        // 1. 添加UIScrollView
        addSubview(scrollView)
        scrollView.frame = bounds
        
        // 2. 添加title对应的label
        addTitlesLabel()
        
        // 3. 添加底线和滑线
        addBottomLineAndScrollLine()
    }
    
    func addTitlesLabel() {
        // 创建label
        for (index, title) in titles.enumerated() {
            let label = UILabel()
            // 1. 设置label的属性
            label.text = title
            label.textAlignment = .center
            label.textColor = UIColor.darkGray
            label.font = UIFont.systemFont(ofSize: 16)
            label.tag = index
            
            // 2. 设置label的frame
            let labelW : CGFloat = frame.size.width / CGFloat(titles.count)
            let labelX : CGFloat = CGFloat(index) * labelW
            let labelY : CGFloat = 0
            let labelH : CGFloat = frame.size.height - kScrollLineH
            label.frame = CGRect(x: labelX, y: labelY, width: labelW, height: labelH)
            
            // 3. 添加到view上
            scrollView.addSubview(label)
            titleLabels.append(label)
        }
    }
    
    func addBottomLineAndScrollLine() {
        // 1. 添加bottomLine
        let bottomLine = UIView()
        bottomLine.backgroundColor = UIColor.lightGray
        bottomLine.frame = CGRect(x: 0, y: frame.size.height - 0.5, width: frame.size.width, height: 0.5);
        addSubview(bottomLine);
        
        // 2. 添加scrollLine
        // 2.1. 获取第一个label
        guard let firstLabel = titleLabels.first else {return}
        firstLabel.textColor = UIColor.orange
        
        // 2.2 设置frame
        scrollView.addSubview(scrollLine)
        scrollLine.frame = CGRect(x: firstLabel.frame.origin.x, y: frame.height - kScrollLineH, width: firstLabel.frame.size.width, height: kScrollLineH)
    }
    
    
}
