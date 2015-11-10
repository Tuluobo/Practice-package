//
//  TodoTableViewController.swift
//  LocalNotifications
//
//  Created by WangHao on 15/10/23.
//  Copyright © 2015年 Tuluobo. All rights reserved.
//

import UIKit

class TodoTableViewController: UITableViewController {

    var todoItems = [TodoItem]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        refreshList()
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "refreshList", name: "TodoListShouldRefresh", object: nil)
    }

    func refreshList(){
        self.todoItems = TodoList.sharedInstance.allItems()
        if(self.todoItems.count > 64){
            self.navigationItem.rightBarButtonItem?.enabled = false
        }
        self.tableView.reloadData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return todoItems.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("todoCell", forIndexPath: indexPath)
        
        let data = self.todoItems[indexPath.row]
        
        cell.textLabel?.text = data.title
        if data.isOverdue {
            cell.detailTextLabel?.textColor = UIColor.redColor()
        }else{
            cell.detailTextLabel?.textColor = UIColor.blackColor()
        }
        
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "'Due' MMM dd 'at' h:mm a"
        cell.detailTextLabel?.text = dateFormatter.stringFromDate(data.deadline)
        return cell
    }
    
    
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    

    
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            let item = todoItems.removeAtIndex(indexPath.row)
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
            TodoList.sharedInstance.removeItem(item)
            self.navigationItem.rightBarButtonItem!.enabled = true
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if let identifier = segue.identifier {
            switch identifier {
            case "addSegue":
                if let tvc = segue.destinationViewController as? TodoSchedulingViewController {
                    tvc.tTableView = self
                }
            default:break
            }
        }
    }
    
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
