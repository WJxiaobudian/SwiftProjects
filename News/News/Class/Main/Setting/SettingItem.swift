//
//  SettingItem.swift
//  Project -05 Setting-Swift
//
//  Created by WJ on 2018/5/14.
//  Copyright © 2018年 WJ. All rights reserved.
//

enum SettingItemType:Int {
    case None
    case Arrow
    case Switch
    case TextField
}

import Foundation
import UIKit
class SettingItem {
    
    var image = ""
    var title = ""
    var subTitle = ""
    var desc = ""
    var placeHolder = ""
    var detailLabelColor:UIColor?
    var rightImage = ""
    var type:SettingItemType?
    var operation:(() -> Void)?
    
    // 单独文字
    class func itemWithTitle(title:String) ->SettingItem {
        let items:SettingItem = SettingItem.init()
        items.title = title
        return items
        
    }
    
    /// <#Description#>
    ///
    /// - Parameters:
    ///   - icon: 左边图片
    ///   - title: 文字
    ///   - type: 类型
    ///   - rightImage: 右边图片
    /// - Returns: SettingItem
    class func itemWithImage(icon:String, title:String, type:SettingItemType, rightImage:String) -> SettingItem {
        let items:SettingItem = SettingItem.init()
        items.image = icon
        items.title = title
        items.type = type
        items.rightImage = rightImage
        return items
    }
    
    /// <#Description#>
    ///
    /// - Parameters:
    ///   - icon: 左边图片
    ///   - title: 文字
    ///   - type: 类型
    ///   - desc: 描述
    ///   - detailLabelColor: 描述文字的颜色
    /// - Returns: SettingItem
    class func itemWithImage(icon:String, title:String, type:SettingItemType, desc:String, detailLabelColor:UIColor) -> SettingItem {
        let items:SettingItem = SettingItem.init()
        items.image = icon
        items.title = title
        items.type = type
        items.desc = desc
        items.detailLabelColor = detailLabelColor
        return items
    }
    
    class func itemWithTitle(title:String, type:SettingItemType, placeHolder:String) -> SettingItem {
        let items:SettingItem = SettingItem.init()
        items.title = title
        items.type = type
        items.placeHolder = placeHolder
        return items
        
    }
    
}
