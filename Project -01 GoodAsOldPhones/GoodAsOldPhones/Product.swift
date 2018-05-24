//
//  Product.swift
//  GoodAsOldPhones
//
//  Created by 王洁 on 2018/5/21.
//  Copyright © 2018年 王洁. All rights reserved.
//

import Foundation

struct Products {
    
    var name:String?
    var cellName:String?
    var fullName:String?
    
    init(name:String, cellName:String, fullName:String) {
        self.name = name
        self.cellName = cellName
        self.fullName = fullName
    }
}
