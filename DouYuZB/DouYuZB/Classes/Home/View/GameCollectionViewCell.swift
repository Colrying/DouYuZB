//
//  GameCollectionViewCell.swift
//  DouYuZB
//
//  Created by 皇坤鹏 on 17/5/2.
//  Copyright © 2017年 皇坤鹏. All rights reserved.
//

import UIKit

class GameCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var titleImageView: UIImageView!
    
    @IBOutlet weak var titleLabel: UILabel!

    @IBOutlet weak var bottomLine: UIView!
    
    var gameModel : GameCellModel? {
        didSet {
            titleImageView.kf.setImage(with: URL(string: (gameModel?.icon_url)!))
            titleLabel.text = gameModel?.tag_name
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
