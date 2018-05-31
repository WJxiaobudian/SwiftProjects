//
//  HuoshanCategoryController.swift
//  News
//
//  Created by 王洁 on 2018/5/28.
//  Copyright © 2018年 王洁. All rights reserved.
//

import UIKit
import SVProgressHUD
class HuoshanCategoryController: UIViewController {

    var newsTitle = HomeNewsTitle()
    
    var collectionView:UICollectionView = UICollectionView.init(frame: UIScreen.main.bounds, collectionViewLayout: HuoshanLayout())
    var maxBehotTime:TimeInterval = 0.0
    var smallVideos = [NewsModel]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        SVProgressHUD.configuration()
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.theme_backgroundColor = "colors.tableViewBackgroundColor"
        collectionView.register(UINib.init(nibName: "HuoshanCell", bundle: nil), forCellWithReuseIdentifier: "collectionViewCell")
        self.view.addSubview(collectionView)
        setRefresh()
    }
    
    func setRefresh() {
        let header = RefreshHeader {[weak self] in
            NetworkTools.loadApiNewsFeeds(category: self!.newsTitle.category, ttFrom: .enterAuto) {
                
                if (self!.collectionView.mj_header.isRefreshing) {
                    self!.collectionView.mj_header.endRefreshing()
                }
                self!.maxBehotTime = $0
                self!.smallVideos = $1
                
                self!.collectionView.reloadData()
            }
        }
        header?.isAutomaticallyChangeAlpha = true
        header?.lastUpdatedTimeLabel.isHidden = true
        collectionView.mj_header = header
        header?.beginRefreshing()
        collectionView.mj_footer = RefreshAutoGifFooter(refreshingBlock: {[weak self] in
            NetworkTools.loadMoreApiNewsFeeds(category: self!.newsTitle.category, ttFrom: .enterAuto, maxBehotTime: self!.maxBehotTime, listCount: self!.smallVideos.count, {
                if self!.collectionView.mj_footer.isRefreshing {
                    self!.collectionView.mj_footer.endRefreshing()
                }
                self!.collectionView.mj_footer.pullingPercent = 0.0
                if $0.count == 0 {
                    SVProgressHUD.showInfo(withStatus: "没有更多数据啦！")
                    return
                }
                self!.smallVideos += $0
                self!.collectionView.reloadData()
            })
        })
        
        collectionView.mj_footer.isAutomaticallyChangeAlpha = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
extension HuoshanCategoryController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return smallVideos.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "collectionViewCell", for: indexPath) as? HuoshanCell
    
        cell?.smallVideo = smallVideos[indexPath.item]
        cell?.backgroundColor = UIColor.lightGray
        return cell!
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        let smallVideoVC = SmallVideoViewController()
//        smallVideoVC.originalIndex = indexPath.item
//        smallVideoVC.smallVideos = smallVideos
//        present(smallVideoVC, animated: false, completion: nil)
        
        let smallVideoVC = HuoshanSmallVideoController()
        
        present(smallVideoVC, animated: true, completion: nil)
        
    }

}


class HuoshanLayout: UICollectionViewFlowLayout {
    override func prepare() {
        super.prepare()
        let itemWidth = (KscreenWidth - 2) * 0.5
        itemSize = CGSize(width: itemWidth, height: itemWidth * 1.5)
        scrollDirection = .vertical
        minimumLineSpacing = 1.0
        minimumInteritemSpacing = 1.0
        
    }
}
