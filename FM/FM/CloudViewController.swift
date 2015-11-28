//
//  CloudViewController.swift
//  FM
//
//  Created by WangHao on 15/11/27.
//  Copyright © 2015年 Tuluobo. All rights reserved.
//

import UIKit

class CloudViewController: BaseViewController {
    
    @IBOutlet weak var playBgImageView: UIImageView!
    @IBOutlet weak var playQuanImageView: PlayImageView!
    
    var isRotating = false
    var needleOriginTransform: CGAffineTransform!
    var needleImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // 进度条
        KVNProgress.setConfiguration(KVNProgressConfiguration.defaultConfiguration())
        // 导航栏
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "playBtn"), style: UIBarButtonItemStyle.Plain, target: self, action: "showChannels")
        // 唱盘中心图片
        self.playQuanImageView.albumImageView!.image = UIImage(named: "aaa.png")
        self.playQuanImageView.startRoatating()
        self.isRotating = true
        // 背景毛玻璃效果
        let blurEffect = UIBlurEffect(style: UIBlurEffectStyle.Light)
        let visualView = UIVisualEffectView(effect: blurEffect)
        visualView.alpha = 1.0
        visualView.frame = self.view.frame
        self.playBgImageView.image = UIImage(named: "aaa")
        self.playBgImageView.addSubview(visualView)
        //唱针初始化
        self.initNeedleImage()
    }

    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        //KVNProgress.show()
    }
    
    func showChannels() {
        
    }
    
    func initNeedleImage() {
        
        let scale: CGFloat = 276 / 414
        
        let screenSize = self.view.frame.size
        let x: CGFloat = screenSize.width * 0.32
        let y: CGFloat = 20.0
        let height = (screenSize.height - self.playQuanImageView.frame.size.height) * 0.64
        
        self.needleImageView = UIImageView(frame: CGRectMake(x, y, height*scale, height))
        self.needleImageView.image = UIImage(named: "play_needle")
        self.needleOriginTransform = self.needleImageView.transform
        self.setAnchorPoint(CGPointMake(48 / 276, 46 / 414), forView: self.needleImageView)
        
        self.view.addSubview(self.needleImageView)
    }
    
    @IBAction func onPauseClicked(sender: UIButton) {
        UIView.animateWithDuration(0.5, delay: 0, options: UIViewAnimationOptions.CurveLinear, animations: { () -> Void in
                if self.isRotating {
                    self.needleImageView.transform = CGAffineTransformMakeRotation(-CGFloat(M_PI/6))
                } else {
                    self.needleImageView.transform = self.needleOriginTransform
                }
            }, completion: { (finished) -> Void in
                if self.isRotating {
                    self.isRotating = false
                    self.playQuanImageView.pauseRotate()
                    sender.setTitle("Resume", forState: UIControlState.Normal)
                } else {
                    self.isRotating = true
                    self.playQuanImageView.resumeRotate()
                    sender.setTitle("Pause", forState: UIControlState.Normal)
                }
            }
        )
    }
    
    private func setAnchorPoint(anchorPoint: CGPoint, forView view: UIView) {
        var newPoint = CGPointMake(view.bounds.size.width * anchorPoint.x, view.bounds.size.height * anchorPoint.y)
        var oldPoint = CGPointMake(view.bounds.size.width * view.layer.anchorPoint.x, view.bounds.size.height * view.layer.anchorPoint.y)
        
        newPoint = CGPointApplyAffineTransform(newPoint, view.transform)
        oldPoint = CGPointApplyAffineTransform(oldPoint, view.transform)
        
        var position = view.layer.position
        position.x -= oldPoint.x
        position.x += newPoint.x
        
        position.y -= oldPoint.y
        position.y += newPoint.y
        
        view.layer.position = position
        view.layer.anchorPoint = anchorPoint
    }
}
