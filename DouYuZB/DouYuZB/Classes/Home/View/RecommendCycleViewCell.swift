//
//  RecommendCycleViewCell.swift
//  DouYuZB
//
//  Created by 皇坤鹏 on 17/4/19.
//  Copyright © 2017年 皇坤鹏. All rights reserved.
//

import UIKit

class RecommendCycleViewCell: UICollectionViewCell {

    @IBOutlet weak var backImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    
    var cycleModel : RecommendCycleModel? {
        didSet {
            titleLabel.text = cycleModel?.title
            
            backImageView.kf.setImage(with: URL(string: (cycleModel?.pic_url)!))
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        
    }
    
    class func recommendCycleViewCell() -> RecommendCycleViewCell {
        return Bundle.main.loadNibNamed("RecommendCycleViewCell", owner: nil, options: nil)?.first as! RecommendCycleViewCell
    }
    
}
