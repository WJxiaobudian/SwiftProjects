//
//  ChannelRecommendCell.swift
//  News
//
//  Created by 王洁 on 2018/5/16.
//  Copyright © 2018年 王洁. All rights reserved.
//

import UIKit
import Masonry
class ChannelRecommendCell: UICollectionViewCell {
    let titleButton = UIButton(type: .custom)

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        theme_backgroundColor = "colors.cellBackgroundColor"
        titleButton.theme_backgroundColor = "colors.cellBackgroundColor"
        titleButton.theme_setImage("images.add_channel_titlbar_thin_new_16x16_", forState: .normal)
        titleButton.layer.cornerRadius = 3
        titleButton.layer.shadowColor = UIColor(r: 240, g: 240, b: 240).cgColor
        titleButton.layer.shadowOffset = CGSize(width: 0, height: 0)        //shadowOffset阴影偏移，默认(0, -3),这个跟shadowRadius配合使用
        titleButton.layer.shadowOpacity = 1                                 //阴影透明度，默认0
        titleButton.layer.shadowRadius = 1                                  //阴影半径，默认3
        titleButton.layer.shadowPath = UIBezierPath(rect: bounds).cgPath
        titleButton.setTitle("123", for: .normal)
        titleButton.isUserInteractionEnabled = false
        titleButton.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        titleButton.setTitleColor(UIColor.black, for: .normal)
        self.addSubview(titleButton)
        titleButton.mas_makeConstraints { (make:MASConstraintMaker!) in
            make.top.right().bottom().left().equalTo()(self)
        }
//        self.addSubview(titleButton)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
