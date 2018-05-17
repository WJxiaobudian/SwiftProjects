//
//  HomeNavigationView.swift
//  News
//
//  Created by 王洁 on 2018/5/16.
//  Copyright © 2018年 王洁. All rights reserved.
//

import UIKit
import IBAnimatable
import Masonry
class HomeNavigationView: UIView {

    // 搜索
    var searchButton:AnimatableButton = AnimatableButton()
    // 头像
    var avatarButton:UIButton = UIButton()
    // 相机
    var cameraButton:UIButton = UIButton()
    // 搜索按钮点击
    var didSelectSearchButton:(() -> ())?
    // 头像按钮点击
    var didSelectAvatarButton:(() -> ())?
    // 相机按钮点击
    var didSelectCameraButton:(() -> ())?
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupAllViews()
    }
    
    func setupAllViews() {
        
        self.addSubview(avatarButton)
        avatarButton.addTarget(self, action: #selector(avatarButtonClicked), for: .touchUpInside)
        avatarButton.mas_makeConstraints{ (make:MASConstraintMaker!) in
            make.top.equalTo()(self.mas_top)?.offset()(7)
            make.bottom.equalTo()(self.mas_bottom)?.offset()(-7)
            make.left.equalTo()(self.mas_left)?.offset()(5)
            make.width.height().equalTo()(30)
        }

        self.addSubview(cameraButton)
        cameraButton.addTarget(self, action: #selector(cameraButtonClicked), for: .touchUpInside)
        cameraButton.mas_makeConstraints { (make:MASConstraintMaker!) in
            make.top.equalTo()(avatarButton)
            make.right.equalTo()(self.mas_right)?.offset()(-7)
            make.bottom.equalTo()(avatarButton)
            make.width.height().equalTo()(avatarButton)
        }
        
        self.addSubview(searchButton)
        searchButton.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        searchButton.titleLabel?.lineBreakMode = .byTruncatingTail
        searchButton.addTarget(self, action: #selector(searchButtonClicked), for: .touchUpInside)
        searchButton.mas_makeConstraints { (make:MASConstraintMaker!) in
            make.top.bottom().equalTo()(avatarButton)
            make.left.equalTo()(avatarButton.mas_right)?.offset()(5)
            make.right.equalTo()(cameraButton.mas_left)?.offset()(-5)
        }
        
        searchButton.theme_backgroundColor = "colors.cellBackgroundColor"
        searchButton.theme_setTitleColor("colors.grayColor150", forState: .normal)
        searchButton.setImage(UIImage(named: "search_small_16x16_"), for: .normal)
        cameraButton.theme_setImage("images.home_camera", forState: .normal)
        cameraButton.theme_setImage("images.home_camera", forState: .highlighted)
        avatarButton.theme_setImage("images.home_no_login_head", forState: .normal)
        avatarButton.theme_setImage("images.home_no_login_head", forState: .highlighted)
        
        NetworkTools.loadHomeSearchSuggestInfo { (suggest) in
            self.searchButton.setTitle(suggest, for: .normal)
            print("\(suggest)")
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
      
        
        
    
    }
    
    override var intrinsicContentSize: CGSize {
        return UILayoutFittingExpandedSize
    }

//    override var frame: CGRect {
//        didSet {
//            super.frame = CGRect(x: 0, y: 0, width: KscreenWidth, height: 44)
//        }
//       
//    }
    
    @objc private func cameraButtonClicked() {
        didSelectCameraButton?()
    }
    
    @objc private func avatarButtonClicked() {
        didSelectAvatarButton?()
    }
    @objc private func searchButtonClicked() {
        print("🍐")
        didSelectSearchButton?()
    }

}
