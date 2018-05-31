//
//  UserDetailController.swift
//  News
//
//  Created by WJ on 2018/5/17.
//  Copyright © 2018年 WJ. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift

// MARK: - 自定义一个可以接受上层 tableView 手势的 tableView
class UserDetailTableView: UITableView, UIGestureRecognizerDelegate {
    // 底层 tableView 实现这个 UIGestureRecognizerDelegate 代理方法，就可以响应上层 tableView 的滑动手势，
    // otherGestureRecognizer 就是它上层的 view 持有的手势，这里的话，上层应该是 scrollView 和 顶层 tabelview
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        // 保证其他手势的存在
        guard let otherView = otherGestureRecognizer.view else { return false }
        // 如果其他手势的 view 是 UIScrollView，就不能让 UserDetailTableView 响应
        if otherView.isMember(of: UIScrollView.self) { return false }
        // 其他手势是 tableView 的 pan 手势，就让他响应
        let isPan = gestureRecognizer.isKind(of: UIPanGestureRecognizer.self)
        if isPan && otherView.isKind(of: UIScrollView.self) { return true }
        return false
    }
}

class UserDetailController: UIViewController {
    var userId: Int = 0
    var userDetail = UserDetail()
    var navigationBar = UserDetailNavigationBar()
    private lazy var headerView = UserDetailHeaderView()
    private lazy var tableVie : UserDetailTableView = {
        let tableView = UserDetailTableView.init(frame: CGRect(x: 0, y: 0, width: KscreenWidth, height: KscreenHeight), style: .plain)
        tableView.delegate = self;
        tableView.dataSource = self;
        return tableView
    }()
    
    private lazy var myBottomView:UserDetailBottomView = {
        let myBottomView = UserDetailBottomView(frame: CGRect(x: 0, y: 0, width: KscreenWidth, height: 44))
        myBottomView.delegate = self as? UserDetailBottomViewDelegate
        return myBottomView
    }()
    
    private lazy var topTabScrollView = TopTabScrollView(frame: CGRect(x: 0, y: 0, width: KscreenWidth, height: 40))
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
       navigationController?.setNavigationBarHidden(false, animated: animated)
        navigationController?.navigationBar.setBackgroundImage(UIImage(named: "navigation_background_clear"), for: .default)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        
        
        setupUI()
    }
    

    func setupUI() {
        self.view.theme_backgroundColor = "colors.cellBackgroundColor"
        navigationItem.leftBarButtonItem = UIBarButtonItem()
        navigationController?.navigationBar.barStyle = .black
        navigationItem.titleView = navigationBar
        
        NetworkTools.loadUserDetail(userId: userId) { (userDetail) in
            print("\(userDetail)")

            NetworkTools.loadUserDetailDongTaiList(userId: self.userId, maxCursor: 0, completionHandler: { (cursor, dongtais) in

                if userDetail.bottom_tab.count != 0 {
//                    self.bottom
                }
            })
        }
    }
}

extension UserDetailController: UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
         return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
}

extension UserDetailController:UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var  cell:UITableViewCell? = tableView.dequeueReusableCell(withIdentifier: "CELL")
        if (cell == nil) {
            cell = UITableViewCell.init(style: .default, reuseIdentifier: "CELL")
        }
        return cell!
    }
}
