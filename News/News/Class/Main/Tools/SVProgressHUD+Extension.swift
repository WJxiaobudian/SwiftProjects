//
//  SVProgressHUD+Extension.swift
//  News
//
//  Created by 王洁 on 2018/5/28.
//  Copyright © 2018年 王洁. All rights reserved.
//

import SVProgressHUD

extension SVProgressHUD {
    /// 设置 SVProgressHUD 属性
    static func configuration() {
        SVProgressHUD.setForegroundColor(.white)
        SVProgressHUD.setMinimumDismissTimeInterval(1.5)
        SVProgressHUD.setBackgroundColor(UIColor.init(r: 0, g: 0, b: 0, a: 0.3));
    }
}
