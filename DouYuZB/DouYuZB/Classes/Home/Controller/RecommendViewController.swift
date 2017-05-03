//
//  RecommendViewController.swift
//  DouYuZB
//
//  Created by 皇坤鹏 on 17/4/13.
//  Copyright © 2017年 皇坤鹏. All rights reserved.
//

import UIKit

private let kItemMargin : CGFloat = 10
private let kItemW : CGFloat = (kScreenW - 3 * kItemMargin) / 2
private let kItemNormalH : CGFloat = kItemW * 3 / 4
private let kItemPrettyH : CGFloat = kItemW * 4 / 3
private let kItemHeaderViewH : CGFloat = 50
private let kCycleViewH : CGFloat = kScreenW * 3 / 8
private let kItemNormalID = "kItemNormalID"
private let kItemPrettyID = "kItemPrettyID"
private let kItemHeaderID = "kItemHeaderID"

class RecommendViewController: UIViewController {

    // MARK:- 懒加载
    lazy var collectionView : UICollectionView = {[weak self] in
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: kItemW, height: kItemNormalH)
        layout.headerReferenceSize = CGSize(width: kScreenW, height: kItemHeaderViewH)
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = kItemMargin
        layout.sectionInset = UIEdgeInsets(top: 0, left: kItemMargin, bottom: 0, right: kItemMargin)
        
        let frame = CGRect(x: 0, y: 0, width: kScreenW, height: kScreenH - kStatusBarH - kNavigationBarH - 40 - kTabbarH)
        let collectionView = UICollectionView(frame: frame, collectionViewLayout: layout)
        collectionView.backgroundColor = UIColor.white
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(UINib(nibName: "CollectionNormalCell", bundle: nil), forCellWithReuseIdentifier: kItemNormalID)
        collectionView.register(UINib(nibName: "CollectionPrettyCell", bundle: nil), forCellWithReuseIdentifier: kItemPrettyID)
        collectionView.register(UINib(nibName: "CollectionHeaderView", bundle: nil), forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: kItemHeaderID)
        collectionView.contentInset = UIEdgeInsets(top: kCycleViewH, left: 0, bottom: 0, right: 0)
        collectionView.autoresizingMask = [.flexibleWidth, .flexibleWidth]
        return collectionView
    }()
    lazy var recommendVM : RecommendViewModel = RecommendViewModel()
    lazy var recommendCycleView : RecommendCycleView = {
        let recommendCycleView = RecommendCycleView.recommendCycleView()
        recommendCycleView.frame = CGRect(x: 0, y: -kCycleViewH, width: kScreenW, height: kCycleViewH)
        return recommendCycleView
    }()
    
    // MARK:- 系统回调函数
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        
        // 1. 布局UI
        setupUI()
        
        // 2. 请求数据
        requestData()
    }
}

// MARK:- 请求数据
extension RecommendViewController {
    
    func requestData() {
        recommendVM.requestData { 
            self.collectionView.reloadData()
        }
        
        recommendVM.requestCycleViewData {
            self.recommendCycleView.cycleDataArray = self.recommendVM.cycleDataArray
        }
    }
    
}

// MARK:- 设置UI
extension RecommendViewController {
    func setupUI() {
        // 1. 添加collectionView
        view.addSubview(collectionView)
        
        // 2. 添加无线轮播图
        collectionView.addSubview(recommendCycleView)
    }
}

// MARK:- 遵守UICollectionViewDatasource协议
extension RecommendViewController : UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return recommendVM.totalDataArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return recommendVM.totalDataArray[section].anchor_list.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.section == 1 {
            let item = collectionView.dequeueReusableCell(withReuseIdentifier: kItemPrettyID, for: indexPath) as! CollectionPrettyCell
            let anchor = recommendVM.totalDataArray[indexPath.section].anchor_list[indexPath.row]
            item.anchor = anchor
            return item
        } else {
            let item = collectionView.dequeueReusableCell(withReuseIdentifier: kItemNormalID, for: indexPath) as! CollectionNormalCell
            let anchor = recommendVM.totalDataArray[indexPath.section].anchor_list[indexPath.row]
            item.anchor = anchor
            return item
            
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionElementKindSectionHeader, withReuseIdentifier: kItemHeaderID, for: indexPath) as! CollectionHeaderView
        let anchorGroup = recommendVM.totalDataArray[indexPath.section]
        headerView.anchorGroup = anchorGroup
        return headerView
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if indexPath.section == 1 {
            return CGSize(width: kItemW, height: kItemPrettyH)
        }
        return CGSize(width: kItemW, height: kItemNormalH)
    }
}

extension RecommendViewController : UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let anchor = recommendVM.totalDataArray[indexPath.section].anchor_list[indexPath.row]
        print("点击房间id\(anchor.room_id),类型\(anchor.isVertical)")
    }
}

