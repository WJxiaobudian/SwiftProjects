//
//  MineController.swift
//  News
//
//  Created by WJ on 2018/5/17.
//  Copyright © 2018年 WJ. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift

class MineController: UITableViewController {
    private let disposeBag = DisposeBag()
    var sections = [[MyCellModel]]()
    var concerns = [MyConcern]()
    var headerView = NoLoginHeaderView()
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        // 夜间/日间模式
        navigationController?.navigationBar.setBackgroundImage(UIImage(named: "navigation_background_white" + (UserDefaults.standard.bool(forKey: IsNight) ? "_night" : "")), for: .default)
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.backgroundColor = UIColor.red
        tableView.tableFooterView = UIView()
        tableView.tableHeaderView = headerView
        tableView.tableHeaderView?.height = 250
        tableView.theme_backgroundColor = "colors.tableViewBackgroundColor"
        tableView.separatorStyle = .none
        tableView.register(FirstSectionCell.self, forCellReuseIdentifier: "FirstSectionCell")
        tableView.register(MyOtherCell.self, forCellReuseIdentifier: "MyOtherCell")
        
        NetworkTools.loadMyCellData {
            self.sections = $0
            self.tableView.reloadData()
            NetworkTools.loadMyConcern(completionHandler: {
                self.concerns = $0
                self.tableView.reloadSections(IndexSet(integer: 0), with: .automatic)
            })
        }
        
        headerView.moreLoginButtonClick = {
            let moreLoginVC = MoreLoginViewController()
            moreLoginVC.modalSize = (width: .full, height: .custom(size: Float(KscreenHeight - (IsIphoneX ? 44 : 20))))
            print("🍎")
            moreLoginVC.backgroundColor = UIColor.red
            self.present(moreLoginVC, animated: true, completion: nil)
        }
        
//        /// 更多按钮点击
//        headerView.moreLoginButton.rx.tap
//            .subscribe(onNext: { [weak self] in
//                let moreLoginVC = MoreLoginViewController()
//                moreLoginVC.modalSize = (width: .full, height: .custom(size: Float(KscreenHeight - (IsIphoneX ? 44 : 20))))
//                print("🍎")
//                self!.present(moreLoginVC, animated: true, completion: nil)
//            })
//            .disposed(by: disposeBag)
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return section == 1 ? 0 : 10
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: KscreenWidth, height: 10))
        view.theme_backgroundColor = "colors.tableViewBackgroundColor"
        return view
    }
    // 行高
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 && indexPath.row == 0 {
            return 114
        }
        return 40
    }
    // 组数
    override func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }
    
    // 每组的行数
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sections[section].count
    }
    
    // cell
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 && indexPath.row == 0 {
            var cell = tableView.dequeueReusableCell(withIdentifier: "FirstSectionCell", for: indexPath) as! FirstSectionCell
            if cell.isEqual(nil) {
                cell = FirstSectionCell(style: .default, reuseIdentifier: "FirstSectionCell")
            }
            cell.myCellModel = sections[indexPath.section][indexPath.row]
            cell.collectionView.isHidden = (concerns.count == 0 || concerns.count == 1)
            if concerns.count == 1 { cell.myConcern = concerns[0] }
            if concerns.count > 1 { cell.myConcerns = concerns }
            
            cell.myConcernSelected = { [weak self] in
                let userDetailVC = UserDetailController()
                userDetailVC.userId = $0.userid
                print("\(userDetailVC.userId)")
                self?.navigationController?.pushViewController(userDetailVC, animated: true)
                }
            return cell
            }
        let cell = MyOtherCell(style: .default, reuseIdentifier: "MyOtherCell")
        let myCellModel = sections[indexPath.section][indexPath.row]
        cell.leftLabel.text = myCellModel.text
        cell.rightLabel.text = myCellModel.grey_text
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if indexPath.section == 3 && indexPath.row == 1 { // 跳转到系统设置界面
            let settingVC = SettingViewController()
            settingVC.navigationItem.title = "设置"
            navigationController?.pushViewController(settingVC, animated: true)
        }
    }
    
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y
        if offsetY < 0 {
            let totalOffset = MyHeaderViewHeight + abs(offsetY)
            let f = totalOffset / MyHeaderViewHeight
            NoLoginHeaderView().bgImageView.frame = CGRect(x: -KscreenWidth * (f - 1) * 0.5, y: offsetY, width: KscreenWidth * f, height: totalOffset)
        }
    }
}
