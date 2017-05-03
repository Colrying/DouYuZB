//
//  CollectionCycleView.swift
//  DouYuZB
//
//  Created by 皇坤鹏 on 17/5/3.
//  Copyright © 2017年 皇坤鹏. All rights reserved.
//

import UIKit

fileprivate let itemW = kScreenW / 4.5
fileprivate let itemH = itemW
fileprivate let itemCycleViewID = "itemCycleViewID"

class CollectionCycleView: UIView {

    var dataArray : [GameCellModel]? {
        didSet {
            collectionView.reloadData()
        }
    }
    
    fileprivate lazy var collectionView : UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.itemSize = CGSize(width: itemW, height: itemH)
        layout.sectionInset = UIEdgeInsets(top: 5, left: 0, bottom: 0, right: 0)
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: CGRect(x: 0, y: 0, width: kScreenW, height: itemH), collectionViewLayout: layout)
        collectionView.backgroundColor = UIColor.white
        collectionView.dataSource = self
        collectionView.register(UINib(nibName: "GameCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: itemCycleViewID)
        return collectionView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

extension CollectionCycleView {
    
    func setupUI() {
        backgroundColor = UIColor.white
        addSubview(self.collectionView)
    }
    
}

extension CollectionCycleView : UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataArray!.count / 4
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: itemCycleViewID, for: indexPath) as! GameCollectionViewCell
        let model = dataArray?[indexPath.row]
        cell.gameModel = model
        cell.bottomLine.isHidden = true
        return cell
    }
}
