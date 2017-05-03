//
//  GameViewController.swift
//  DouYuZB
//
//  Created by 皇坤鹏 on 17/5/2.
//  Copyright © 2017年 皇坤鹏. All rights reserved.
//

import UIKit

fileprivate let itemW = (kScreenW-20) / 3
fileprivate let itemH = itemW
fileprivate let itemID = "itemID"
fileprivate let sectionHeaderID = "sectionHeaderID"
fileprivate let sectionFooterID = "sectionFooterID"
fileprivate let collectionViewH = kScreenH - kTabbarH - kNavigationBarH - kStatusBarH - 50

class GameViewController: UIViewController {

    var collectionView : UICollectionView?
    
    fileprivate lazy var gameViewModel : GameViewModel = GameViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        
        setupUI()
        
        requestData()
        
    }
    
}

// MARK:- UI布局
extension GameViewController {
    fileprivate func setupUI() {
        let layout : UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.headerReferenceSize = CGSize(width: kScreenW, height: 40)
        layout.itemSize = CGSize(width: itemW, height: itemH)
        layout.sectionInset = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
        collectionView = UICollectionView(frame: CGRect(x: 0, y: 0, width: kScreenW, height: collectionViewH), collectionViewLayout: layout)
        collectionView?.backgroundColor = UIColor.white
        collectionView?.dataSource = self
        collectionView?.delegate = self
        view.addSubview(collectionView!)
        collectionView?.register(UINib(nibName: "GameCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: itemID)
        collectionView?.register(UINib(nibName: "GameSectionHeaderView", bundle: nil), forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: sectionHeaderID)
        collectionView?.register(UICollectionReusableView.self, forSupplementaryViewOfKind:UICollectionElementKindSectionFooter, withReuseIdentifier: sectionFooterID)
    }
}

// MARK:- 请求数据
extension GameViewController {
    fileprivate func requestData() {
        gameViewModel.requestData { 
            self.collectionView?.reloadData()
        }
    }
}

// MARK:- 数据源方法
extension GameViewController : UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return section == 0 ? 0 : gameViewModel.dataSource.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: itemID, for: indexPath) as! GameCollectionViewCell
        cell.gameModel = gameViewModel.dataSource[indexPath.row]
        cell.bottomLine.isHidden = false
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == UICollectionElementKindSectionHeader {
            let reusableView = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionElementKindSectionHeader, withReuseIdentifier: sectionHeaderID, for: indexPath) as! GameSectionHeaderView
            reusableView.titleLabel.text = indexPath.section == 0 ? "常见" : "全部"
            return reusableView
        } else {
            let reusableView = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionElementKindSectionFooter, withReuseIdentifier: sectionFooterID, for: indexPath)
            let cycleView = CollectionCycleView.init(frame: reusableView.bounds)
            cycleView.dataArray = gameViewModel.dataSource
            reusableView.addSubview(cycleView)
            return reusableView
        }
    }
}

extension GameViewController : UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        return section == 0 ? CGSize(width: kScreenW, height: kScreenW / 4) : .zero
    }
}

