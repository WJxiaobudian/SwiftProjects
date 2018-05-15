//
//  FBMeUser.swift
//  Project -08 FacebookMe
//
//  Created by 王洁 on 2018/5/15.
//  Copyright © 2018年 王洁. All rights reserved.
//

import Foundation

import UIKit
class FBMeUser {
    var name:String
    var avatarName:String
    var education:String
    
    init(name:String, avatarName:String = "bayMax", education:String) {
        self.name = name
        self.avatarName = avatarName
        self.education = education
    }
}
