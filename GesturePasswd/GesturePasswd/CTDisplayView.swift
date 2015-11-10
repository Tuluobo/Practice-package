//
//  CTDisplayView.swift
//  GesturePasswd
//
//  Created by WangHao on 15/11/6.
//  Copyright © 2015年 Tuluobo. All rights reserved.
//

import UIKit

class CTDisplayView: UIView {

    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        super.drawRect(rect)
        
        //1.得到当前绘制画布的上下文
        let content = UIGraphicsGetCurrentContext()
        
        //2.将坐标系上下翻转
        CGContextSetTextMatrix(content, CGAffineTransformIdentity)
        CGContextTranslateCTM(content, 0, self.bounds.size.height)
        CGContextScaleCTM(content, 1.0, -1.0)
        
        //3.创建绘制的区域
        let path = CGPathCreateMutable()
        CGPathAddRect(path, nil, self.bounds)
        
        //4.
        let attString = NSAttributedString(string: "Hello, World")
        let framestter = CTFramesetterCreateWithAttributedString(attString)
        let frame = CTFramesetterCreateFrame(framestter, CFRangeMake(0, attString.length), path, nil)
        
        //5.
        CTFrameDraw(frame, content!)
        
    }


}
