//
//  Animate.swift
//  Animations
//
//  Created by 王洁 on 2018/5/25.
//  Copyright © 2018年 王洁. All rights reserved.
//

import UIKit



class Animate: NSObject {
    
    fileprivate let duration = 2.0
    fileprivate let delay = 0.2
    fileprivate let scale = 1.2
    
    
    /// 两种颜色改变
    func changeColor(_ color:UIColor, _ imageView:UIView) {
     
        UIView.animate(withDuration: duration, animations: {
            imageView.backgroundColor = color
        }, completion: nil)
    }
    
    /// 三种颜色改变
    func multiColor(_ firstColor:UIColor, _ secondColor:UIColor, _ imageView:UIView) {
        UIView.animate(withDuration: duration, animations: {
            imageView.backgroundColor = firstColor
        }) { (finished ) in // 第二种颜色改变结束之后继续第三种颜色的改变
            self.changeColor(secondColor, imageView)
        }
    }
    
    /// 从一个位置移动到另一个位置
    func mutilPosition(_ firstPos:CGPoint, _ secondPos:CGPoint, _ imageView:UIView)  {
        func simplePosition(_ pos:CGPoint) {
            UIView.animate(withDuration: duration, animations: {
                imageView.frame.origin = pos
            }, completion: nil)
        }
        
        UIView.animate(withDuration: duration, animations: {
            imageView.frame.origin = firstPos
        }) { (finished ) in
            simplePosition(secondPos)
        }
    }
    
    /// 中心旋转
    func rotateView(_ angel:Double, _ imageView:UIView) {
        UIView.animateKeyframes(withDuration: duration, delay: 0.0, options: [.repeat], animations: {
            imageView.transform = CGAffineTransform(rotationAngle: CGFloat(angel))
        }, completion: nil)
    }
    
    /// frame和color 同时改变
    func colorFrameChange(_ firstFrame:CGRect, _ secondFrame: CGRect, _ thirdFrame:CGRect, _ firstColor:UIColor, _ secondColor:UIColor, _ thirdColor:UIColor  ,_ imageView:UIView) {
        
        UIView.animate(withDuration: duration, animations: {
            imageView.backgroundColor = firstColor
            imageView.frame = firstFrame
        }) { (finished ) in
            UIView.animate(withDuration: self.duration, animations: {
                imageView.backgroundColor = secondColor
                imageView.frame = secondFrame
            }, completion: { (finished ) in
                UIView.animate(withDuration: self.duration, animations: {
                    imageView.backgroundColor = thirdColor
                    imageView.frame = thirdFrame
                }, completion: nil)
            })
        }
    }
    
    /// 从一个点到另一个中，中间有高度落差
    func curvePath(_ endPoint:CGPoint, controlPoint1:CGPoint, controlPoint2:CGPoint, imageView:UIView) {
        let path = UIBezierPath()
        path.move(to: imageView.center)
        path.addCurve(to: endPoint, controlPoint1: controlPoint1, controlPoint2: controlPoint2)
        let  anim = CAKeyframeAnimation(keyPath: "position")
        anim.path = path.cgPath
        anim.duration = duration
        imageView.layer.add(anim, forKey: "animate position along path")
        imageView.center = endPoint
    }
    
    /// 图片的缓慢改变为另一张图片
    func viewFadeIn(_ view: UIView, imageView:UIView) {
        let secondView = UIImageView(image: UIImage(named: "facebook"))
        secondView.frame = imageView.frame
        secondView.alpha = 0.0
        
        view.insertSubview(secondView, aboveSubview: imageView)
        UIView.animate(withDuration: duration, animations: {
            secondView.alpha = 1.0
            imageView.alpha = 0.0
        }, completion: nil)
    }
    
    /// 放大缩小
    func Pop(_ imageView:UIView) {
        UIView.animate(withDuration: duration / 4, animations: {
            imageView.transform = CGAffineTransform(scaleX: CGFloat(self.scale), y: CGFloat(self.scale))
        }) { (finished) in
            UIView.animate(withDuration: self.duration / 4, animations: {
                imageView.transform = CGAffineTransform.identity
            })
        }
    }
}
