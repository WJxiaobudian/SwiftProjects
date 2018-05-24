//
//  UserDetail.swift
//  News
//
//  Created by 王洁 on 2018/5/18.
//  Copyright © 2018年 王洁. All rights reserved.
//

import Foundation
import HandyJSON

struct UserDetail:HandyJSON {
    
    var screen_name:String = ""
    var name:String = ""
    var big_avatar_url:String = ""
    var avatar_url:String = ""
    var status:Int = 0
    var is_followed:Bool = false
    var is_following:Bool = false
    var current_user_id:Int = 0
    var media_id:Int = 0
    var ugc_publish_media_id:Int = 0
    var user_id:Int = 0
    var creator_id:Int = 0
    var description:String = ""
    var attributedDescription:NSAttributedString {
        let emojimanager = EmojiManager()
        return emojimanager.showEmoji(content: description, font: UIFont.systemFont(ofSize: 13))
    }
    var descriptionHeight:CGFloat {
        return Calculate.textHeight(text: description, fontSize: 13, width: KscreenWidth - 30.0)
    }
    var apply_auth_url:String = ""
    var bottom_tab:[BottomTab] = [BottomTab]()
    var top_tab:[TopTab] = [TopTab]()
    var bg_img_url:String = ""
    var verified_content:String = ""
    var user_verified:Bool = false
    var is_blocking:Bool = false
    var is_blocked:Bool = false
    var gender:Int = 0
    var share_url:String = ""
    var followers_count:Int = 0
    var followersCount:String { return followers_count.convertString()}
    var followings_count:Int = 0
    var followingsCount:String { return followings_count.convertString()}
    var media_type:Int = 0
    var area:String = ""
    var user_auth_info = UserAuthInfo()
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
}

// MARK: 用户详情底部 tab
struct BottomTab: HandyJSON {
    
    var type: String = "" // href
    
    var name: String = ""
    
    var value: String = ""
    
    var children: [BottomTabChildren] = [BottomTabChildren]()
    
}

struct BottomTabChildren: HandyJSON {
    
    var schema_href: String = "" // sslocal://webview?url=http%3A%2F%2Fwww.guanfumuseum.org.cn%2F
    
    var type: String = "" // href
    
    var name: String = ""
    
    var value: String = "" // http://www.guanfumuseum.org.cn/
}

struct TopTab: HandyJSON {
    
    var url: String = ""
    
    var is_default: Bool = false
    
    var show_name: String = "" // 动态 文章 视频 问答
    
    var type: TopTabType = .dongtai
    
}

/// rich_content 中的元素
struct RichContent {
    var uid = ""
    var name = ""
    
    init(_ uid: String, _ name: String) {
        self.uid = uid
        self.name = name
    }
}
/// 图片的类型
enum ImageType: Int, HandyJSONEnum {
    case normal = 1     // 一般图片
    case gif = 2        // gif 图
}

struct URLList: HandyJSON {
    
    var url: String = ""
}

struct ThumbImage: HandyJSON {
    var type = ImageType.normal
    var height: CGFloat = 0
    
    var url_list = [URLList]()
    
    var url: NSString = ""
    var urlString: String {
        guard url.hasSuffix(".webp") else { return url as String }
        return url.replacingCharacters(in: NSRange(location: url.length - 5, length: 5), with: ".png")
    }
    
    var width: CGFloat = 0
    
    var uri: String = ""
    
    /// 宽高比
    var ratio: CGFloat { return width / height }
    
}

enum TopTabType: String, HandyJSONEnum {
    case dongtai = "dongtai"                            // 动态
    case article = "all"                                // 文章
    case video = "video"                                // 视频
    case wenda = "wenda"                                // 问答
    case iesVideo = "ies_video"                         // 小视频
    //    case matrix_atricle_list = "matrix_atricle_list"    // 发布厅
    //    case matrix_media_list = "matrix_media_list"        // 矩阵
}

