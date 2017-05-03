//
//  CollectionHeaderView.swift
//  DouYuZB
//
//  Created by 皇坤鹏 on 17/4/13.
//  Copyright © 2017年 皇坤鹏. All rights reserved.
//

import UIKit

class CollectionHeaderView: UICollectionReusableView {

    @IBOutlet weak var typeImageView: UIImageView!
    @IBOutlet weak var typeTitleLabel: UILabel!
    
    var anchorGroup : AnchorGroup? {
        didSet {
            
            typeImageView.image = UIImage(named: (anchorGroup?.icon_name)!)
            
            typeTitleLabel.text = anchorGroup?.tag_name
        }
    }
    
}
