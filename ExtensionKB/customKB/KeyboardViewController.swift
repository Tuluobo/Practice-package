//
//  KeyboardViewController.swift
//  customKB
//
//  Created by WangHao on 15/12/2.
//  Copyright © 2015年 Tuluobo. All rights reserved.
//

import UIKit
import ReactiveCocoa
import SnapKit


class KeyboardViewController: UIInputViewController {

    var charDatas = [[String : String]]()
    var nextKeyboardButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.loadData()
        self.setupUI()
    }

    func loadData() {
        charDatas.append(["A":" .-"])
        charDatas.append(["B":" -..."])
        charDatas.append(["C":" -.-."])
        charDatas.append(["D":" -.."])
        charDatas.append(["E":" ."])
        charDatas.append(["F":" ..-."])
        charDatas.append(["G":" --."])
        charDatas.append(["H":" ...."])
        charDatas.append(["I":" .."])
        charDatas.append(["J":" .---"])
        charDatas.append(["K":" -.-"])
        charDatas.append(["L":" .-.."])
        charDatas.append(["M":" --"])
        charDatas.append(["N":" -."])
        charDatas.append(["O":" ---"])
        charDatas.append(["P":" .--."])
        charDatas.append(["Q":" .-."])
        charDatas.append(["R":" "])
        charDatas.append(["S":" ..."])
        charDatas.append(["T":" -"])
        charDatas.append(["U":" ..-"])
        charDatas.append(["V":" ...-"])
        charDatas.append(["W":" .--"])
        charDatas.append(["X":" -..-"])
        charDatas.append(["Y":" -.--"])
        charDatas.append(["Z":" --.."])
    }
    
    func setupUI() {
        
        let container:UIView = self.view
        
        // 切换输入法按钮
        nextKeyboardButton = UIButton(type: .System)
        nextKeyboardButton.setTitle("NEXT", forState: .Normal)
        nextKeyboardButton.backgroundColor = UIColor.blueColor()
        container.addSubview(nextKeyboardButton)
        
        nextKeyboardButton.snp_makeConstraints { (make) -> Void in
            make.size.equalTo(CGSizeMake(50, 50))
            make.left.equalTo(container.snp_left)
            make.bottom.equalTo(container.snp_bottom)
        }
        
        nextKeyboardButton.rac_signalForControlEvents(UIControlEvents.TouchUpInside).subscribeNext { (sender) -> Void in
            self.advanceToNextInputMode()
        }
        // 删除按钮
        let deletBtn = UIButton(type: UIButtonType.System)
        deletBtn.setTitle("DEl", forState: UIControlState.Normal)
        deletBtn.backgroundColor = UIColor.redColor()
        container.addSubview(deletBtn)
        
        deletBtn.snp_makeConstraints { (make) -> Void in
            make.size.equalTo(CGSizeMake(50, 50))
            make.right.equalTo(container.snp_right)
            make.bottom.equalTo(container.snp_bottom)
        }
        
        deletBtn.rac_signalForControlEvents(UIControlEvents.TouchUpInside).subscribeNext { (sender) -> Void in
            
            //删除按钮事件
            let textObj = self.textDocumentProxy
            if let _ = textObj.documentContextBeforeInput {
                textObj.deleteBackward()
            }
            
        }
        // 输入字符的布局 char button
        // 摩斯密码键盘
        var index = 0
        for item in self.charDatas {
            let section = index / 9
            let row = index % 9
            
            let w: CGFloat = 32
            let h: CGFloat = 32
            
            let charBtn = UIButton(type: .System)
            charBtn.setTitle(item.keys.first, forState: .Normal)
            charBtn.backgroundColor = UIColor.grayColor()
            container.addSubview(charBtn)
            
            charBtn.snp_makeConstraints(closure: { (make) -> Void in
                make.size.equalTo(CGSizeMake(w, h))
                make.top.equalTo(container.snp_top).offset(h*CGFloat(section))
                make.left.equalTo(container.snp_left).offset(w*CGFloat(row)+55)
            })
            
            //点击字符按钮的时候响应事件输入相应的摩斯密码
            charBtn.rac_signalForControlEvents(UIControlEvents.TouchUpInside).subscribeNext({ (sender) -> Void in
                
                //插入摩斯密码
                let textObj = self.textDocumentProxy
                textObj.insertText(item.values.first!)
            })
            
            index = index + 1
        }
        // Perform custom UI setup here
        

        
        
    }

    override func textWillChange(textInput: UITextInput?) {
        // The app is about to change the document's contents. Perform any preparation here.
    }

    override func textDidChange(textInput: UITextInput?) {
        // The app has just changed the document's contents, the document context has been updated.
    
        var textColor: UIColor
        let proxy = self.textDocumentProxy
        if proxy.keyboardAppearance == UIKeyboardAppearance.Dark {
            textColor = UIColor.whiteColor()
        } else {
            textColor = UIColor.blackColor()
        }
        self.nextKeyboardButton.setTitleColor(textColor, forState: .Normal)
    }

}
