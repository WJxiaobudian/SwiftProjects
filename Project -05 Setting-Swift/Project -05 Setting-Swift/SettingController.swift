//
//  SettingController.swift
//  Project -05 Setting-Swift
//
//  Created by 王洁 on 2018/5/14.
//  Copyright © 2018年 王洁. All rights reserved.
//

import UIKit

class SettingController: BaseTableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        addOneSectionItems()
        addTwoSectionItems()
        addThreeSectionItems()
        addFourSectionItems()
        addFiveSectionItems()
        addSixSectionItems()
    }
    func addOneSectionItems() {
        let item = SettingItem.itemWithImage(icon: "ff_IconShowAlbum_25x25_", title: "朋友圈", type: .Arrow, rightImage: "MoreMyFavorites_25x25_")

        item.operation = {
            let viewController = FriendTableViewController()
//            viewController.view.backgroundColor = UIColor.white
            self.navigationController?.pushViewController(viewController, animated: true)
        }
        let group = GroupItem()
        group.items = [item]
        groups .add(group)
    }
    
    func addTwoSectionItems() {
        let  scan = SettingItem.itemWithImage(icon: "ff_IconQRCode_25x25_", title: "扫一扫", type: .Arrow, rightImage: "")
        let wave = SettingItem.itemWithImage(icon: "ff_IconShake_25x25_", title: "摇一摇", type: .Arrow, rightImage: "")
        let group = GroupItem()
        group.items = [scan, wave]
        groups.add(group)
    }
    
    func addThreeSectionItems() {
        let look = SettingItem.itemWithImage(icon: "ff_IconBrowse1_25x25_", title: "看一看", type: .Arrow, rightImage: "")
        let search = SettingItem.itemWithImage(icon: "ff_IconSearch1_25x25_", title: "搜一搜", type: .Arrow, rightImage: "")
        let group = GroupItem()
        group.items = [look, search]
        groups .add(group)
    }
    
    func addFourSectionItems() {
        let near = SettingItem.itemWithImage(icon: "ff_IconLocationService_25x25_", title: "附近的人", type:.Arrow, rightImage: "")
        let bottle = SettingItem.itemWithImage(icon: "ff_IconBottle_25x25_", title: "漂流瓶", type: .Arrow, rightImage: "")
        let group = GroupItem()
        group.items = [near, bottle]
        groups.add(group)
    }
    
    func addFiveSectionItems() {
        let shop = SettingItem.itemWithImage(icon: "MoreSetting_25x25_", title: "购物", type: .Arrow, rightImage: "")
        let game = SettingItem.itemWithImage(icon: "MoreGame_25x25_", title: "游戏", type: .Arrow, rightImage: "")
        let group = GroupItem()
        group.items = [shop, game]
        groups.add(group)
    }
    
    func addSixSectionItems() {
        let program = SettingItem.itemWithImage(icon: "WAMsg_WeAppLogo_14x14_", title: "小程序", type: .Arrow, rightImage: "")
        let group = GroupItem()
        group.items = [program]
        groups.add(group)
        
        
    }
}
