//
//  NetworkTools.swift
//  News
//
//  Created by WJ on 2018/5/16.
//  Copyright © 2018年 WJ. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON
protocol NetworkToolProtocol {
    
    // 首页顶部新闻标题的数据
    static func loadHomeNewsTitleData(completionHandler: @escaping (_ newsTitles:[HomeNewsTitle]) -> ())
    // 点击首页加号按钮，获取频道推荐数据
    static func loadHomeCategoryRecommend(completionHandler: @escaping (_ titles:[HomeNewsTitle]) -> ())
//    // 首页顶部导航栏搜索推荐标题内容
    static func loadHomeSearchSuggestInfo(completionHandler: @escaping (_ searchSuggest:String) -> ())
    // 获取首页、视频、小视频的新闻列表数据
//    static func loadApiNewsFeeds(category:)
     static func loadMyCellData(completionHandler: @escaping (_ sections: [[MyCellModel]]) -> ())
    static func loadMyConcern(completionHandler: @escaping (_ concerns: [MyConcern]) -> ())
}

extension NetworkToolProtocol {
    static func loadHomeSearchSuggestInfo(completionHandler: @escaping (String) -> ()) {
        let url = BASE_URL + "/search/suggest/homepage_suggest/?"
        let params = ["device_id":Device_id,
                      "iid":Iid]
        Alamofire.request(url, parameters:params).responseJSON { (response) in
            guard response.result.isSuccess else {
                return
            }
            
            if let value = response.result.value {
                let  json = JSON(value)
                guard json["message"] == "success" else {
                    return
                }
                if let data = json["data"].dictionary {
                    completionHandler((data["homepage_search_suggest"]?.string)!)
                }
                
            }
        }
        
    }
    
    static func loadHomeNewsTitleData(completionHandler: @escaping (_ newsTitles: [HomeNewsTitle]) -> ()) {
        let url = BASE_URL + "/article/category/get_subscribed/v1/?"
        let params = ["device_id":Device_id,
                      "iid":Iid]
        Alamofire.request(url, parameters: params).responseJSON { (response) in
            guard response.result.isSuccess else {
                return
            }
            if let value = response.result.value {
                let json = JSON(value)
                guard json["message"] == "success" else {
                    return
                }
                if let dataDict = json["data"].dictionary {
                    if let datas = dataDict["data"]?.arrayObject {
                        var titles = [HomeNewsTitle]()
                        titles.append(HomeNewsTitle.deserialize(from: "{\"category\": \"\", \"name\": \"推荐\"}")!)
                        titles += datas.compactMap({HomeNewsTitle.deserialize(from: $0 as? Dictionary)})
                        completionHandler(titles)
                    }
                }
            }
        }
    }
    
    /// 点击首页加号按钮，获取频道推荐数据
    /// - parameter completionHandler: 返回标题数据
    /// - parameter titles: 标题数据
    static func loadHomeCategoryRecommend(completionHandler:@escaping (_ titles: [HomeNewsTitle]) -> ()) {
        let url = BASE_URL + "/article/category/get_extra/v1/?"
        let params = ["device_id": Device_id,
                      "iid": Iid]
        Alamofire.request(url, parameters: params).responseJSON { (response) in
            guard response.result.isSuccess else { return }
            print("\(response.result)")
            if let value = response.result.value {
                let json = JSON(value)
                print("\(JSON(value))")
                let dataDict = json["data"].dictionary
                if let data = dataDict!["data"]!.arrayObject {
                    completionHandler(data.compactMap({
                        HomeNewsTitle.deserialize(from: ($0 as! [String: Any]))
                    }))
                }
            }
        }
    }
    
    /// 我的界面 cell 的数据
    /// - parameter completionHandler: 返回我的 cell 的数据
    /// - parameter sections: 我的界面 cell 的数据
    static func loadMyCellData(completionHandler: @escaping (_ sections: [[MyCellModel]]) -> ()) {
        let url = BASE_URL + "/user/tab/tabs/?"
        let params = ["device_id": Device_id]
        
        Alamofire.request(url, parameters: params).responseJSON { (response) in
            // 网络错误的提示信息
            guard response.result.isSuccess else { return }
            if let value = response.result.value {
                let json = JSON(value)
                guard json["message"] == "success" else { return }
                var mySections = [[MyCellModel]]()
                mySections.append([MyCellModel.deserialize(from: "{\"text\":\"我的关注\",\"grey_text\":\"\"}")!])
                if let data = json["data"].dictionary {
                    print("\(data)")
                    if let sections = data["sections"]?.arrayObject {
                        mySections += sections.compactMap({ item in
                            (item as! [Any]).compactMap({ MyCellModel.deserialize(from: $0 as? Dictionary) })
                        })
                        completionHandler(mySections)
                    }
                }
            }
        }
    }
    
    /// 我的关注数据
    /// - parameter completionHandler: 返回我的关注数据
    /// - parameter concerns: 我的界面我的关注数组
    static func loadMyConcern(completionHandler: @escaping (_ concerns: [MyConcern]) -> ()) {
        
        let url = BASE_URL + "/concern/v2/follow/my_follow/?"
        let params = ["device_id": Device_id]
        
        Alamofire.request(url, parameters: params).responseJSON { (response) in
            // 网络错误的提示信息
            guard response.result.isSuccess else { return }
            if let value = response.result.value {
                let json = JSON(value)
                guard json["message"] == "success" else { return }
                if let datas = json["data"].arrayObject {
                    print("\(datas)")
                    completionHandler(datas.compactMap({ MyConcern.deserialize(from: $0 as? Dictionary) }))
                }
            }
        }
    }
}




























struct NetworkTools:NetworkToolProtocol {
}
