//
//  NoLoginHeaderView.swift
//  News
//
//  Created by WJ on 2018/5/17.
//  Copyright © 2018年 WJ. All rights reserved.
//

import UIKit
import Masonry
import IBAnimatable
import SwiftTheme
class NoLoginHeaderView: UIView {

    // 背景图片
    var bgImageView = UIImageView()
    // 手机按钮
    var mobileButton = UIButton()
    // 微信按钮
    var weChatButton = UIButton()
    // QQ按钮
    var qqButton = UIButton()
    // 新浪按钮
    var sinaButton = UIButton()
    // 更多登陆方式按钮
    var moreLoginButton = UIButton(type: .custom)
    var moreLoginButtonClick: (() -> ())?
    var bottomView = UIView()
    // 收藏按钮
    var frvoriteButton = UIButton()
    // 历史按钮
    var historyButton = UIButton()
    // 日间/夜间 按钮
    var dayOrNightButton = UIButton()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setHeaderView()
    }

    
    private func setHeaderView() {
        bgImageView.image = UIImage(named: "wallpaper_profile_night")
        bgImageView.isUserInteractionEnabled = true
        self.addSubview(bgImageView)
        bgImageView.mas_makeConstraints { (make:MASConstraintMaker!) in
            make.top.equalTo()(IsIphoneX ? -44 : -20)
            make.left.right().equalTo()(self)
            make.bottom.equalTo()(self)?.offset()(-70)
        }
        
        mobileButton.setImage(UIImage(named: "cellphoneicon_login_profile_66x66_"), for: .normal)
        weChatButton.setImage(UIImage(named: "weixinicon_login_profile_66x66_"), for: .normal)
        qqButton.setImage(UIImage(named: "qqicon_login_profile_66x66_"), for: .normal)
        sinaButton.setImage(UIImage(named: "sinaicon_login_profile_66x66_"), for: .normal)
        bgImageView.addSubview(mobileButton)
        bgImageView.addSubview(weChatButton)
        bgImageView.addSubview(qqButton)
        bgImageView.addSubview(sinaButton)

        let array:NSArray = [mobileButton, weChatButton, qqButton, sinaButton]
       array.mas_distributeViews(along: MASAxisType.horizontal, withFixedItemLength: 66.0, leadSpacing: 20.0, tailSpacing: 20.0)
        array.mas_makeConstraints { (make:MASConstraintMaker!) in
            make.centerY.equalTo()(bgImageView)
            make.height.equalTo()(66)
        }
        
        self.addSubview(bottomView)
        bottomView.backgroundColor = UIColor.white
        bottomView.mas_makeConstraints { (make:MASConstraintMaker!) in
            make.top.equalTo()(bgImageView.mas_bottom)
            make.left.right().equalTo()(self)
            make.bottom.equalTo()(self)
        }

        moreLoginButton.layer.cornerRadius  = 15
        moreLoginButton.layer.masksToBounds = true
        moreLoginButton.backgroundColor = UIColor.black
        moreLoginButton .setTitle("  更多登陆方式>  ", for: .normal)
        moreLoginButton.addTarget(self, action: #selector(moreButtonClick), for: .touchUpInside)
        moreLoginButton .setTitleColor(UIColor.white, for: .normal)
        bgImageView.addSubview(moreLoginButton)
        moreLoginButton.mas_makeConstraints { (make:MASConstraintMaker!) in
            make.top.equalTo()(mobileButton.mas_bottom)?.offset()(20)
            make.bottom.equalTo()(bottomView.mas_top)?.offset()(-20)
            make.centerX.equalTo()(self)
        }
        
        frvoriteButton.setImage(UIImage(named: "favoriteicon_profile_24x24_"), for: .normal)
        frvoriteButton.imageEdgeInsets = UIEdgeInsetsMake(-25, 30, 0, 0)
        frvoriteButton.setTitle("收藏", for: .normal)
        frvoriteButton.titleEdgeInsets = UIEdgeInsetsMake(25, -25, 0, 0)
        frvoriteButton.setTitleColor(UIColor.black, for: .normal)
        
        historyButton.setImage(UIImage(named: "history_profile_24x24_"), for: .normal)
        historyButton.imageEdgeInsets = UIEdgeInsetsMake(-25, 30, 0, 0)
        historyButton.setTitle("历史", for: .normal)
        historyButton.titleEdgeInsets = UIEdgeInsetsMake(25, -25, 0, 0)
        historyButton.setTitleColor(UIColor.black, for: .normal)
        
        dayOrNightButton.setImage(UIImage(named: "nighticon_profile_24x24_"), for: .normal)
        dayOrNightButton.imageEdgeInsets = UIEdgeInsetsMake(-25, 30, 0, 0)
        dayOrNightButton.setTitle("夜间", for: .normal)
        dayOrNightButton.titleEdgeInsets = UIEdgeInsetsMake(25, -25, 0, 0)
        dayOrNightButton.setTitleColor(UIColor.black, for: .normal)
//        dayOrNightButton.addTarget(self, action: #selector(buttonClick(sender:)), for: .touchUpInside)
        
        bottomView.addSubview(frvoriteButton)
        bottomView.addSubview(historyButton)
        bottomView.addSubview(dayOrNightButton)
        let bottomArrar:NSArray = [frvoriteButton, historyButton, dayOrNightButton]
        bottomArrar.mas_distributeViews(along: .horizontal, withFixedSpacing: 20, leadSpacing: 20, tailSpacing: 20)
        bottomArrar.mas_makeConstraints { (make:MASConstraintMaker!) in
            make.centerY.equalTo()(bottomView)
            make.height.equalTo()(70)
        }
        
    }
    
    
    @objc private func buttonClick(sender:UIButton) {
        
        sender.isSelected = !sender.isSelected
        UserDefaults.standard.set(sender.isSelected, forKey: IsNight)
        
    }
    
    @objc func moreButtonClick() {
        moreLoginButtonClick!()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
