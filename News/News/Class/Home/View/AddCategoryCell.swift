//
//  AddCategoryCell.swift
//  News
//
//  Created by WJ on 2018/5/16.
//  Copyright © 2018年 WJ. All rights reserved.
//

import UIKit
import Masonry
protocol AddCategoryCellDelegate:class {
    func deleteCategoryButtonClicked(of cell:AddCategoryCell)
}

class AddCategoryCell: UICollectionViewCell {
    
    var AddCategoryDelegate:AddCategoryCellDelegate?
    var deleteCategoryButton = UIButton()
    var titleButton = UIButton()
    
    var isEdit = false {
        didSet {
            deleteCategoryButton.isHidden = !isEdit
            if titleButton.titleLabel?.text == "推荐" || titleButton.titleLabel?.text == "热点" {
                deleteCategoryButton.isHidden = true
            }
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    func setupViews() {
        self.contentView.addSubview(titleButton)
        titleButton.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        titleButton.setTitleColor(UIColor.black, for: .normal)
        titleButton.isUserInteractionEnabled = false
        titleButton.mas_makeConstraints { (make:MASConstraintMaker!) in
            make.top.left().bottom().right().equalTo()(self.contentView)
        }
        
        titleButton.addSubview(deleteCategoryButton)
        deleteCategoryButton .setImage(UIImage(named: "closeicon_repost_18x18_"), for: .normal)
        deleteCategoryButton.addTarget(self, action: #selector(deleteButtonClick), for: .touchUpInside)
        deleteCategoryButton.mas_makeConstraints { (make:MASConstraintMaker!) in
            make.top.equalTo()(titleButton)
            make.right.equalTo()(titleButton)
            make.width.height().equalTo()(20)
        }
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc private func deleteButtonClick() {
        
        AddCategoryDelegate?.deleteCategoryButtonClicked(of: self)
        
    }
}
