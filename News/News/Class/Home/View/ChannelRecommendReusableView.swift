//
//  ChannelRecommendReusableView.swift
//  News
//
//  Created by WJ on 2018/5/16.
//  Copyright © 2018年 WJ. All rights reserved.
//

import UIKit
import Masonry
class ChannelRecommendReusableView: UICollectionReusableView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        let labelTitle = UILabel()
        labelTitle.text = "频道推荐"
        labelTitle.font = UIFont.boldSystemFont(ofSize: 20)
        labelTitle.textAlignment = .center
        self.addSubview(labelTitle)
        labelTitle.mas_makeConstraints { (make:MASConstraintMaker!) in
            make.top.left().bottom().equalTo()(self)
            make.width.equalTo()(100)
        }
        
        let detailTitle = UILabel()
        detailTitle.text = "点击添加频道"
        detailTitle.font = UIFont.systemFont(ofSize: 14)
        detailTitle.textColor = UIColor.lightGray
        self.addSubview(detailTitle)
        detailTitle.mas_makeConstraints { (make:MASConstraintMaker!) in
            make.top.bottom().equalTo()(self)
            make.left.equalTo()(labelTitle.mas_right)?.offset()(10)
            make.right.equalTo()(self)?.offset()(-20)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
