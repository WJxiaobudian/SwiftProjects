//
//  ProductDetailController.swift
//  GoodAsOldPhones
//
//  Created by 王洁 on 2018/5/21.
//  Copyright © 2018年 王洁. All rights reserved.
//

import UIKit
class ProductDetailController: UIViewController {

    var product:Products!
    
    var fullImage = UIImageView()
    
    var titleName = UILabel()
    
    var addButton = UIButton()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        print("\((product)!)")
        self.view.backgroundColor = UIColor.white
        setUpView()
        // Do any additional setup after loading the view.
    }
    
    private func setUpView() {
        
        fullImage.image = UIImage(named: (product?.fullName)!)
        self.view.addSubview(fullImage)
        fullImage.mas_makeConstraints { (make:MASConstraintMaker!) in
            make.top.right().bottom().left().equalTo()(self.view)
        }
        
        titleName.text = product?.name
        titleName.font = UIFont.boldSystemFont(ofSize: 33)
        self.view.addSubview(titleName)
        titleName.mas_makeConstraints({ (make:MASConstraintMaker!) in
            make.top.equalTo()(self.view)?.offset()(80)
            make.height.equalTo()(44)
            make.centerX.equalTo()(self.view)
        })
        
        addButton .setTitle("ADD TO CARD", for: .normal)
        addButton .setTitleColor(UIColor.red, for: .normal)
        addButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 22)
        self.view.addSubview(addButton)
        addButton.mas_makeConstraints { (make:MASConstraintMaker!) in
            make.top.equalTo()(titleName.mas_bottom)?.offset()(15)
            make.centerX.equalTo()(self.view)
            make.height.equalTo()(titleName)
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
