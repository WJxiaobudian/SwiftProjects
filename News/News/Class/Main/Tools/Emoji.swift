//
//  Emoji.swift
//  News
//
//  Created by 王洁 on 2018/5/18.
//  Copyright © 2018年 王洁. All rights reserved.
//

import Foundation
import UIKit

struct Emoji {
    var id = ""
    var name = ""
    var png = ""
    var isDelete = false
    var isEmpty = false
    
    init(id:String = "", name:String = "", png:String = "", isDelete:Bool = false, isEmpty:Bool = false) {
        self.id = id
        self.name = name
        self.png = png
        self.isDelete = isDelete
        self.isEmpty = isEmpty
    }
}

struct EmojiManager {
    var emojis = [Emoji]()
    init() {
        // 获取 emoji_sort.plist 的路径
        let arrayPath = Bundle.main.path(forResource: "emoji_sort", ofType: "plist")
        // 根据plist文件读取数据
        let emojiSorts = NSArray(contentsOfFile: arrayPath!) as! [String]
        // 获取emoji_mapping.plist 的路径
        let mappingPath = Bundle.main.path(forResource: "emoji_mapping.plist", ofType: nil)
        // 根据plist文件 读取数据
        let emojiMapping = NSDictionary(contentsOfFile: mappingPath!) as! [String:String]
        // 临时数组
        var temps = [Emoji]()
        // 遍历
        for (index, id) in emojiSorts.enumerated() {
            if index != 0 && index % 20 == 0 {
                temps.append(Emoji(isDelete:true))
            }
            temps.append(Emoji(id: id, name: "emoji_\(id)_32x32"))
        }
        
        
        for temp in temps {
            var  emoji  = temp
            for (key, value) in emojiMapping {
                if emoji.id == value {
                    emoji.name = "\(key)"
                    emojis.append(emoji)
                }
            }
            if emoji.isDelete {
                emojis.append(emoji)
            }
        }
        let count  = emojis.count % 21
        guard count != 0 else {
            return
        }
        for index in count..<21 {
            emojis.append(index == 20 ? Emoji(isDelete:true) : Emoji(isEmpty:true))
        }
        
    }
    func  showEmoji(content:String, font:UIFont) -> NSMutableAttributedString {
        let attributedString = NSMutableAttributedString(string: content)
        let emojiPattern = "\\[.*?\\]"
        let regex = try! NSRegularExpression(pattern: emojiPattern, options: [])
        let results = regex.matches(in: content, options: [], range: NSRange(location: 0, length: content.count))
        if results.count != 0  {
            for index in stride(from: results.count - 1, through: 0, by: -1) {
                let result = results[index]
                let emojiName = (content as NSString).substring(with: result.range)
                let attachment = NSTextAttachment()

                guard let emoji = emojis.filter({ $0.name == emojiName}).first else {
                    return attributedString
                }
                attachment.image = UIImage(named: emoji.png)
                attachment.bounds = CGRect(x: 0, y: -4, width: font.lineHeight, height: font.lineHeight)
                let attributedImageStr = NSAttributedString(attachment: attachment)
                attributedString.replaceCharacters(in: result.range, with: attributedImageStr)
                
            }
        }
        return attributedString
    }
}

