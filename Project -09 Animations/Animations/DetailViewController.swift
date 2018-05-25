//
//  DetailViewController.swift
//  Animations
//
//  Created by 王洁 on 2018/5/25.
//  Copyright © 2018年 王洁. All rights reserved.
//

import UIKit


class DetailViewController: UIViewController {

    var typeTitle = ""
    var redImage = UIView()
    var animationButton = UIButton()

    var animate = Animate()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        self.title = typeTitle
        // Do any additional setup after loading the view.
        setupView()
    }

    func setupView() {
        
        if  self.typeTitle == "BezierCurve Position" {
            redImage = drawCircleView()
        } else if self.typeTitle == "View Fade In" {
            redImage = UIImageView(image: UIImage(named: "whatsapp"))
            redImage.frame = generalFrame
            redImage.center = generalCenter
        } else {
            redImage = drawRectView(UIColor.red, frame: generalFrame, center: generalCenter)
            
        }
        self.view .addSubview(redImage)
        
        animationButton = UIButton(type: .custom)
        animationButton.frame = CGRect(x: 100, y: 500, width: 200, height: 44)
        animationButton .setTitle("Animate", for: .normal)
        animationButton .setTitleColor(UIColor.red, for: .normal)
        animationButton.titleLabel?.font = UIFont .systemFont(ofSize: 33)
        animationButton .addTarget(self, action: #selector(animateButtonClick), for: .touchUpInside)
        self.view .addSubview(animationButton)
    }
    
    @objc private func animateButtonClick() {
        print("🍎")
        switch typeTitle {
        case "2-Color":
            animate.changeColor(.green, redImage)
        case "Simple 2D Rotation":
            animate.rotateView(Double.pi, redImage)
        case "Multicolor":
            animate.multiColor(.green, .blue, redImage)
        case "Multi Point Position":
            animate.mutilPosition(CGPoint(x: redImage.frame.origin.x, y: 100), CGPoint(x: redImage.frame.origin.x, y: 350), redImage)
        case "BezierCurve Position":
            var controlPoint1 = redImage.center
            controlPoint1.y -= 125.0
            var controlPoint2 = controlPoint1
            controlPoint2.x += 40.0
            controlPoint2.y -= 125.0
            var endPoint = redImage.center
            endPoint.x += 75.0
            animate.curvePath(endPoint, controlPoint1: controlPoint1, controlPoint2: controlPoint2, imageView: redImage)
            
        case "Color and Frame Change":
            let currentFrame = redImage.frame
            let firstFrame = currentFrame.insetBy(dx: -30, dy: -50)
            let secondFrame = firstFrame.insetBy(dx: 10, dy: 15)
            let thirdFrame = secondFrame.insetBy(dx: -15, dy: -20)
            animate.colorFrameChange(firstFrame, secondFrame, thirdFrame, .orange, .yellow, .green, redImage)
            
        case "View Fade In":
            animate.viewFadeIn(self.view, imageView: redImage)
        case "Pop":
            animate.Pop(redImage)
        default:
            let alert = makeAlert("Alert", message: "The animation not implemented yet", actionTitle: "OK")
            self.present(alert, animated: true, completion: nil)
            
        }
    }


}
