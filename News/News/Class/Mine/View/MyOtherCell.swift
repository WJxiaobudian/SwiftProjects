//
//  MyOtherCell.swift
//  News
//
//  Created by WJ on 2018/5/17.
//  Copyright © 2018年 WJ. All rights reserved.
//

import UIKit
import Masonry
class MyOtherCell: UITableViewCell {

    var leftLabel = UILabel()
    
    var rightLabel = UILabel()
    
    var rightImageView = UIImageView()
    
    var separatorView = UIView()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.addSubview(leftLabel)
        leftLabel.mas_makeConstraints { (make:MASConstraintMaker!) in
            make.top.bottom().equalTo()(self)
            make.width.equalTo()(100)
            make.height.equalTo()(self)
            make.left.equalTo()(self)?.offset()(15)
        }
        
        self.addSubview(rightImageView)
        rightImageView.image = UIImage(named: "setting_rightarrow_8x14_")
        rightImageView.mas_makeConstraints { (make:MASConstraintMaker!) in
            make.centerY.equalTo()(self)
            make.right.equalTo()(self)?.offset()(-10)
        }
        
        
        rightLabel.textAlignment = .right
        rightLabel.textAlignment = .right
        rightLabel.textColor = UIColor.lightGray
        rightLabel.font = UIFont.systemFont(ofSize: 13)
        self.addSubview(rightLabel)
        rightLabel.mas_makeConstraints { (make:MASConstraintMaker!) in
            make.top.bottom().equalTo()(self)
            make.right.equalTo()(rightImageView.mas_left)?.offset()(-10)
            make.height.equalTo()(self)
        }
        
        self.addSubview(separatorView)
        separatorView.backgroundColor = UIColor.lightGray
        separatorView.mas_makeConstraints { (make:MASConstraintMaker!) in
            make.left.right().equalTo()(self)
            make.bottom.equalTo()(self.mas_bottom)?.offset()(-0.5)
            make.height.equalTo()(0.5)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
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
