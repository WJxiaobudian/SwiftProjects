//
//  NewsTableViewController.swift
//  Project -07 SimpleRSSReader
//
//  Created by 王洁 on 2018/5/14.
//  Copyright © 2018年 王洁. All rights reserved.
//

import UIKit

class NewsTableViewController: UITableViewController {

    fileprivate let feedParser = FeedParser()
    fileprivate let feedURL = "http://www.apple.com/main/rss/hotnews/hotnews.rss"
    fileprivate var rssItems:[(title:String, description:String, pubDate:String)]?
    fileprivate var cellStates:[CellState]?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.estimatedRowHeight = 140
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.separatorStyle = UITableViewCellSeparatorStyle.singleLine
        feedParser.parseFeed(feedURL: feedURL) { [weak self] rssItems in
            self?.rssItems = rssItems
            self?.cellStates = Array(repeating: .collapsed, count: rssItems.count)
            
            DispatchQueue.main.async {
                self?.tableView.reloadSections(IndexSet(integer: 0), with: .none)
            }
        }
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        
        guard let rssItems = rssItems else {
            return 0
        }
        
        return rssItems.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! NewsTableViewCell
        if let item = rssItems?[indexPath.row] {
            (cell.titleLabel.text, cell.contentLabel.text, cell.dataLabel.text) = (item.title, item.description, item.pubDate)
            if let cellState = cellStates?[indexPath.row] {
                cell.contentLabel.numberOfLines = cellState == .expanded ? 0 : 4
            }
        }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let cell = tableView.cellForRow(at: indexPath) as? NewsTableViewCell
        tableView.beginUpdates()
        cell?.contentLabel.numberOfLines = cell?.contentLabel.numberOfLines == 4 ? 0 : 4
        cellStates?[indexPath.row] = cell?.contentLabel.numberOfLines == 4 ? .collapsed : .expanded
        tableView.endUpdates()
    }
}






