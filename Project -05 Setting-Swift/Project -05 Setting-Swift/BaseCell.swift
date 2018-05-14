//
//  BaseCell.swift
//  Project -05 Setting-Swift
//
//  Created by 王洁 on 2018/5/14.
//  Copyright © 2018年 王洁. All rights reserved.
//

import UIKit


class BaseCell: UITableViewCell, UITextFieldDelegate {
   
    var items:SettingItem?

    var _arrow:UIImageView?
    var _switch:UISwitch?
    var _textField:UITextField?
    var _imageView:UIImageView?
    
    
    class func settingCellWithTableView(tableView:UITableView?) -> Any? {
        let ID:String = "Cell"
        var cell = tableView?.dequeueReusableCell(withIdentifier: ID) as? BaseCell
        if (cell == nil) {
            cell = BaseCell.init(style: .value1, reuseIdentifier: ID)
        }
        
        cell?.separatorInset = UIEdgeInsetsMake(0, 20, 0, 0)
        
        return cell
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setItem(_ item:SettingItem?) {
        items = item
        imageView?.image = UIImage.init(named: item?.image ?? "")
        textLabel?.text = item?.title
        textLabel?.font = UIFont .systemFont(ofSize: 17)
        detailTextLabel?.text = item?.subTitle
        detailTextLabel?.textColor = item?.detailLabelColor
        
        if (item?.type == .Arrow) {
            if (_arrow == nil) {
                _arrow = UIImageView.init(image: UIImage.init(named: "CellArrow"))
            }
            
            if (_imageView == nil) {
                _imageView = UIImageView.init(image: UIImage.init(named: item?.rightImage ?? ""))
                _imageView?.frame = CGRect(x: self.contentView.frame.width, y: 0, width: 25, height: 25)
                _imageView?.centerY = self.centerY
                self .addSubview(_imageView!)
            }
            self.accessoryView = _arrow
            self.selectionStyle = .blue
        } else if (item?.type == .Switch) {
            if (_switch == nil) {
                _switch = UISwitch()
            }
            
            self.accessoryView = _switch
            self.selectionStyle = .none
        } else if(item?.type == .TextField) {
            if (_textField == nil) {
                _textField = UITextField()
                _textField?.frame.size.height = self.frame.size.height
                _textField?.placeholder = item?.placeHolder
                _textField?.font = UIFont.systemFont(ofSize: 13)
                _textField?.frame.size.width = 200
                _textField?.frame.origin.x = UIScreen.main.bounds.width - 210
                _textField?.delegate = self
                _textField?.textAlignment = .right
            }
            self.accessoryView = _textField
            self.selectionStyle = .none
        } else {
            self.accessoryView = nil
            self.selectionStyle = .blue
        }
        
        
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
