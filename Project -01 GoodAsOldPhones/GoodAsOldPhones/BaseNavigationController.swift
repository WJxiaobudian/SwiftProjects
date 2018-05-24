//
//  BaseNavigationController.swift
//  GoodAsOldPhones
//
//  Created by 王洁 on 2018/5/21.
//  Copyright © 2018年 王洁. All rights reserved.
//

import UIKit

class BaseNavigationController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationBar.barTintColor = UIColor.red
        // Do any additional setup after loading the view.
    }

    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        if (self.childViewControllers.count > 0) {
            let button = UIButton.init(type: .custom)
            button .setImage(UIImage.init(named: "navigator_btn_back"), for: .normal)
            button.sizeThatFits(CGSize(width:30, height:30))
            
            button.contentHorizontalAlignment = .left
            button.contentEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 0)
            button .addTarget(self, action: #selector(backClick), for: .touchUpInside)
            viewController.navigationItem.leftBarButtonItem = UIBarButtonItem.init(customView: button)
            viewController.hidesBottomBarWhenPushed = true
        }
        super .pushViewController(viewController, animated: animated)
    }
    
    @objc func backClick() {
        self.popViewController(animated: true)
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
