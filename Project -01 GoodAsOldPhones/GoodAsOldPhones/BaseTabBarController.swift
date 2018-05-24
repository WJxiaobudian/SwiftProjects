//
//  BaseTabBarController.swift
//  GoodAsOldPhones
//
//  Created by 王洁 on 2018/5/21.
//  Copyright © 2018年 王洁. All rights reserved.
//

import UIKit

class BaseTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        addChildVC(ProductsTableViewController(), titleName: "Products", normalIcon: "", selectedIcon: "")
        addChildVC(UsViewController(), titleName: "Us", normalIcon: "", selectedIcon: "")
    }
    
    private func addChildVC(_ controllerVC:UIViewController, titleName:String, normalIcon:String, selectedIcon:String) {
        
        controllerVC.title = titleName
        controllerVC.tabBarItem.image = UIImage(named: normalIcon)?.withRenderingMode(.alwaysOriginal)
        controllerVC.tabBarItem.selectedImage = UIImage(named: selectedIcon)?.withRenderingMode(.alwaysOriginal)
        self.addChildViewController(BaseNavigationController(rootViewController: controllerVC))
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
