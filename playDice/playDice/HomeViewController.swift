//
//  ViewController.swift
//  playDice
//
//  Created by WangHao on 15/10/14.
//  Copyright © 2015年 Tuluobo. All rights reserved.
//

import UIKit

enum SelectType {
    case Big, Same, Small
}

class HomeViewController: UIViewController {

    @IBOutlet weak var dice1ImageView: UIImageView!
    @IBOutlet weak var dice2ImageView: UIImageView!
    @IBOutlet weak var dice3ImageView: UIImageView!
    @IBOutlet weak var playerMoney: UILabel!
    @IBOutlet weak var bossMoney: UILabel!
    
    var imageNum = 0
    var timer: NSTimer?
    let box = [1:"one",2:"two",3:"three",4:"four",5:"five",6:"six"]
    var dice1Num = 0
    var dice2Num = 0
    var dice3Num = 0
    var select = SelectType.Big
    
    @IBAction func buy(sender: UIButton) {
        switch sender.currentTitle! {
        case "买豹子":select = .Same
        case "买小":select = .Small
        default:select = .Big
        }

        //需要一个定时器来控制图片
        timer?.invalidate()
        timer = NSTimer.scheduledTimerWithTimeInterval(0.1, target: self, selector: "changeImage", userInfo: nil, repeats: true)
    }
    
    func changeImage(){
        let i1 = arc4random()%6 + 1
        dice1ImageView.image = UIImage(named: box[Int(i1)]!+".png")
        let i2 = arc4random()%6 + 1
        dice2ImageView.image = UIImage(named: box[Int(i2)]!+".png")
        let i3 = arc4random()%6 + 1
        dice3ImageView.image = UIImage(named: box[Int(i3)]!+".png")
        
        imageNum++
        
        if imageNum > 30 {
            timer?.invalidate()
            imageNum = 0
            dice1Num = Int(i1)
            dice2Num = Int(i2)
            dice3Num = Int(i3)
            judgeResult()
        }
        
    }

    func judgeResult(){
        
        let pMoney = NSNumberFormatter().numberFromString(playerMoney.text!)?.integerValue
        let bMoney = NSNumberFormatter().numberFromString(bossMoney.text!)?.integerValue

        switch select {
        case .Same:
            if dice1Num == dice2Num && dice1Num == dice3Num {
                playerMoney.text = "\(pMoney!+300)"
                bossMoney.text = "\(bMoney!-300)"
            }else{
                playerMoney.text = "\(pMoney!-300)"
                bossMoney.text = "\(bMoney!+300)"
            }
        case .Small:
            if dice1Num + dice2Num + dice3Num <= 11 {
                playerMoney.text = "\(pMoney!+300)"
                bossMoney.text = "\(bMoney!-300)"
            }else{
                playerMoney.text = "\(pMoney!-300)"
                bossMoney.text = "\(bMoney!+300)"
            }
        default:
            if dice1Num + dice2Num + dice3Num > 11 {
                playerMoney.text = "\(pMoney!+300)"
                bossMoney.text = "\(bMoney!-300)"
            }else{
                playerMoney.text = "\(pMoney!-300)"
                bossMoney.text = "\(bMoney!+300)"
            }
        }

    }

}

