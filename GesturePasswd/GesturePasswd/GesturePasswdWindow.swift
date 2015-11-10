//
//  GesturePasswdWindow.swift
//  GesturePasswd
//
//  Created by WangHao on 15/11/6.
//  Copyright © 2015年 Tuluobo. All rights reserved.
//

import UIKit

class GesturePasswdWindow: UIWindow {
    
    //单例实现
    class var sharedInstance: GesturePasswdWindow {
        struct Static {
            static let instance: GesturePasswdWindow = GesturePasswdWindow(frame: UIScreen.mainScreen().bounds)
        }
        return Static.instance
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        let bColor = UIColor(red: 238/255, green: 238/255, blue: 238/255, alpha: 1.0)
        let width = self.frame.size.width
        self.rootViewController = UIViewController()
        self.backgroundColor = bColor
        //设置九宫格的大小
        let bMargin: CGFloat = 25
        let bWidth = (width-4*bMargin)/3.0
        let upAnddownMargin:CGFloat = (self.frame.size.height - 3 * (bMargin+bWidth))/7
        
        let widthLabel: CGFloat = 160
        let label = UILabel(frame: CGRectMake((width-widthLabel)/2.0, upAnddownMargin*3, widthLabel, 20))
        label.text = "请使用手势密码解锁"
        self.addSubview(label)
        
        
        let by = upAnddownMargin*5
        for i in 0..<9 {
            let button = UIButton(frame: CGRectMake(CGFloat(i%3)*(bWidth+bMargin)+bMargin, by+CGFloat(i/3)*(bWidth+bMargin), bWidth, bWidth))
            button.backgroundColor = bColor
            button.setTitle("按钮\(i)", forState: UIControlState.Normal)
            //设置成圆形
            button.layer.borderWidth = 2.0
            button.layer.borderColor = UIColor(red: 126/255, green: 126/255, blue: 126/255, alpha: 1.0).CGColor
            button.layer.cornerRadius = bWidth / 2
            button.clipsToBounds = true
            //点击事件
            button.tag = i+1
            button.addTarget(self, action: "selBtn", forControlEvents: UIControlEvents.TouchUpInside)
            self.addSubview(button)
        }
        
    }
    
    func selBtn(){
        print("123")
    }

    func show(){
        self.windowLevel = UIWindowLevelNormal
        self.makeKeyAndVisible()
        //self.hidden = false
    }
}
