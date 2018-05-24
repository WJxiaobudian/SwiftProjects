//
//  UsViewController.swift
//  GoodAsOldPhones
//
//  Created by 王洁 on 2018/5/21.
//  Copyright © 2018年 王洁. All rights reserved.
//

import UIKit

class UsViewController: UIViewController {

    var scrollView = UIScrollView()
    
    
    var topImage = UIImageView()
    var aboutLabel = UILabel()
    var content1Label = UILabel()
    var content2Label = UILabel()
    var content3Label = UILabel()
    
    var contactLabel = UILabel()
    
    var emailImage = UIImageView()
    var emailLabel = UILabel()
    
    var phoneImage = UIImageView()
    var phoneLabel = UILabel()
    
    var webSiteImage = UIImageView()
    var webSiteLabel = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupContentView()
        self.view.backgroundColor = UIColor.red
        // Do any additional setup after loading the view.
    }

    private func setupContentView() {
        
        self.view.addSubview(scrollView)
        scrollView.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height)
        scrollView.backgroundColor = UIColor.white
        scrollView.addSubview(topImage)
        topImage.image = UIImage(named: "header-contact")
        topImage.mas_makeConstraints { (make:MASConstraintMaker!) in
            make.top.equalTo()(self.view)?.offset()(64)
            make.right.equalTo()(self.view)
            make.left.equalTo()(self.view)
            make.height.equalTo()(188)
        }
        
        scrollView.addSubview(aboutLabel)
        aboutLabel.text = "About Us"
        aboutLabel.font = UIFont.boldSystemFont(ofSize: 33)
        aboutLabel.mas_makeConstraints { (make:MASConstraintMaker!) in
            make.top.equalTo()(topImage.mas_bottom)?.offset()(15)
            make.height.equalTo()(44)
            make.centerX.equalTo()(scrollView)
        }
        
        scrollView.addSubview(content1Label)
        content1Label.text = "Good as Old Phones returns the phones of yesteryear back to their original glory and then gets them into the hands* of those who appreciate them most:"
        content1Label.numberOfLines = 0
        content1Label.sizeToFit()
        content1Label.mas_makeConstraints { (make:MASConstraintMaker!) in
            make.top.equalTo()(aboutLabel.mas_bottom)?.offset()(15)
            make.left.equalTo()(self.view.mas_left)?.offset()(30)
            make.right.equalTo()(self.view.mas_right)?.offset()(-30)
        }
        
        scrollView.addSubview(content2Label)
        content2Label.text = "Whether you are looking for a turn-of-the-century wall set or a Zack Morris Special,we've got you covered.Give us a ring,and we will get you connected."
        content2Label.numberOfLines = 0
        content2Label.sizeToFit()
        content2Label.mas_makeConstraints { (make:MASConstraintMaker!) in
            make.top.equalTo()(content1Label.mas_bottom)?.offset()(10)
            make.right.equalTo()(content1Label.mas_right)
            make.left.equalTo()(content1Label.mas_left)
        }
        
        scrollView .addSubview(content3Label)
        content3Label.text = "Hands-free phones available"
        content3Label.mas_makeConstraints { (make:MASConstraintMaker!) in
            make.top.equalTo()(content2Label.mas_bottom)?.offset()(15)
            make.right.left().equalTo()(content1Label);
            make.height.equalTo()(21);
        }
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
