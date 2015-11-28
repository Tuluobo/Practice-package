//
//  PlayImageView.swift
//  FM
//
//  Created by WangHao on 15/11/27.
//  Copyright © 2015年 Tuluobo. All rights reserved.
//

import UIKit

class PlayImageView: UIImageView {

    var albumImageView: UIImageView?
    
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        self.initImage()
    }
    
    let albumWidth: CGFloat = 184
    func initImage() {
        let xy = (self.frame.size.width - albumWidth) / 2
        self.albumImageView = UIImageView(frame: CGRectMake(xy, xy, albumWidth, albumWidth))
        self.albumImageView!.clipsToBounds = true
        self.albumImageView!.layer.cornerRadius = albumWidth / 2
        
        self.addSubview(self.albumImageView!)
    }

    func startRoatating() {
        let rotateAni = CABasicAnimation(keyPath: "transform.rotation")
        rotateAni.fromValue = 0.0
        rotateAni.toValue = 2.0 * M_PI
        rotateAni.duration = 20.0
        rotateAni.repeatCount = MAXFLOAT
        
        self.layer.addAnimation(rotateAni, forKey: nil)
    }
    
    func pauseRotate() {
        let pausedTime = self.layer.convertTime(CACurrentMediaTime(), toLayer: nil)
        self.layer.speed = 0.0
        self.layer.timeOffset = pausedTime
    }
    
    func resumeRotate() {
        let pausedTime = self.layer.timeOffset
        self.layer.speed = 1.0
        self.layer.timeOffset = 0.0
        self.layer.beginTime = 0.0
        let timeSincePause = self.layer.convertTime(CACurrentMediaTime(), toLayer: nil) - pausedTime
        layer.beginTime = timeSincePause
    }
    
}
