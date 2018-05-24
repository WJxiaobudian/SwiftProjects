//
//  ProductsTableViewController.swift
//  GoodAsOldPhones
//
//  Created by 王洁 on 2018/5/21.
//  Copyright © 2018年 王洁. All rights reserved.
//

import UIKit

class ProductsTableViewController: UITableViewController {

    var product:[Products]?
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
//        tableView.frame = UIScreen.main.bounds
        tableView = UITableView.init(frame: UIScreen.main.bounds, style: .grouped)
        product = [
            Products(name: "1907 Wall Set", cellName: "image-cell1", fullName: "phone-fullscreen1"),
            Products(name: "1921 Dial Phone", cellName: "image-cell2", fullName: "phone-fullscreen2"),
            Products(name: "1937 Desk Set", cellName: "image-cell3", fullName: "phone-fullscreen3"),
            Products(name: "1984 Moto Portable", cellName: "image-cell4", fullName: "phone-fullscreen4")
            
        ]
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return product?.count ?? 0
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell:UITableViewCell? = tableView.dequeueReusableCell(withIdentifier: "tableView")
        
        if cell == nil {
            cell = UITableViewCell.init(style: .default, reuseIdentifier: "tableView")
        }
        guard let products = product else {return cell!}
        cell?.textLabel?.text = products[indexPath.row].name
        cell?.textLabel?.font = UIFont.systemFont(ofSize: 20)
        if let imageName = products[(indexPath as NSIndexPath).row].cellName {
            cell?.imageView?.image = UIImage(named: imageName)
        }

        return cell!
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let productDetail = ProductDetailController()
        productDetail.product = product?[indexPath.row]
        self.navigationController?.pushViewController(productDetail, animated: true)
    }
}
