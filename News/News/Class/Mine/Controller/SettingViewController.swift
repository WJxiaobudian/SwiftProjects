//
//  SettingViewController.swift
//  News
//
//  Created by 王洁 on 2018/5/18.
//  Copyright © 2018年 王洁. All rights reserved.
//

import UIKit

class SettingViewController: BaseTableViewController {
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // 设置状态栏属性
        navigationController?.navigationBar.barStyle = .default
        navigationController?.setNavigationBarHidden(false, animated: false)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setOneSectionItems()
        setTwoSectionItems()
    }

    private func setOneSectionItems() {
        
        let cache = SettingItem.itemWithImage(icon: "", title: "清理缓存", type: .None, desc: "", detailLabelColor: .black)
        let font = SettingItem.itemWithImage(icon: "", title: "字体大小", type: .None, desc: "中", detailLabelColor: .black)
        let lists = SettingItem.itemWithImage(icon: "", title: "列表显示摘要", type: .Switch, desc: "", detailLabelColor: .black)
        let NoWifiTraffic = SettingItem.itemWithImage(icon: "", title: "非Wifi网络流量", type: .None, desc: "最佳效果(下载大图)", detailLabelColor: .black)
        let NoWifiPlay = SettingItem.itemWithImage(icon: "", title: "非WiFi网络播放提醒", type: .None, desc: "提醒一次", detailLabelColor: .black)
        let notification = SettingItem.itemWithImage(icon: "", title: "推送通知", type: .Switch, desc: "", detailLabelColor: .black)
        
        let group = GroupItem()
        group.items = [cache, font, lists, NoWifiTraffic, NoWifiPlay, notification]
        groups .add(group)
        
    }
    
    private func setTwoSectionItems() {
        
        let downLoad = SettingItem.itemWithImage(icon: "", title: "离线下载", type: .Arrow, desc: "", detailLabelColor: .black)
        let cover = SettingItem.itemWithImage(icon: "", title: "头条封面", type: .Arrow, desc: "", detailLabelColor: .black)
        let version = SettingItem.itemWithImage(icon: "", title: "当前版面", type: .None, desc: "1.0.1", detailLabelColor: .black)
        
        let group = GroupItem()
        group.items = [downLoad, cover, version]
        groups .add(group)
    }
}
