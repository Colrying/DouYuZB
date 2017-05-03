//
//  PageTitleView.swift
//  DouYuZB
//
//  Created by 皇坤鹏 on 17/4/11.
//  Copyright © 2017年 皇坤鹏. All rights reserved.
//

import UIKit


let kScrollLineH : CGFloat = 2
let kNormalColor : (CGFloat, CGFloat, CGFloat) = (85, 85, 85)
let kSelectColor : (CGFloat, CGFloat, CGFloat) = (253, 119, 34)

protocol PageTitleViewDelegate : class {
    func pageTitleView(titleView : PageTitleView, currentIndex index : Int)
}

class PageTitleView: UIView {

    // MARK:- 定义属性
    var titles : [String]
    var currentIndex : Int = 0
    weak var delegate : PageTitleViewDelegate?
    
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
            label.textColor = UIColor(r: kNormalColor.0, g: kNormalColor.1, b: kNormalColor.2)
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
            
            // 4. 给label添加手势
            label.isUserInteractionEnabled = true
            let panGes = UITapGestureRecognizer(target: self, action: #selector(titleLabelClick(panGes:)))
            label.addGestureRecognizer(panGes)
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
        firstLabel.textColor = UIColor(r: kSelectColor.0, g: kSelectColor.1, b: kSelectColor.2)
        
        // 2.2 设置frame
        scrollView.addSubview(scrollLine)
        scrollLine.frame = CGRect(x: firstLabel.frame.origin.x, y: frame.height - kScrollLineH, width: firstLabel.frame.size.width, height: kScrollLineH)
    }
}

// MARK:- 监听label的点击
extension PageTitleView {
    @objc func titleLabelClick(panGes : UITapGestureRecognizer) {
        if panGes.view?.tag == currentIndex { return }
        // 1. 改变当前label的颜色
        let currentLabel = panGes.view as! UILabel
        
        // 2. 改变当前label的颜色为橘色
        currentLabel.textColor = UIColor(r: kSelectColor.0, g: kSelectColor.1, b: kSelectColor.2)
        
        // 3. 改变之前label的颜色为灰色
        let oldLabel = titleLabels[currentIndex]
        oldLabel.textColor = UIColor(r: kNormalColor.0, g: kNormalColor.1, b: kNormalColor.2)
        
        // 4. 保存当前label
        currentIndex = currentLabel.tag
        
        // 5. 改变scrollLine的位置
        let offSet = CGFloat(currentIndex) * currentLabel.frame.size.width
        UIView.animate(withDuration: 0.15) {
            self.scrollLine.frame.origin.x = offSet
        }
        
        // 6. 通知代理
        delegate?.pageTitleView(titleView: self, currentIndex: currentIndex)
    }
}

// MARK:- 字体渐变和scrollLine滑动
extension PageTitleView {
    
    func setupTitleColorAndScrollLine(progress: CGFloat, sourceIndex: Int, targetIndex: Int) {
        // 1. 获取目标label
        let targetLabel = titleLabels[targetIndex]
        
        // 2. 获取原始label
        let sourceLabel = titleLabels[sourceIndex]
        
        // 3. 改变scrollLine位置
        let moveTotalX = targetLabel.frame.origin.x - sourceLabel.frame.origin.x
        let moveX = moveTotalX * progress
        scrollLine.frame.origin.x = sourceLabel.frame.origin.x + moveX
        
        // 4. 字体渐变颜色范围
        let colorDelta = (kSelectColor.0 - kNormalColor.0, kSelectColor.1 - kNormalColor.1, kSelectColor.2 - kNormalColor.2)
        
        // 5. 改变颜色
        sourceLabel.textColor = UIColor(r: kSelectColor.0 - colorDelta.0 * progress, g: kSelectColor.1 - colorDelta.1 * progress, b: kSelectColor.2 - colorDelta.2 * progress)
        
        targetLabel.textColor = UIColor(r: kNormalColor.0 + colorDelta.0 * progress, g: kNormalColor.1 + colorDelta.1 * progress, b: kNormalColor.2 + colorDelta.2 * progress)
        
        // 6. 重新指定当前currentIndex
        currentIndex = targetIndex
    }
    
}

