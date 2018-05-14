//
//  WorkTableViewCell.swift
//  Project -04 Artistry
//
//  Created by 王洁 on 2018/5/11.
//  Copyright © 2018年 王洁. All rights reserved.
//

import UIKit

class WorkTableViewCell: UITableViewCell {

    @IBOutlet weak var workImageView: UIImageView!
    
    @IBOutlet weak var workTitleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    @IBOutlet weak var moreInfoTextView: UILabel!
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
