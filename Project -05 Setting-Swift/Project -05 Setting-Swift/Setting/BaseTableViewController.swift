//
//  BaseTableViewController.swift
//  Project -05 Setting-Swift
//
//  Created by 王洁 on 2018/5/14.
//  Copyright © 2018年 王洁. All rights reserved.
//

import UIKit

var groups:NSMutableArray = {
    let groups = NSMutableArray()
    return groups
}()

class BaseTableViewController: UITableViewController {
    
    lazy var groups:NSMutableArray = {
        let groups = NSMutableArray()
        return groups
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView = UITableView.init(frame: UIScreen.main.bounds, style: .grouped)
        self.navigationController?.navigationBar.barStyle = .black

    }


    override func numberOfSections(in tableView: UITableView) -> Int {
        return groups.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let group = groups[section] as! GroupItem
        return group.items.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       
        let cell = BaseCell .settingCellWithTableView(tableView: tableView) as? BaseCell
        let group = groups[indexPath.section] as? GroupItem
        cell?.setItem(group?.items[indexPath.row] as? SettingItem)
        
        return cell!
        
    }
    
    override func tableView(_ tableView: UITableView, titleForFooterInSection section: Int) -> String? {
        let group = groups[section] as? GroupItem
        return group?.footTitle
        
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let  group = groups[section] as? GroupItem
        return group?.headTitle
        
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let group = groups[indexPath.section] as? GroupItem
        let item = group?.items[indexPath.row] as? SettingItem
        if ((item?.operation) != nil) {
            item?.operation!()
        }
        tableView .deselectRow(at: indexPath, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0 {
            return 0.1
        }
        return 15
    }
    
    override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 5
    }
    
    override func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView()
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return UIView()
    }

}
