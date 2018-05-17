//
//  MyChannelReusableView.swift
//  News
//
//  Created by 王洁 on 2018/5/16.
//  Copyright © 2018年 王洁. All rights reserved.
//

import UIKit
import Masonry
class MyChannelReusableView: UICollectionReusableView {
    
    let editButton = UIButton(type: .custom)
    let detailLabel = UILabel()
    var channelReusableViewEditButtonClicked: ((_ sender: UIButton)->())?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        let titleLabel = UILabel()
        titleLabel.textAlignment = .center
        titleLabel.text = "我的频道"
        titleLabel.font = UIFont.boldSystemFont(ofSize: 17)
        self.addSubview(titleLabel)
        titleLabel.mas_makeConstraints { (make:MASConstraintMaker!) in
            make.top.left().bottom().equalTo()(self)
            make.width.equalTo()(100)
        }
        editButton.layer.borderColor = UIColor.globalRedColor().cgColor
        editButton.layer.borderWidth = 1
        editButton.layer.cornerRadius = 12
        editButton.layer.masksToBounds = true
        editButton.setTitle("编辑", for: .normal)
        editButton.setTitle("完成", for: .selected)
        editButton.setTitleColor(UIColor.red, for: .normal)
        self.addSubview(editButton)
        editButton.addTarget(self, action: #selector(editButtonClick), for: .touchUpInside)
        editButton.mas_makeConstraints { (make:MASConstraintMaker!) in
            make.right.equalTo()(self)
            make.width.equalTo()(60)
            make.height.equalTo()(25)
            make.centerY.equalTo()(self)
        }
        
        detailLabel.text = "点击进入频道"
        detailLabel.textColor = UIColor.lightGray
        self.addSubview(detailLabel)
        detailLabel.mas_makeConstraints { (make:MASConstraintMaker!) in
            make.top.bottom().equalTo()(self)
            make.right.equalTo()(editButton.mas_left)?.offset()(-5)
            make.left.equalTo()(titleLabel.mas_right)?.offset()(5)
        }
        
        NotificationCenter.default.addObserver(self, selector: #selector(longPressTarget), name: NSNotification.Name(rawValue: "longPressTarget"), object: nil)
    }
    
    @objc private func longPressTarget() {
        editButton.isSelected = true
        detailLabel.text = "拖拽可以排序"
    }
    
    @objc private func editButtonClick(sender:UIButton){
        sender.isSelected = !sender.isSelected
        editButton.setTitle(sender.isSelected ? "完成" : "编辑", for: .normal)
        detailLabel.text = sender.isSelected ? "拖拽可以排序" : "点击进入频道"
        channelReusableViewEditButtonClicked?(sender)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    /// 移除通知
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
}
