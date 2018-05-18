//
//  FirstSectionCell.swift
//  News
//
//  Created by WJ on 2018/5/17.
//  Copyright © 2018年 WJ. All rights reserved.
//

import UIKit
import Masonry
class FirstSectionCell: UITableViewCell {

    var myConcernSelected: ((_ myConcern:MyConcern) -> ())?
    
    // 左边标题
    var leftLabel = UILabel()
    // 右边图片
    var rightImage = UIImageView()
    // 右边标题
    var rightLabel = UILabel()
    // collectionView
    var collectionView = UICollectionView(frame: .zero, collectionViewLayout: MyConcernFlowLayout())
    // 头部view
    var topView = UIView()
    // 分割线
    var separatorView = UIView()
    
    var myConcerns = [MyConcern]() {
        didSet {
            collectionView.reloadData()
        }
    }
    
    var myCellModel = MyCellModel() {
        didSet {
            leftLabel.text = myCellModel.text
            rightLabel.text = myCellModel.grey_text
        }
    }
    
    var myConcern = MyConcern() {
        didSet {
            
        }
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
       
        
        /// 设置主题
        leftLabel.theme_textColor = "colors.black"
        rightLabel.theme_textColor = "colors.cellRightTextColor"
        rightImage.theme_image = "images.cellRightArrow"
        separatorView.theme_backgroundColor = "colors.separatorViewColor"
        theme_backgroundColor = "colors.cellBackgroundColor"
        topView.theme_backgroundColor = "colors.cellBackgroundColor"
        collectionView.theme_backgroundColor = "colors.cellBackgroundColor"
        
        self.addSubview(topView)
        topView.frame = CGRect(x: 0, y: 0, width: KscreenWidth, height: 40)
        
        topView.addSubview(leftLabel)
        leftLabel.text = "我的关注"
        leftLabel.font = UIFont.systemFont(ofSize: 17)
        leftLabel.textAlignment = .left
        leftLabel.mas_makeConstraints { (make:MASConstraintMaker!) in
            make.top.bottom().equalTo()(topView)
            make.left.equalTo()(15)
            make.height.equalTo()(40)
            make.width.equalTo()(100)
        }
        
        rightImage.image = UIImage(named: "setting_rightarrow_8x14_")
        topView.addSubview(rightImage)
        rightImage.mas_makeConstraints { (make:MASConstraintMaker!) in
            make.centerY.equalTo()(topView)
            make.right.equalTo()(self)?.offset()(-10)
        }
        
        rightLabel.text = "副标题"
        rightLabel.textAlignment = .right
        topView.addSubview(rightLabel)
        rightLabel.mas_makeConstraints { (make:MASConstraintMaker!) in
            make.top.bottom().equalTo()(self)
            make.left.equalTo()(leftLabel)?.offset()(10)
            make.right.equalTo()(rightImage)?.offset()(-10)
            make.height.equalTo()(self)
        }
        
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(MyConcernCell.self, forCellWithReuseIdentifier: "MyConcernCell")
        collectionView.showsHorizontalScrollIndicator = false
        self.addSubview(collectionView)
        collectionView.mas_makeConstraints { (make:MASConstraintMaker!) in
            make.top.equalTo()(topView.mas_bottom)
            make.left.right().bottom().equalTo()(self)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension FirstSectionCell:UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        print("\(myConcerns.count)🍐")
        return myConcerns.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MyConcernCell", for: indexPath) as! MyConcernCell
        cell.myConcern = myConcerns[indexPath.item]
        print("\(cell.myConcern)🍎")
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        myConcernSelected?(myConcerns[indexPath.item])
    }
}

class MyConcernFlowLayout: UICollectionViewFlowLayout {
    
    override func prepare() {
        // 每个 cell 的大小
        itemSize = CGSize(width: 58, height: 74)
        // 间距
        minimumLineSpacing = 0
        minimumInteritemSpacing = 0
        // cell 上下左右的间距
        sectionInset = UIEdgeInsetsMake(0, 0, 0, 0)
        // 设置水平滚动
        scrollDirection = .horizontal
    }
}

