//
//  TodayViewController.swift
//  Today
//
//  Created by WangHao on 15/11/29.
//  Copyright © 2015年 Tuluobo. All rights reserved.
//

import UIKit
import NotificationCenter
import ReactiveCocoa
import SnapKit

class TodayViewController: UIViewController, NCWidgetProviding, UITableViewDataSource, UITableViewDelegate {
    
    let cellID = "today"
    let datas = ["mqq://", "weico://", "alipay://", "weixin://", "sinaweibo://", "tuluobo://"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setLayout()
    }
    
    func setLayout() {
        let containerView = self.view
        
        let tableView = UITableView()
        tableView.separatorStyle = .SingleLine
        tableView.dataSource = self
        tableView.delegate = self
        tableView.registerClass(NSClassFromString("UITableViewCell"), forCellReuseIdentifier: cellID)
        containerView.addSubview(tableView)
        
        tableView.snp_makeConstraints { (make) -> Void in
            make.center.equalTo(containerView.snp_center)
            make.edges.equalTo(containerView.snp_edges)
        }
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func widgetPerformUpdateWithCompletionHandler(completionHandler: ((NCUpdateResult) -> Void)) {
        // Perform any setup necessary in order to update the view.

        // If an error is encountered, use NCUpdateResult.Failed
        // If there's no update required, use NCUpdateResult.NoData
        // If there's an update, use NCUpdateResult.NewData

        completionHandler(NCUpdateResult.NewData)
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // 修改wegit 的高度
        self.preferredContentSize = CGSizeMake(0, 42.0*CGFloat(self.datas.count))
        
        return self.datas.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(cellID, forIndexPath: indexPath) as UITableViewCell
        
        // or register cell class
        //tableView.registerClass(NSClassFromString("UITableViewCell"), forCellReuseIdentifier: cellID)
        //if cell == nil {
        //    cell = UITableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: cellID)
        //}
        
        cell.textLabel?.text = self.datas[indexPath.row]
        cell.textLabel?.textColor = UIColor.redColor()
        return cell
    }

    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if let url = NSURL(string: self.datas[indexPath.row]+"aa") {
            self.extensionContext?.openURL(url, completionHandler: nil)
        }
    }
    
}
