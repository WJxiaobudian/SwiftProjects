//
//  HomeAddCategoryController.swift
//  News
//
//  Created by WJ on 2018/5/16.
//  Copyright © 2018年 WJ. All rights reserved.
//

import UIKit
import Masonry
import IBAnimatable

class HomeAddCategoryController: AnimatableModalViewController {
    
    var collectionView:UICollectionView = UICollectionView(frame: UIScreen.main.bounds, collectionViewLayout: AddCategoryFlowLayout())
    private var homeTitles = [HomeNewsTitle]()
    private var catagories = [HomeNewsTitle]()
    
    var isEidt = false {
        didSet {
            collectionView.reloadData()
        }
    }
    

    override func viewDidLoad() {
        
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        collectionView.backgroundColor = UIColor.white
        homeTitles = NewsTitleTable().selectAll()
        collectionView.register(AddCategoryCell.self, forCellWithReuseIdentifier: "AddCategoryCell")
        collectionView.register(ChannelRecommendCell.self, forCellWithReuseIdentifier: "ChannelRecommendCell")
        // 头部
        collectionView.register(MyChannelReusableView.self, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: "MyChannelReusableView")
        // 底部
        collectionView.register(ChannelRecommendReusableView.self, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: "ChannelRecommendReusableView")
        collectionView.allowsMultipleSelection = true

        collectionView.addGestureRecognizer(longPressRecognizer)
        
        NetworkTools.loadHomeCategoryRecommend {
            self.catagories = $0
            self.collectionView.reloadData()
        }
        
        setupViews()

       

    }
    private lazy var longPressRecognizer = UILongPressGestureRecognizer(target: self, action: #selector(longPressTarget))
    
    @objc private func longPressTarget(longPress:UILongPressGestureRecognizer) {
        NotificationCenter.default.post(name: Notification.Name(rawValue: "longPressTarget"), object: nil)
        
        let selectedPoint = longPress.location(in: collectionView)
        if let selectedIndexPath = collectionView.indexPathForItem(at: selectedPoint) {
            switch longPress.state {
            case .began:
                if isEidt && selectedIndexPath.section == 0 {
                    collectionView.beginInteractiveMovementForItem(at: selectedIndexPath)
                } else {
                    isEidt = true
                    collectionView.beginInteractiveMovementForItem(at: selectedIndexPath)
                }
            case .changed:
                if selectedIndexPath.item <= 1 {
                    collectionView.endInteractiveMovement()
                    break
                }
                collectionView.updateInteractiveMovementTargetPosition(longPress.location(in: longPressRecognizer.view))
            case .ended:
                collectionView.endInteractiveMovement()
            default:
                collectionView.cancelInteractiveMovement()
            }
        }   else {
            if selectedPoint.x < collectionView.bounds.minX || selectedPoint.x > collectionView.bounds.maxX || selectedPoint.y < collectionView.bounds.minY || selectedPoint.y > collectionView.bounds.maxY {
                collectionView.endInteractiveMovement()
            }
        }
    }
    
    func setupViews() {
        
        let backButton = UIButton(type: .custom)
        backButton.addTarget(self, action: #selector(closeButton), for: .touchUpInside)
        backButton.setImage(UIImage(named: "titlebar_close_24x24_"), for: .normal)
        self.view.addSubview(backButton)
        
        backButton.mas_makeConstraints { (make:MASConstraintMaker!) in
            make.top.equalTo()(self.view.mas_top)?.offset()(10)
            make.left.equalTo()(self.view.mas_left)?.offset()(10)
            make.width.height().equalTo()(30)
        }
        
        collectionView.delegate = self
        collectionView.dataSource = self
        self.view.addSubview(collectionView)
        collectionView.mas_makeConstraints { (make:MASConstraintMaker!) in
            make.top.equalTo()(backButton.mas_bottom)?.offset()(5)
            make.left.right().equalTo()(self.view)
            make.bottom.equalTo()(self.view)
        }
    }
    
    /// 移除通知
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    @objc private func closeButton() {
        dismiss(animated: true, completion: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension HomeAddCategoryController:AddCategoryCellDelegate {
    func deleteCategoryButtonClicked(of cell: AddCategoryCell) {
        let indexPath = collectionView.indexPath(for: cell)
        catagories.insert(homeTitles[indexPath!.item], at: 0)
        collectionView.insertItems(at: [IndexPath(item: 0, section: 1)])
        homeTitles.remove(at: indexPath!.item)
        collectionView.deleteItems(at: [IndexPath(item: indexPath!.item, section: 0)])
    }
}

extension HomeAddCategoryController:UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if indexPath.section == 0 {
            let channelResableView = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionElementKindSectionHeader, withReuseIdentifier: "MyChannelReusableView", for: indexPath) as! MyChannelReusableView
            channelResableView.channelReusableViewEditButtonClicked = { [weak self](sender) in
                self!.isEidt = sender.isSelected
                if !sender.isSelected {
                    collectionView.endInteractiveMovement()
                }
            }
            channelResableView.width = KscreenWidth - 15.0
            return channelResableView
        } else {
            let channelRecommendReusableView = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionElementKindSectionHeader, withReuseIdentifier: "ChannelRecommendReusableView", for: indexPath) as! ChannelRecommendReusableView
            channelRecommendReusableView.width = KscreenWidth - 15.0
            return channelRecommendReusableView
        }
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: KscreenWidth, height: 50)
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return section == 0 ? homeTitles.count : catagories.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.section == 0 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "AddCategoryCell", for: indexPath) as! AddCategoryCell
            cell.titleButton.setTitle(homeTitles[indexPath.item].name, for: .normal)
            cell.backgroundColor = UIColor(hexString: "f4f5f6")
            cell.isEdit = isEidt
            cell.AddCategoryDelegate = self
            return cell
        } else {
            let  cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ChannelRecommendCell", for: indexPath) as! ChannelRecommendCell
            cell.titleButton.setTitle(catagories[indexPath.item].name, for: .normal)
            return cell
        }
    }
    /// 点击了某一个 cell
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        // 点击上面一组，不做任何操作，点击下面一组的cell 会添加到上面的组里
        print("🍊")
        guard indexPath.section == 1 else {
            return
        }
        
        homeTitles.append(catagories[indexPath.item]) // 添加
        // 插入数据库
//        NewsTitleTable().insert(catagories[indexPath.item])
        collectionView.insertItems(at: [IndexPath(item: homeTitles.count - 1, section: 0)])
        catagories.remove(at: indexPath.item)
        collectionView.deleteItems(at: [IndexPath(item: indexPath.item, section: 1)])
    }
    
    func collectionView(_ collectionView: UICollectionView, canMoveItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    /// 移动 cell
    func collectionView(_ collectionView: UICollectionView, moveItemAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        // 固定第一、二个不能移动
        if destinationIndexPath.item <= 1 {
            collectionView.endInteractiveMovement()
            collectionView.reloadData()
            return
        }
        // 取出需要移动的 cell
        let title = homeTitles[sourceIndexPath.item]
        homeTitles.remove(at: sourceIndexPath.item)
        // 移动 cell
        if isEidt && sourceIndexPath.section == 0 {
            // 说明移动前后都在 第一组
            if destinationIndexPath.section == 0 {
                homeTitles.insert(title, at: destinationIndexPath.item)
            } else { // 说明移动后在 第二组
                catagories.insert(title, at: destinationIndexPath.item)
            }
        }
    }
    
    /// 每个 cell 之间的间距
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
    }
    
}

class AddCategoryFlowLayout: UICollectionViewFlowLayout {
    override func prepare() {
        super.prepare()
        itemSize = CGSize(width: (KscreenWidth - 50) * 0.25, height: 44)
        minimumLineSpacing = 10
        minimumInteritemSpacing = 10
    }
}
