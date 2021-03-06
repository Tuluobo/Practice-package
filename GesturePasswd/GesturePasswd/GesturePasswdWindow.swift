//
//  GesturePasswdWindow.swift
//  GesturePasswd
//
//  Created by WangHao on 15/11/6.
//  Copyright © 2015年 Tuluobo. All rights reserved.
//

import UIKit
/**
 设置密码的状态类型
 
 - SETPWD:  第一次设置
 - SETPWD2: 第二次确认设置
 - CHECK:   验证
 - RESET:   重置
 */
enum GestureType {
    case SETPWD
    case SETPWD2
    case CHECK
    case RESET
}
/**
 *  手势密码协议
 */
protocol GesturePasswdWindowDelegate {
    func setPwdSuccess()    //设置成功
    func checkPwdSuccess()  //验证成功
    func checkPwdFailed()   //验证失败
}

class GesturePasswdWindow: UIWindow {
    
    private var btnSelectArr = [UIButton]()
    private var btnViews = [UIButton]()
    
    var degelete: GesturePasswdWindowDelegate!
    // 九宫格按钮间距
    private let bMargin: CGFloat = 25
    // 设置九宫格的按钮大小
    private var bWidth: CGFloat!
    // window总宽
    private var width: CGFloat!
    // 设置上下边距
    private var upAnddownMargin: CGFloat!
    
    var gestureType: GestureType! {
        didSet {
            switch gestureType! {
                case .SETPWD:
                    labelTitle.text = "请绘制新手势密码"
                case .SETPWD2:
                    labelTitle.text = "请再次绘制手势密码"
                case .CHECK:
                    labelTitle.text = "请使用手势密码解锁"
                case .RESET:
                    labelTitle.text = "请使用原手势密码解锁"
            }
        }
    }
    var labelTitle: UILabel!
    var selectImage = UIImage(named: "btnSelect")
    // 边框颜色
    var borderColor = UIColor(red: 126/255, green: 126/255, blue: 126/255, alpha: 1.0)
    // 连线颜色
    var inlineColor = UIColor(red: 238/255, green: 238/255, blue: 238/255, alpha: 1.0)
    
    
    //单例
    class var sharedInstance: GesturePasswdWindow {
        struct Static {
            static let instance: GesturePasswdWindow = GesturePasswdWindow(frame: UIScreen.mainScreen().bounds)
        }
        return Static.instance
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.rootViewController = UIViewController()
        self.backgroundColor = inlineColor
        
        self.width = self.frame.size.width
        self.bWidth = (width!-4*bMargin)/3.0
        self.upAnddownMargin = (self.frame.size.height - 3 * (bMargin+bWidth!))/7
        
        self.titleLabelView()
        self.nineBtnsView()
        self.backBtnView()
    }
    // 标题LabelView
    private func titleLabelView() {
        let widthLabel: CGFloat = width!
        self.labelTitle = UILabel(frame: CGRectMake(0, upAnddownMargin!*3, widthLabel, 20))
        
        
        labelTitle.textAlignment = NSTextAlignment.Center
        self.addSubview(labelTitle)
    }
    // 九个按钮View
    private func nineBtnsView(){
        
        let bY = upAnddownMargin!*5
        for i in 0..<9 {
            let button = UIButton(frame: CGRectMake(CGFloat(i%3)*(self.bWidth!+bMargin)+bMargin, bY+CGFloat(i/3)*(self.bWidth!+bMargin), self.bWidth!, self.bWidth!))
            button.backgroundColor = inlineColor
            //设置成圆形
            button.layer.borderWidth = 2.0
            button.layer.borderColor = self.borderColor.CGColor
            button.layer.cornerRadius = self.bWidth! / 2
            button.clipsToBounds = true
            //点击事件
            button.tag = i+1
            button.userInteractionEnabled = false
            self.btnViews.append(button)
            self.addSubview(button)
        }

    }
    // 返回按钮
    private func backBtnView() {
        let backBtn = UIButton(frame: CGRectMake(width!-140, 3 * (bMargin+self.bWidth!)+upAnddownMargin!*5, 120, 20))
        backBtn.setTitle("忘记手势密码", forState: UIControlState.Normal)
        backBtn.setTitleColor(self.borderColor, forState: UIControlState.Normal)
        backBtn.addTarget(self, action: "backPreView", forControlEvents: UIControlEvents.TouchUpInside)
        backBtn.userInteractionEnabled = true
        self.rootViewController?.view.addSubview(backBtn)
    }
    
    // 返回操作
    func backPreView(){
        self.hidden = true
        self.resignKeyWindow()
    }
    
    // 获取触摸点的坐标
    private func pointWithTouches(touches: NSSet) -> CGPoint? {
        if let touch = touches.anyObject() {
            let point = touch.locationInView(self)
            return point
        }
        return nil
    }
    
    private func buttonWithPoint(point: CGPoint) -> UIButton? {
        for btn in self.btnViews {
            if CGRectContainsPoint(btn.frame, point) {
                return btn
            }
        }
        return nil
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        // 获取触摸点
        if let point = self.pointWithTouches(touches) {
            if let selectBtn = self.buttonWithPoint(point) {
                self.changeSelectBtn(selectBtn)
            }
        }
        self.setNeedsDisplay()
    }
    
    override func touchesMoved(touches: Set<UITouch>, withEvent event: UIEvent?) {
        if let point = self.pointWithTouches(touches) {
            if let selectBtn = self.buttonWithPoint(point) {
                self.changeSelectBtn(selectBtn)
            }
        }
        self.setNeedsDisplay()
    }
    
    private func changeSelectBtn(selectBtn: UIButton){
        if !self.btnSelectArr.contains(selectBtn) {
            self.btnSelectArr.append(selectBtn)
            selectBtn.selected = true
            //加载图片
            selectBtn.setImage(UIImage(named: "btnSelect"), forState: UIControlState.Selected)
        }
    }
    
    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
        for btn in self.btnSelectArr {
            btn.selected = false
        }
        // 处理当前类型的密码
        if self.btnSelectArr.count > 0{
            self.passwdHandle()
        }
        self.btnSelectArr.removeAll()
        self.setNeedsDisplay()
    }
    
    //密码处理函数
    //这里是密码处理函数
    //需要做自己的处理逻辑的请在这里修改
    private func passwdHandle(){
        let dataHandle = DataHandle.sharedInstance
        
        let newpassword = self.getNumberWithBtn()
        if newpassword.count < 4 {
            self.labelTitle.text = "手势密码不能小于4位"
        }
        
        switch self.gestureType! {
        case .SETPWD:
            dataHandle.savePasswd(UserKey.CACHEPWD, password: newpassword)
            self.gestureType = .SETPWD2
        case .SETPWD2:
            if let password = dataHandle.hasPasswd(UserKey.CACHEPWD) {
                if newpassword.elementsEqual(password) {
                    dataHandle.savePasswd(UserKey.PASSWORD, password: newpassword)
                    dataHandle.deletePasswd(UserKey.CACHEPWD)
                    self.degelete.setPwdSuccess()
                } else {
                    self.labelTitle.text = "两次手势密码不一致，请再次绘制！"
                }
            }
        case .CHECK:
            if let password = dataHandle.hasPasswd(UserKey.PASSWORD) {
                if newpassword.elementsEqual(password) {
                    self.degelete.checkPwdSuccess()
                } else {
                    self.degelete.checkPwdFailed()
                }
            }
        case .RESET:
            if let password = dataHandle.hasPasswd(UserKey.PASSWORD) {
                print(">>\(password)")
                if newpassword.elementsEqual(password) {
                    self.gestureType = .SETPWD
                } else {
                    self.degelete.checkPwdFailed()
                }
            } else {
                self.gestureType = .SETPWD
            }
        }
    }
    
    private func getNumberWithBtn() ->[Int] {
        var password = [Int]()
        for btn in btnSelectArr {
            password.append(btn.tag)
        }
        return password
    }
    // 重写drawRect方法
    override func drawRect(rect: CGRect) {
        
        super.drawRect(rect)
        // 没有按钮选中
        if self.btnSelectArr.count == 0 {
            return
        }
        // 有按钮
        self.drawLine(nil)
    }
    
    func drawLine(point: CGPoint?){
        let path = UIBezierPath()   //  创建路径
        for index in 0..<self.btnSelectArr.count {
            if index == 0 {
                path.moveToPoint(self.btnSelectArr[index].center)
            } else {
                path.addLineToPoint(self.btnSelectArr[index].center)
            }
        }
        if let nowPoint = point {
            path.addLineToPoint(nowPoint)
        }
        path.lineWidth = 2.0        //  设置线宽
        self.borderColor.set()      //  设置颜色
        path.stroke()               //  绘制
    }
    
    func show(){
        self.windowLevel = UIWindowLevelNormal
        self.makeKeyWindow()
        self.hidden = false
    }
}
