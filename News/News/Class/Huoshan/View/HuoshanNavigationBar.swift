//
//  HuoshanNavigationBar.swift
//  News
//
//  Created by 王洁 on 2018/5/28.
//  Copyright © 2018年 王洁. All rights reserved.
//

import UIKit
import SGPagingView
class HuoshanNavigationBar: UIView {

    var pageTitleViewSelected:((_ index:Int) -> ())?
    
    var titleNames = [String]() {
        didSet {
            
            let configuration = SGPageTitleViewConfigure()
            configuration.titleColor = .black
            configuration.titleSelectedColor = .globalRedColor()
            configuration.indicatorColor = .clear
            pageTitleView = SGPageTitleView(frame: CGRect(x: -10, y: 0, width: KscreenWidth, height: 44), delegate: self, titleNames: titleNames, configure: configuration)
            pageTitleView?.backgroundColor = .clear
            addSubview(pageTitleView!)
        }
    }
    
    var pageTitleView:SGPageTitleView?
    override var intrinsicContentSize:CGSize {
        return UILayoutFittingExpandedSize
    }
    
    override var frame:CGRect {
        didSet {
            super.frame = CGRect(x: 0, y: 0, width: KscreenWidth, height: 44)
        }
    }
}

extension HuoshanNavigationBar:SGPageTitleViewDelegate {
    func pageTitleView(_ pageTitleView: SGPageTitleView!, selectedIndex: Int) {
        pageTitleViewSelected?(selectedIndex)
    }
}
