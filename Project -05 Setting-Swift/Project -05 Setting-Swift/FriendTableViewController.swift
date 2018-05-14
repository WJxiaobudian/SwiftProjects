//
//  FriendTableViewController.swift
//  Project -05 Setting-Swift
//
//  Created by 王洁 on 2018/5/14.
//  Copyright © 2018年 王洁. All rights reserved.
//

import UIKit

class FriendTableViewController: BaseTableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        addOneSectionItems()
        addTwoSectionItems()
        addThreeSectionItems()
    }
    
    func addOneSectionItems()  {
        let push = SettingItem.itemWithImage(icon: "MorePush", title: "推送和提醒", type: .Arrow, rightImage: "")
        let shake = SettingItem.itemWithImage(icon: "handShake", title: "摇一摇机选", type: .Switch, rightImage: "")
        let sound = SettingItem.itemWithImage(icon: "sound_Effect", title: "声音效果", type: .Switch, rightImage: "")
        let group = GroupItem()
        group.headTitle = "基本设置"
        group.items = [push, shake, sound]
        groups.add(group)
    }
    
    func addTwoSectionItems() {
        let update = SettingItem.itemWithImage(icon: "MoreUpdate", title: "检查新版本", type: .Arrow, desc: "1.0.2", detailLabelColor: UIColor.clear)
        let help  = SettingItem.itemWithImage(icon: "MoreHelp", title: "帮助", type: .Arrow, rightImage: "")
        let share  = SettingItem.itemWithImage(icon: "MoreShare", title: "分享", type: .Arrow, rightImage: "")
        let msg = SettingItem.itemWithImage(icon: "MoreMessage", title: "查看消息", type: .Arrow, rightImage: "")
        let product = SettingItem.itemWithImage(icon: "MoreNetease", title: "产品推荐", type: .Arrow, rightImage: "")
        let about = SettingItem.itemWithImage(icon: "MoreAbout", title: "关于", type: .Arrow, rightImage: "")
        
        let group = GroupItem()
        group.headTitle = "高级设置"
        group.items = [update, help, share, msg, product, about]
        groups.add(group)

    }
    func addThreeSectionItems() {
        let documents = SettingItem.itemWithTitle(title: "文字", type: .TextField, placeHolder: "")
        let place = SettingItem.itemWithTitle(title: "占位文字", type: .TextField, placeHolder: "输入手机号")
        let group = GroupItem()
        group.items = [documents, place]
        groups.add(group)
    }
}
