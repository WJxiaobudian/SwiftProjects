//
//  HuoshanSmallVideoController.swift
//  News
//
//  Created by 王洁 on 2018/5/29.
//  Copyright © 2018年 王洁. All rights reserved.
//

import UIKit
import Masonry
import IBAnimatable
import RxSwift
import RxCocoa
import BMPlayer
import NVActivityIndicatorView
import SnapKit

class HuoshanSmallVideoController: UIViewController {
    /// 小视频数组
    var smallVideos = [NewsModel]()
    private lazy var player = BMPlayer(customControlView: SmallVideoPlayerCustomView())

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        view.backgroundColor = UIColor.black
        
        setupTopView()
        setupBottomView()
        
    }
    
    func setupTopView() {
        
        let topView = UIView()
        topView.frame = CGRect(x: 0, y: 40, width: KscreenWidth, height: 40)
        self.view .addSubview(topView)
        
        let backButton = UIButton(type: .custom)
        backButton .setImage(UIImage(named: "ImgPic_close_24x24_"), for: .normal)
        backButton .addTarget(self, action: #selector(backButtonClick), for: .touchUpInside)
        topView .addSubview(backButton)
        backButton .mas_makeConstraints { (make:MASConstraintMaker!) in
            make.centerY.equalTo()(topView)
            make.left.equalTo()(topView.mas_left)?.offset()(15)
            make.width.equalTo()(40)
        }
        
        let titleImage = UIImageView()
        titleImage.image = UIImage(named: "huoshan_logo_new_100x28_")
        topView .addSubview(titleImage)
        titleImage .mas_makeConstraints { (make:MASConstraintMaker!) in
            make.centerX.equalTo()(topView)
            make.width.equalTo()(100)
            make.centerY.equalTo()(topView)
        }
    }
    
    func setupBottomView() {
        let bottomView = UIView()
//        bottomView.frame = CGRect(x: 0, y: KscreenHeight - 66, width: KscreenWidth, height: 66);
        self.view .addSubview(bottomView)
        bottomView .mas_makeConstraints { (make:MASConstraintMaker!) in
            make.bottom.equalTo()(IsIphoneX ? -34 : 0)
            make.left.right().equalTo()(self.view)
            make.height.equalTo()(44)
        }
        
        let shareButton = UIButton(type: .custom)
        shareButton .setImage(UIImage(named: "icon_details_share_24x24_"), for: .normal)
        bottomView .addSubview(shareButton)
        shareButton .mas_makeConstraints({ (make:MASConstraintMaker!) in
            make.centerY.equalTo()(bottomView)
            make.right.equalTo()(bottomView.mas_right)?.offset()(-20)
            make.width.equalTo()(35);
        })
        
        let praiseButton = UIButton(type: .custom)
        praiseButton .setImage(UIImage(named: "hts_vp_like_24x24_"), for: .normal)
        bottomView .addSubview(praiseButton)
        praiseButton .mas_makeConstraints { (make:MASConstraintMaker!) in
            make.centerY.equalTo()(bottomView)
            make.right.equalTo()(shareButton.mas_left)?.offset()(-5)
            make.width.equalTo()(shareButton)
        }
        
        let commentButton = UIButton(type: .custom)
        commentButton .setImage(UIImage(named: "icon_details_comment_24x24_"), for: .normal)
        bottomView .addSubview(commentButton)
        commentButton .mas_makeConstraints { (make:MASConstraintMaker!) in
            make.right.equalTo()(praiseButton.mas_left)?.offset()(-5)
            make.centerY.equalTo()(bottomView)
            make.width.equalTo()(shareButton)
        }
        
        let animationView = AnimatableView()
        animationView.backgroundColor = UIColor(red: 33/255, green: 33/255, blue: 33/255, alpha: 1)
        animationView.layer.cornerRadius = 15
        animationView.layer.masksToBounds = true
        bottomView .addSubview(animationView)
        animationView .mas_makeConstraints { (make:MASConstraintMaker!) in
            make.height.equalTo()(35)
            make.right.equalTo()(commentButton.mas_left)?.offset()(-10)
            make.left.equalTo()(bottomView)?.offset()(10)
            make.centerY.equalTo()(bottomView)
        }
        
        let animationButton = UIButton(type: .custom)
        animationButton .setImage(UIImage(named: "write_white_24x24"), for: .normal)
        animationButton .setTitle("写评论", for: .normal)
        animationButton .setTitleColor(UIColor.white, for: .normal)
        bottomView .addSubview(animationButton)
        animationButton .mas_makeConstraints { (make:MASConstraintMaker!) in
            make.centerY.equalTo()(animationView)
            make.left.equalTo()(animationView)
            make.width.equalTo()(100)
        }
    }
    
    @objc private func backButtonClick() {
        self .dismiss(animated: true, completion: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    /// 设置播放器
    private func setupPlayer(currentIndex: Int) {
        // 当前的视频
        let smallVide = smallVideos[currentIndex]
        if let videoURLString = smallVide.raw_data.video.play_addr.url_list.first {
            // https://aweme.snssdk.com/aweme/v1/play/?video_id=887cc4819fd543e68125b471142de2ee&line=0&app_id=13
            // http://v9-dy.ixigua.com/f0c5b6992b84ec8581be670a9f0e6db6/5a5f3713/video/m/220dcaa08afe2814fe982a551581d7051c311518ee4000028f420dbd167/
            let dataTask = URLSession.shared.dataTask(with: URL(string: videoURLString)!, completionHandler: { (data, response, error) in
                // 货到主线程添加播放器
                DispatchQueue.main.async {
                    // 获取当前的 cell
                    let cell = self.collectionView.cellForItem(at: IndexPath(item: currentIndex, section: 0)) as! SmallVideoCell
                    if self.player.isPlaying { self.player.pause() }
                    // 先把 bgImageView 的子视图移除，再添加
                    for subview in cell.bgImageView.subviews { subview.removeFromSuperview() }
                    cell.bgImageView.addSubview(self.player)
                    self.player.snp.makeConstraints({ $0.edges.equalTo(cell.bgImageView) })
                    let asset = BMPlayerResource(url: URL(string: response!.url!.absoluteString)!)
                    self.player.setVideo(resource: asset)
                }
            })
            dataTask.resume()
        }
    }
}

// MARK: - UICollectionViewDelegate, UICollectionViewDataSource
extension HuoshanSmallVideoController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return smallVideos.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.ym_dequeueReusableCell(indexPath: indexPath) as SmallVideoCell
        cell.smallVideo = smallVideos[indexPath.item]
        // 头像按钮名按钮点击
        cell.didSelectAvatarOrNameButton = {
            let postCommentView = PostCommentView.loadViewFromNib()
            postCommentView.placeholderLabel.text = "优质评论将会被优先展示"
            postCommentView.isEmojiButtonSelected = false
            UIApplication.shared.keyWindow?.backgroundColor = .white
            UIApplication.shared.keyWindow?.addSubview(postCommentView)
        }
        return cell
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let currentIndex = Int(scrollView.contentOffset.x / scrollView.width + 0.5)
        // 根据当前索引设置播放器
        setupPlayer(currentIndex: currentIndex)
    }
}
