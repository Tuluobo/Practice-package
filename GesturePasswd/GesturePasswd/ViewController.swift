//
//  ViewController.swift
//  GesturePasswd
//
//  Created by WangHao on 15/11/6.
//  Copyright © 2015年 Tuluobo. All rights reserved.
//

import UIKit

class ViewController: UIViewController, GesturePasswdWindowDelegete {

    var gesturePwd = GesturePasswdWindow.sharedInstance
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.gesturePwd.degelete = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    @IBAction func resetPasswd(sender: UIButton) {
        
        gesturePwd.gestureType = .RESET
        gesturePwd.show()
    }
    
    func setPwdSuccess() {
        let alert = UIAlertController(title: "手势密码", message: "手势密码设置成功", preferredStyle: UIAlertControllerStyle.Alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: { (_) -> Void in
            self.gesturePwd.hidden = true
            self.gesturePwd.resignKeyWindow()
        }))
        self.gesturePwd.rootViewController?.presentViewController(alert, animated: true, completion: nil)
    }
    
    func checkPwdSuccess() {
        let alert = UIAlertController(title: "手势密码", message: "手势密码验证成功", preferredStyle: UIAlertControllerStyle.Alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: { (_) -> Void in
            self.gesturePwd.hidden = true
            self.gesturePwd.resignKeyWindow()
        }))
        self.gesturePwd.rootViewController?.presentViewController(alert, animated: true, completion: nil)
    }
    
    func checkPwdFailed() {
        let alert = UIAlertController(title: "手势密码", message: "手势密码验证失败，请重新绘制", preferredStyle: UIAlertControllerStyle.Alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
        self.gesturePwd.rootViewController?.presentViewController(alert, animated: true, completion: nil)
    }
    
}

