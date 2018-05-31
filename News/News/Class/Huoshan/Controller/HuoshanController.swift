//
//  HuoshanController.swift
//  News
//
//  Created by WJ on 2018/5/16.
//  Copyright © 2018年 WJ. All rights reserved.
//

import UIKit
import SGPagingView
class HuoshanController: UIViewController {
    
    var pageContentView: SGPageContentView?
    
    private lazy var navigationBar = HuoshanNavigationBar()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.gray
        // Do any additional setup after loading the view.
        
        setupUI()
        
    }

}

extension HuoshanController {
    private func setupUI() {
        view.theme_backgroundColor = "colors.cellBackgroundColor"
        navigationItem.titleView = navigationBar
        MyThemeStyle.setupNavigationBarStyle(self, UserDefaults.standard.bool(forKey: IsNight))
        NotificationCenter.default.addObserver(self, selector: #selector(receiveDayOrNightButtonClicked(notification:)), name: NSNotification.Name(rawValue: "dayOrNightButtonClicked"), object: nil)
        NetworkTools.loadSmallVideoCategories {
            self.navigationBar.titleNames = $0.compactMap({$0.name})
            _ = $0.compactMap({ (newsTitle) -> () in
                let categoryVC = HuoshanCategoryController()
                categoryVC.newsTitle = newsTitle
                self.addChildViewController(categoryVC)
                
            })
            
            self.pageContentView = SGPageContentView(frame: self.view.bounds, parentVC: self, childVCs: self.childViewControllers)
            self.pageContentView!.delegatePageContentView = self as? SGPageContentViewDelegate
            self.view.addSubview(self.pageContentView!)
        
        }
        navigationBar.pageTitleViewSelected = {[weak self] in
            self?.pageContentView?.setPageContentViewCurrentIndex($0)
        }
    }
    
    /// 接收到了按钮点击的通知
    @objc func receiveDayOrNightButtonClicked(notification: Notification) {
        // 判断是否是夜间
        MyThemeStyle.setupNavigationBarStyle(self, UserDefaults.standard.bool(forKey: IsNight))
    }
}
