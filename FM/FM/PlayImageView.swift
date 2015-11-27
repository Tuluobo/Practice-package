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
    
    let albumWidth: CGFloat = 160
    func initImage() {
        let xy = (self.frame.size.width - albumWidth) / 2
        let albumImageView = UIImageView(frame: CGRectMake(xy, xy, albumWidth, albumWidth))
        albumImageView.layer.cornerRadius = albumWidth / 2
        albumImageView.clipsToBounds = true
        
        self.addSubview(albumImageView)
    }

    func startRoatating() {
        let rotateAni = CABasicAnimation(keyPath: "transform.rotation")
        rotateAni.fromValue = 0.0
        rotateAni.toValue = 2.0 * M_PI
        rotateAni.duration = 20.0
        rotateAni.repeatCount = MAXFLOAT
        
        self.layer.addAnimation(rotateAni, forKey: nil)
    }
}
