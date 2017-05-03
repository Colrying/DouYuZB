//
//  PageContentView.swift
//  DouYuZB
//
//  Created by 皇坤鹏 on 17/4/12.
//  Copyright © 2017年 皇坤鹏. All rights reserved.
//

import UIKit

let contentCellID = "contentCellID"

protocol PageContentViewDelegate : class {
    func contentView(progress : CGFloat, sourceIndex : Int, targetIndex : Int)
}

class PageContentView: UIView {

    // MARK:- 定义属性
    var chlidVcs = [UIViewController]()
    weak var parentViewController = UIViewController()
    var startOffsetX : CGFloat = 0
    weak var delegate : PageContentViewDelegate?
    var isForbidContentViewDelegate : Bool = false
    
    // MARK:- 懒加载
    lazy var collectionView : UICollectionView = { [weak self] in
        // 1. 创建layout
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.itemSize = (self?.bounds.size)!
        flowLayout.minimumLineSpacing = 0
        flowLayout.minimumInteritemSpacing = 0
        flowLayout.scrollDirection = .horizontal
        
        // 2. 创建collectionView
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        collectionView.isPagingEnabled = true
        collectionView.bounces = false
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: contentCellID)
        
        return collectionView
    }()
    
    
    // MARK:- 自定义构造函数
    init(frame: CGRect, childVcs: [UIViewController], parentViewController: UIViewController?) {
        self.chlidVcs = childVcs
        self.parentViewController = parentViewController
        super.init(frame: frame)
        
        // 1. 设置UI
        setupUI()
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

// MARK:- 布局UI
extension PageContentView {
    func setupUI() {
        // 1. 将所有的子控制器添加到父控制器上
        for childVc in chlidVcs {
            parentViewController!.addChildViewController(childVc)
        }
        
        // 2. 添加collectionView
        addSubview(collectionView)
        collectionView.frame = self.bounds
    }
}

// MARK:- 代理UICollectionViewDataSource
extension PageContentView : UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return chlidVcs.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: contentCellID, for: indexPath)
        for view in cell.contentView.subviews {
            view.removeFromSuperview()
        }
        let vc = chlidVcs[indexPath.row]
        cell.contentView.addSubview(vc.view)
        return cell
    }
}

// MARK:- 代理UICollectionViewDelegate
extension PageContentView : UICollectionViewDelegate {
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        startOffsetX = scrollView.contentOffset.x
        
        // 打开滑动代理
        isForbidContentViewDelegate = false
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        // 0. 判断是否允许执行此方法
        if isForbidContentViewDelegate { return }
        
        // 1. 定义属性
        var progress : CGFloat = 0
        var sourceIndex : Int = 0
        var targetIndex : Int = 0
        
        // 2. 判断是左滑还是右滑动
        let currentOffsetX = scrollView.contentOffset.x
        let scrollViewW = scrollView.bounds.width
        if currentOffsetX > startOffsetX { // 左滑
            // 1. 计算progress
            progress = currentOffsetX / scrollViewW - floor(currentOffsetX / scrollViewW)
            
            // 2. 计算sourceIndex
            sourceIndex = Int(currentOffsetX / scrollViewW)
            
            // 3. 计算targetIndex
            targetIndex = sourceIndex + 1
            if targetIndex >= chlidVcs.count-1 {
                targetIndex = chlidVcs.count-1
            }
            
            // 4. 如果完全滑过去
            if currentOffsetX - startOffsetX == scrollViewW {
                progress = 1
                targetIndex = sourceIndex
            }
            
        } else { // 右滑
            // 1. 计算progress
            progress = 1 - (currentOffsetX / scrollViewW - floor(currentOffsetX / scrollViewW))
            
            // 2. 计算sourceIndex
            targetIndex = Int(currentOffsetX / scrollViewW)
            
            // 3. 计算targetIndex
            sourceIndex = targetIndex + 1
            if sourceIndex >= chlidVcs.count - 1 {
                sourceIndex = chlidVcs.count - 1
            }
        }
        
        delegate?.contentView(progress: progress, sourceIndex: sourceIndex, targetIndex: targetIndex)
    }
}


// MARK:- 设置contentView的偏移
extension PageContentView {
    func setupPageOffset(index : Int) {
        // 禁止滑动的代理方法
        isForbidContentViewDelegate = true
        
        let offsetX : CGFloat = CGFloat(index) * collectionView.frame.width
        collectionView.contentOffset = CGPoint(x: offsetX, y: 0)
    }
}

