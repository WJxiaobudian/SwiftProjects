//
//  HuoshanSmallVideoController.swift
//  News
//
//  Created by 王洁 on 2018/5/29.
//  Copyright © 2018年 王洁. All rights reserved.
//

import UIKit
import Masonry
class HuoshanSmallVideoController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        view.backgroundColor = UIColor.red
        
        setupTopView()
        setupBottomView()
        
    }
    
    func setupTopView() {
        
        let topView = UIView()
        topView.backgroundColor = UIColor.black
        topView.frame = CGRect(x: 0, y: 40, width: KscreenWidth, height: 40)
        self.view .addSubview(topView)
        
        let backButton = UIButton(type: .custom)
        backButton .setImage(UIImage(named: "ImgPic_close_24x24_"), for: .normal)
        backButton .addTarget(self, action: #selector(backButtonClick), for: .touchUpInside)
        topView .addSubview(backButton)
        backButton .mas_makeConstraints { (make:MASConstraintMaker!) in
            make.centerY.equalTo()(topView)
            make.left.equalTo()(topView.mas_left)?.offset()(15)
            make.width.equalTo()(40)
        }
        
        let titleImage = UIImageView()
        topView .addSubview(titleImage)
        titleImage .mas_makeConstraints { (make:MASConstraintMaker!) in
            make.centerX.equalTo()(topView)
            make.width.equalTo()(100)
            make.centerY.equalTo()(topView)
        }
    }
    
    @objc private func backButtonClick() {
        self .dismiss(animated: true, completion: nil)
    }
    
    func setupBottomView() {
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
