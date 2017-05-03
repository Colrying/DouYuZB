//
//  CollectionPrettyCell.swift
//  DouYuZB
//
//  Created by 皇坤鹏 on 17/4/13.
//  Copyright © 2017年 皇坤鹏. All rights reserved.
//

import UIKit

class CollectionPrettyCell: UICollectionViewCell {

    @IBOutlet weak var roomImageView: UIImageView!
    @IBOutlet weak var onlineLabel: UILabel!
    
    @IBOutlet weak var roomNameLabel: UILabel!
    
    @IBOutlet weak var addressBtn: UIButton!
    
    var anchor : AnchorModel? {
        didSet {
            // 背景图片
            roomImageView.kf.setImage(with: URL(string: (anchor?.vertical_src)!))
            
            // 在线人数
            onlineLabel.text = "\(anchor!.online)在线"
            
            // 房间名字
            roomNameLabel.text = anchor?.room_name
            
            // 地址
            addressBtn.setTitle(anchor?.anchor_city, for: .normal)
            
        }
    }
    
}
