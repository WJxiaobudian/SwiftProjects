//
//  MyConcernCell.swift
//  News
//
//  Created by WJ on 2018/5/17.
//  Copyright © 2018年 WJ. All rights reserved.
//

import UIKit
import Kingfisher
import Masonry
class MyConcernCell: UICollectionViewCell {
    
    var avatarImageView = UIImageView()
    
    var vipImageView = UIImageView()
    var nameLabel = UILabel()
    var tipsButton = UIButton()
    
    var myConcern = MyConcern() {
        didSet {
            avatarImageView.kf.setImage(with: URL(string: myConcern.icon))
            nameLabel.text = myConcern.name
            vipImageView.isHidden = !myConcern.is_verify
            tipsButton.isHidden = !myConcern.tips
            vipImageView.image = myConcern.user_auth_info.auth_type == 1 ? UIImage(named: "all_v_avatar_star_16x16_") : UIImage(named: "all_v_avatar_18x18_")
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        tipsButton.layer.borderWidth = 1
        tipsButton.layer.theme_borderColor = "colors.cellBackgroundColor"
        theme_backgroundColor = "colors.cellBackgroundColor"
        tipsButton.theme_backgroundColor = "colors.globalRedColor"
        nameLabel.theme_textColor = "colors.black"
        
        self.addSubview(avatarImageView)
        self.addSubview(nameLabel)
        
        avatarImageView.layer.masksToBounds = true
        avatarImageView.backgroundColor = UIColor.red
        avatarImageView.layer.cornerRadius = 25
        avatarImageView.mas_makeConstraints { (make:MASConstraintMaker!) in
            make.top.equalTo()(self)
            make.centerX.equalTo()(self)
            make.height.equalTo()(50)
            make.width.equalTo()(50)
        }
        
        nameLabel.font = UIFont.systemFont(ofSize: 10)
        nameLabel.textAlignment = .center
        nameLabel.mas_makeConstraints { (make:MASConstraintMaker!) in
            make.top.equalTo()(avatarImageView.mas_bottom)
            make.right.left().equalTo()(avatarImageView)
            make.bottom.equalTo()(self)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
