//
//  RecommendCycleView.swift
//  DouYuZB
//
//  Created by 皇坤鹏 on 17/4/19.
//  Copyright © 2017年 皇坤鹏. All rights reserved.
//

import UIKit

private let kCycleID = "kCycleID"

class RecommendCycleView: UIView {

    @IBOutlet weak var collectionView: UICollectionView!
    
    @IBOutlet weak var pageControl: UIPageControl!
    
    var timer : Timer?
    
    var cycleDataArray : [RecommendCycleModel]? {
        didSet {
            guard cycleDataArray! == cycleDataArray! else {return}
            // 1. 刷新collectionView
            collectionView.reloadData()
            
            // 2. 配置pageControl
            pageControl.numberOfPages = cycleDataArray!.count
            
            // 3. 让collectionView偏移到中间位置
            collectionView.setContentOffset(CGPoint(x: kScreenW * 30, y: 0), animated: false)
            
            // 3. 初始化定时器
            addCycleTimer()
            
        }
    }
    
    override func awakeFromNib() {
        // 设置该控件不随着父控件的拉伸而拉伸
//        autoresizingMask = UIViewAutoresizing(rawValue: 0)
        
        collectionView.register(UINib(nibName: "RecommendCycleViewCell", bundle: nil), forCellWithReuseIdentifier: kCycleID)
        collectionView.dataSource = self
        collectionView.delegate = self
    }
    
    override func layoutSubviews() {
        let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        layout.itemSize = bounds.size
    }
    
}

extension RecommendCycleView {
    class func recommendCycleView() -> RecommendCycleView {
        return Bundle.main.loadNibNamed("RecommendCycleView", owner: nil, options: nil)?.first as! RecommendCycleView
    }
}

// MARK:- 服从数据源代理
extension RecommendCycleView : UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return (self.cycleDataArray?.count ?? 0) * 1000
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kCycleID, for: indexPath) as! RecommendCycleViewCell
        let model = cycleDataArray![indexPath.row % cycleDataArray!.count]
        cell.cycleModel = model
        return cell
    }
    
}

extension RecommendCycleView : UICollectionViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        // 1. 获取当前偏移量
        let offsetX = scrollView.contentOffset.x
        
        // 2. 计算偏移的多少
        let index = Int(offsetX / kScreenW) % (self.cycleDataArray?.count ?? 1)!
        
        // 3. 设置pagecontrol
        pageControl.currentPage = index
    }
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        removeCycleTimer()
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        addCycleTimer()
    }
}

// MARK:- 定时器配置
extension RecommendCycleView {
    func addCycleTimer() {
        timer = Timer.scheduledTimer(timeInterval: 3.0, target: self, selector: #selector(self.scrollTotNext), userInfo: nil, repeats: true)
    }
    
    func removeCycleTimer() {
        timer?.invalidate()
        timer = nil
    }
    
    func scrollTotNext() {
        
        let offsetX = collectionView.contentOffset.x + collectionView.bounds.size.width
        collectionView.setContentOffset(CGPoint(x: offsetX, y: 0), animated: true)
    }
}



