//
//  CollectionNormalCell.swift
//  DouYuZB
//
//  Created by 皇坤鹏 on 17/4/13.
//  Copyright © 2017年 皇坤鹏. All rights reserved.
//

import UIKit
import Kingfisher

class CollectionNormalCell: UICollectionViewCell {
    
    @IBOutlet weak var roomImageView: UIImageView!
    @IBOutlet weak var nicknameLabel: UILabel!
    @IBOutlet weak var onlineBtn: UIButton!
    @IBOutlet weak var roomNameLabel: UILabel!
    
    var anchor : AnchorModel? {
        didSet {
            // 主播昵称
            nicknameLabel.text = anchor?.nickname
            
            // 在线人数
            onlineBtn.setTitle("\(anchor!.online)在线", for: .normal)
            
            // 房间名字
            roomNameLabel.text = anchor?.room_name
            
            // 房间背景图
            let url = URL(string: (anchor?.vertical_src)!)
            roomImageView.kf.setImage(with: url)
        }
    }
    
    
}
