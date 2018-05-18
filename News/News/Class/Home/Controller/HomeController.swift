//
//  HomeController.swift
//  News
//
//  Created by WJ on 2018/5/16.
//  Copyright © 2018年 WJ. All rights reserved.
//

import UIKit
import SGPagingView
import RxSwift
import RxCocoa
class HomeController: UIViewController {
    
    private var pageTitleView:SGPageTitleView?
    private var pageContentView:SGPageContentView?
    private var navigationBar = HomeNavigationView()
    private lazy var disposeBag = DisposeBag()
    
    private lazy var addChannleButton:UIButton = {
        let addChannelButton = UIButton(frame:CGRect(x: KscreenWidth - NewsTitleHeight, y: 0, width: NewsTitleHeight, height: NewsTitleHeight))
        addChannelButton.theme_setImage("images.add_channel_titlbar_thin_new_16x16_", forState: .normal)
        let separetorView = UIView(frame: CGRect(x: 0, y: NewsTitleHeight - 1, width: NewsTitleHeight, height: 1))
        separetorView.theme_backgroundColor = "colors.separatorViewColor"
        addChannelButton.addSubview(separetorView)
        return addChannelButton
    }()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        UIApplication.shared.keyWindow?.theme_backgroundColor = "colors.windowColor"
        navigationController?.navigationBar.barStyle = .black
        navigationController?.setNavigationBarHidden(false, animated: true)
        navigationController?.navigationBar.setBackgroundImage(UIImage(named: "navigation_background" + (UserDefaults.standard.bool(forKey: IsNight) ? "_night" : "")), for: .default)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        // Do any additional setup after loading the view.
        setupUI()
        clickAction()
    }
}

extension HomeController {
    private func setupUI() {
        view.theme_backgroundColor = "colors.cellBackgroundColor"
        navigationItem.titleView = navigationBar
        view.addSubview(addChannleButton)
        NetworkTools.loadHomeNewsTitleData {
            // 向数据库中插入数据
            NewsTitleTable().insert($0)
            let configuration = SGPageTitleViewConfigure()
            configuration.titleColor = .black
            configuration.titleSelectedColor = .globalRedColor()
            configuration.indicatorColor = .clear
            // 标题名称的数组
            self.pageTitleView = SGPageTitleView(frame: CGRect(x: 0, y: 0, width: KscreenWidth - NewsTitleHeight, height: NewsTitleHeight), delegate: self, titleNames: $0.compactMap({ $0.name }), configure: configuration)
            self.pageTitleView!.backgroundColor = .clear
            self.view.addSubview(self.pageTitleView!)
            // 设置子控制器
            _ = $0.compactMap({ (newsTitle) -> () in
                switch newsTitle.category {
                case .video: break            // 视频
//                    let videoTableVC = VideoTableViewController()
//                    videoTableVC.newsTitle = newsTitle
//                    videoTableVC.setupRefresh(with: .video)
//                    self.addChildViewController(videoTableVC)
                case .essayJoke: break        // 段子
//                    let essayJokeVC = HomeJokeViewController()
//                    essayJokeVC.isJoke = true
//                    essayJokeVC.setupRefresh(with: .essayJoke)
//                    self.addChildViewController(essayJokeVC)
                case .imagePPMM: break        // 街拍
//                    let imagePPMMVC = HomeJokeViewController()
//                    imagePPMMVC.isJoke = false
//                    imagePPMMVC.setupRefresh(with: .imagePPMM)
//                    self.addChildViewController(imagePPMMVC)
                case .imageFunny: break        // 趣图
//                    let imagePPMMVC = HomeJokeViewController()
//                    imagePPMMVC.isJoke = false
//                    imagePPMMVC.setupRefresh(with: .imageFunny)
//                    self.addChildViewController(imagePPMMVC)
                case .photos: break           // 图片,组图
//                    let homeImageVC = HomeImageViewController()
//                    homeImageVC.setupRefresh(with: .photos)
//                    self.addChildViewController(homeImageVC)
                case .jinritemai: break       // 特卖
//                    let temaiVC = TeMaiViewController()
//                    temaiVC.url = "https://m.maila88.com/mailaIndex?mailaAppKey=GDW5NMaKQNz81jtW2Yuw2P"
//                    self.addChildViewController(temaiVC)
                default : break
//                    let homeTableVC = HomeRecommendController()
//                    homeTableVC.setupRefresh(with: newsTitle.category)
//                    self.addChildViewController(homeTableVC)
                }
            })
            // 内容视图
            self.pageContentView = SGPageContentView(frame: CGRect(x: 0, y: NewsTitleHeight, width: KscreenWidth, height: self.view.height - NewsTitleHeight), parentVC: self, childVCs: self.childViewControllers)
            self.pageContentView?.delegatePageContentView = self
            self.view.addSubview(self.pageContentView!)
        }
    }
    
    private func clickAction() {
        navigationBar.didSelectAvatarButton = {
            self.navigationController?.pushViewController(MineController(), animated: true)
            
        }
        navigationBar.didSelectCameraButton = {
            
        }
        navigationBar.didSelectSearchButton = {
            
        }
        /// 添加频道点击
        addChannleButton.rx.controlEvent(.touchUpInside)
            .subscribe(onNext: { [weak self] in
                let homeAddCategoryVC = HomeAddCategoryController()
                homeAddCategoryVC.modalSize = (width: .full, height: .custom(size: Float(KscreenHeight - (IsIphoneX ? 44 : 20))))
                self!.present(homeAddCategoryVC, animated: true, completion: nil)
            })
            .disposed(by: disposeBag)
    }
}

// MARK: - SGPageTitleViewDelegate
extension HomeController: SGPageTitleViewDelegate, SGPageContentViewDelegate {
    /// 联动 pageContent 的方法
    func pageTitleView(_ pageTitleView: SGPageTitleView!, selectedIndex: Int) {
        self.pageContentView?.setPageContentViewCurrentIndex(selectedIndex)
    }
    
    /// 联动 SGPageTitleView 的方法
    func pageContentView(_ pageContentView: SGPageContentView!, progress: CGFloat, originalIndex: Int, targetIndex: Int) {
        self.pageTitleView!.setPageTitleViewWithProgress(progress, originalIndex: originalIndex, targetIndex: targetIndex)
    }
}
