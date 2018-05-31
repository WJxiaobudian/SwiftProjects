//
//  Const.swift
//  News
//
//  Created by WJ on 2018/5/15.
//  Copyright © 2018年 WJ. All rights reserved.
//

import UIKit
import Masonry

let KscreenWidth = UIScreen.main.bounds.width
let KscreenHeight = UIScreen.main.bounds.height
let KemojiItemWidth = KscreenWidth / 7

let BASE_URL = "https://is.snssdk.com"

let Device_id:Int = 6096495334
let Iid:Int = 5034850950

let IsIphoneX:Bool = KscreenHeight == 812 ? true : false

let NewsTitleHeight:CGFloat = 40
let MyHeaderViewHeight:CGFloat = 200
let UserDetailHeaderBGImageViewHeight:CGFloat = 146

let IsNight = "isNight"

let TopTabButtonWidth:CGFloat = KscreenWidth * 0.2
let TopTabIndicatorWidth:CGFloat = 40
let TopTabIndicatorHeight:CGFloat = 2

let MyPresentationControllerDismiss = "MyPresentationControllerDismiss"
let NavigationBarAttentionButtonClicked = "NavigationBarAttentionButtonClicked"
let UserDetailheaderViewButtonClick = "UserDetailHeaderViewButtonClicked"

let imageOneWidth:CGFloat = KscreenWidth * 0.5
let imageTwoWidth:CGFloat = (KscreenWidth - 35) * 0.5
let imageThreeWidth:CGFloat = (KscreenWidth - 40) / 3

enum QuestionAndAnswer:String {
    case Dynamic = "dongtai"
    case ClickHeadline = "click_headline"
    case ClickCategory = "click_category"
}

enum TTForm:String {
    case pull = "pull"
    case loadMore = "load_more"
    case auto = "auto"
    case enterAuto = "enter_auto"
    case preLoadMoreDraw = "pre_load_more_draw"
}



















