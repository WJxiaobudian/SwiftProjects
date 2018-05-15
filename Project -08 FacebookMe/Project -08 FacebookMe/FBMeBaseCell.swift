//
//  FBMeBaseCell.swift
//  Project -08 FacebookMe
//
//  Created by 王洁 on 2018/5/15.
//  Copyright © 2018年 王洁. All rights reserved.
//

import UIKit

class FBMeBaseCell: UITableViewCell {

    static let identifier = "FBMeBaseCell"
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: reuseIdentifier)
        backgroundColor = Specs.color.white
        textLabel?.textColor = Specs.color.black
        textLabel?.font = Specs.font.large
        
        detailTextLabel?.font = Specs.font.small
        detailTextLabel?.textColor = Specs.color.gray
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
