//
//  Tweet.swift
//  Project02LoveTweet
//
//  Created by 王洁 on 2018/5/9.
//  Copyright © 2018年 王洁. All rights reserved.
//

import Foundation

struct Tweet {
    var genger:Gender
    var name:String
    var age:Int
    var work:String
    var salary:String
    var isStraight:Bool
    
    var interestedGender:String {
        switch genger {
        case .Female:
            return isStraight ? "Men" : "Women"
        case .Male:
            return isStraight ? "Women" : "Men"
        }
    }
    
    var info:String {
          return "Hi, I am \(name). As a \(age)-year-old \(work) earning \(salary)/year, I am interested in \(interestedGender). Feel free to contact me!"
    }
}
