//
//  UserDetailNavigationBar.swift
//  News
//
//  Created by 王洁 on 2018/5/25.
//  Copyright © 2018年 王洁. All rights reserved.
//
import Foundation
import UIKit
import IBAnimatable
import Masonry
class UserDetailNavigationBar: UIView {

    /// 标题
    var nameLabel = UILabel()
    /// 关注
    var concernButton = AnimatableButton()
    /// 导航栏
    var navigationBar = UIView()
    var navigationBarTop = NSLayoutConstraint()
    /// 返回按钮
    var returnButton = UIButton()
    /// 更多按钮
    var moreButton = UIButton()
    
    var userDetail = UserDetail() {
        didSet {
            nameLabel.text = userDetail.screen_name
            concernButton.isSelected = userDetail.is_following
            concernButton.theme_backgroundColor = userDetail.is_following ? "colors.userDetailFollowingConcernBtnBgColor" : "colors.globalRedColor"
            concernButton.borderColor = userDetail.is_following ? .grayColor232() : .globalRedColor()
            concernButton.borderWidth = userDetail.is_following ? 1 : 0
        }
    }
    

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        // 返回
        self .addSubview(returnButton)
        // 更多
        self .addSubview(moreButton)
        // 标题
        self .addSubview(nameLabel)
        // 关注
        self .addSubview(concernButton)
        
        returnButton .mas_makeConstraints { (make:MASConstraintMaker!) in
            make.left.equalTo()(self)?.offset()(15)
            make.width.equalTo()(15)
            make.centerY.equalTo()(self)
        }
        
        moreButton .mas_makeConstraints { (make:MASConstraintMaker!) in
            make.right.equalTo()(self)?.offset()(-15)
            make.width.equalTo()(20)
            make.centerY.equalTo()(self)
        }
        
//        nameLabel .mas_makeConstraints { (make:MASConstraintMaker!) in
//            make.left.equalTo()(returnButton.mas_right)?.offset()(20)
//            make.right.equalTo()(self.mas_width)?.multipliedBy()(2)?.offset()(-10)
//            make.centerY.equalTo()(self)
//        }
//        concernButton .addTarget(self, action: #selector(concernButtonClicked(_:)), for: .touchUpInside)
//        concernButton .mas_makeConstraints { (make:MASConstraintMaker!) in
//            make.left.equalTo()(self.mas_width)?.multipliedBy()(2)?.offset()(10)
//            make.centerY.equalTo()(self)
//            make.width.equalTo()(50)
//        }
        
        
        returnButton.theme_setImage("images.personal_home_back_white_24x24_", forState: .normal)
        moreButton.theme_setImage("images.new_morewhite_titlebar_22x22_", forState: .normal)
        concernButton.setTitle("关注", for: .normal)
        concernButton.setTitle("已关注", for: .selected)
        concernButton.theme_setTitleColor("colors.userDetailConcernButtonTextColor", forState: .normal)
        concernButton.theme_setTitleColor("colors.userDetailConcernButtonSelectedTextColor", forState: .selected)
        NotificationCenter.default.addObserver(self, selector: #selector(receivedConcernButtonClicked(notification:)), name: NSNotification.Name(rawValue: UserDetailheaderViewButtonClick), object: nil)
        navigationBarTop.constant = IsIphoneX ? -44 : -28
        layoutIfNeeded()
    }
    
    
    @objc func receivedConcernButtonClicked(notification:Notification) {
        
        let userInfo = notification.userInfo as! [String:Any]
        let isSelected = userInfo["isSelected"] as! Bool
        concernButton.isSelected = isSelected
        concernButton.theme_backgroundColor = isSelected ? "colors.userDetailFollowingConcernBtnBgColor" : "colors.globalRedColor"
        concernButton.borderColor = isSelected ? .grayColor232() : .globalRedColor()
        concernButton.borderWidth = isSelected ? 1 : 0
        
    }
    
    @objc func concernButtonClicked(_ sender:UIButton) {
        if sender.isSelected {
            NetworkTools.loadRelationUnfollow(userId: userDetail.user_id) { (_) in
                sender.isSelected = !sender.isSelected
                sender.theme_backgroundColor = "colors.globalRedColor"
                NotificationCenter.default.post(name: NSNotification.Name(rawValue: NavigationBarAttentionButtonClicked), object: self, userInfo: ["isSelected":sender.isSelected])
            }
        } else {
            NetworkTools.loadRelationFollow(userId: userDetail.user_id) { (_) in
                sender.isSelected = !sender.isSelected
                sender.theme_backgroundColor = "colors.userDetailFollowingConcernBtnBgColor"
                
                NotificationCenter.default.post(name: NSNotification.Name(rawValue: NavigationBarAttentionButtonClicked), object: self, userInfo: ["isSelected":sender.isSelected])
            }
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
