//
//  ViewController.swift
//  Animations
//
//  Created by 王洁 on 2018/5/24.
//  Copyright © 2018年 王洁. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var tableView:UITableView?
    let items = ["2-Color", "Simple 2D Rotation", "Multicolor", "Multi Point Position", "BezierCurve Position",
                 "Color and Frame Change", "View Fade In", "Pop"]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        tableView = UITableView.init(frame: self.view.frame, style: .grouped)
        tableView?.delegate = self
        tableView?.dataSource = self
        self.view .addSubview(tableView!)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    // 动态显示cell
    override func viewWillAppear(_ animated: Bool) {
        tableView?.reloadData()
        let cells = tableView?.visibleCells
        let tableHeight = tableView?.bounds.size.height
        
        for  cell in cells! {
            cell.transform = CGAffineTransform(translationX: 0, y: tableHeight!)
        }
        
        var index = 0
        for cell in cells! {
            UIView.animate(withDuration: 1.5, delay: 0.05 * Double(index), usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: [], animations: {
                cell.transform = CGAffineTransform(translationX: 0, y: 0)
            }, completion: nil)
            index += 1
        }
    }
}




extension ViewController:UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 66
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.1
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0.1
    }
    
}

extension ViewController:UITableViewDataSource {

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "Cell")
        if (cell == nil) {
            cell = UITableViewCell.init(style: .default, reuseIdentifier: "Cell")
        }
        cell?.textLabel?.text = items[indexPath.row]
        return cell!
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView()
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return UIView()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let viewVC = DetailViewController()
        viewVC.typeTitle = self.items[indexPath.row]
        self.navigationController?.pushViewController(viewVC, animated: true)
    }
    
}

