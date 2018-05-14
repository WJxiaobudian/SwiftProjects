//
//  Header.swift
//  Project02LoveTweet
//
//  Created by 王洁 on 2018/5/9.
//  Copyright © 2018年 王洁. All rights reserved.
//

import Foundation

enum Gender:Int {
    case Male = 0, Female
}

extension Selector {
    static let endEditing = #selector(UIView.endEditing(_:))
}

extension UIViewController {
    func showAlert(title: String, message: String, buttonTitle: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: buttonTitle, style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
}

// 屏幕宽度
let WJWindowWidth = UIScreen.main.bounds.size.width
// 屏幕高度
let WJWindowHeight = UIScreen.main.bounds.size.height
// iphone4
let isIphone4 = WJWindowHeight < 568 ? true : false
// iphnoe5
let isIphone5 = WJWindowHeight == 568 ? true : false
// iphone6
let isIphone6 = WJWindowHeight == 667 ? true : false
// iphone6P
let isIphone6P = WJWindowHeight == 736 ? true : false
// iphoneX
let isIphoneX = WJWindowHeight == 812 ? true : false
// navigationBarHeight
let navigationBarHeight = isIphoneX ? 88 : 64
// tabBarHeight
let tabBarHeight = isIphoneX ? 49 + 34 : 49
// state高度
let stateHeight = isIphoneX ? 44 : 20

