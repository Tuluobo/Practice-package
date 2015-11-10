//
//  CustomTableViewCell.swift
//  CustomCellTest
//
//  Created by WangHao on 15/10/23.
//  Copyright © 2015年 Tuluobo. All rights reserved.
//

import UIKit

class CustomTableViewCell: UITableViewCell {

    //数据
    var data: MyModel? {
        didSet {
            updateUI()
        }
    }
    
    @IBOutlet weak var firstLabel: UILabel!
    @IBOutlet weak var secondLabel: UILabel!
    
    //更新UI,这里借鉴了斯坦福大学的课程中的编程方法
    func updateUI() {
        
        self.firstLabel.text = nil
        self.secondLabel.text = nil
        
        if let data = self.data {
            self.firstLabel.text = data.fText
            self.secondLabel.text = data.sTest
        }
    }
    
}
