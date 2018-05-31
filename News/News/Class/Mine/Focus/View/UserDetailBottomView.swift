//
//  UserDetailBottomView.swift
//  News
//
//  Created by 王洁 on 2018/5/28.
//  Copyright © 2018年 王洁. All rights reserved.
//

import UIKit

protocol UserDetailBottomViewDelegate:class {
    
    func bottomView(click button:UIButton, bottomTab:BottomTab)
    
}


class UserDetailBottomView: UIView {
    
    weak var delegate:UserDetailBottomViewDelegate?

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
