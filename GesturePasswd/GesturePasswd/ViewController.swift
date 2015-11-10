//
//  ViewController.swift
//  GesturePasswd
//
//  Created by WangHao on 15/11/6.
//  Copyright © 2015年 Tuluobo. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func btnToGesturePasswdView(sender: UIButton) {
        GesturePasswdWindow.sharedInstance.show()
    }

}

