//
//  CustomTableViewController.swift
//  CustomCellTest
//
//  Created by WangHao on 15/10/23.
//  Copyright © 2015年 Tuluobo. All rights reserved.
//

import UIKit

class CustomTableViewController: UITableViewController {

    //定义数据源
    var dataSource = [MyModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //这里是自定义cell的关键，需要注册Nib
        //还有这里一般的常量尽量写在一个文件中，我这里没有写出去为了让大家看明白
        let nib = UINib(nibName: "CustomTableViewCell", bundle: nil)
        self.tableView.registerNib(nib, forCellReuseIdentifier: "custom_cell")
        refresh()
    }

    //获得数据，这里一般通过网络获得数据
    func refresh(){
        for i in 0...10 {
            self.dataSource.append(MyModel(fd: "MyModel\(i)", sd: "\(i)"))
        }
        //一般通过网络获取数据都是异步的，所以这里要重新载入数据
        //测试使用的是自己生成数据，是串行，所以不用重新载入
        //self.tableView.reloadData()
    }

    // MARK: - Table view data source

    // 计算有多少 Section
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    // 计算有多少行
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return dataSource.count
    }

    // cell 的使用
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("custom_cell", forIndexPath: indexPath) as! CustomTableViewCell

        cell.data = self.dataSource[indexPath.row]

        return cell
    }
    
    // 设置每行的高度
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 120
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
