//
//  TodoItem.swift
//  Project  03 - ToDo
//
//  Created by 王洁 on 2018/5/10.
//  Copyright © 2018年 王洁. All rights reserved.
//

import Foundation

class ToDoItem: NSObject {
    var id:String
    var image:String
    var title:String
    var date:Date
    
    init(id:String, image:String, title:String, date:Date) {
        self.id = id
        self.image = image
        self.title = title
        self.date = date
    }
}

func dateFromString(date:String) -> Date? {
    let dateFormString = DateFormatter()
    dateFormString.dateFormat = "yyyy-MM-dd"
    return dateFormString.date(from: date)
}

func stringFromDate(date:Date) -> String {
    let dateFromatter = DateFormatter()
    dateFromatter.dateFormat = "yyyy-MM-dd"
    return dateFromatter.string(from: date)
    
}
