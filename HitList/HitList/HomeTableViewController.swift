//
//  HomeTableViewController.swift
//  HitList
//
//  Created by WangHao on 15/12/9.
//  Copyright © 2015年 Tuluobo. All rights reserved.
//

import UIKit
import CoreData

class HomeTableViewController: UITableViewController {

    var people = [NSManagedObject]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        
        self.title = "姓名列表"
        self.fetch()
    }

    func managedObjectContext() -> NSManagedObjectContext {
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        return appDelegate.managedObjectContext
    }
    
    func fetch() {
        
        let managedObjectContext = self.managedObjectContext()
        
        let fetchRequest = NSFetchRequest(entityName: "Person")
        do {
            if let fetchResults = try managedObjectContext.executeFetchRequest(fetchRequest) as? [NSManagedObject] {
                people = fetchResults
            }
        } catch _ {
            print("fetch error")
        }
        
    }
    
    @IBAction func addHit(sender: UIBarButtonItem) {
        
        let alertVC = UIAlertController(title: "新名称", message: "添加一个新名称", preferredStyle: UIAlertControllerStyle.Alert)
        alertVC.addTextFieldWithConfigurationHandler { (textField) -> Void in
            textField.placeholder = "新名称"
        }
        alertVC.addAction(UIAlertAction(title: "取消", style: UIAlertActionStyle.Cancel, handler: nil))
        alertVC.addAction(UIAlertAction(title: "保存", style: UIAlertActionStyle.Default, handler: { (action) -> Void in
            if let nameTextField = alertVC.textFields!.first {
                if let name = nameTextField.text {
                    self.save(name)
                }
            }
            
        }))
        self.presentViewController(alertVC, animated: true, completion: nil)
        
    }
    
    func save(text: String) {
        
        let managedObjectContext = self.managedObjectContext()
        
        //建立Entry
        let entry = NSEntityDescription.entityForName("Person", inManagedObjectContext: managedObjectContext)
        let person = NSManagedObject(entity: entry!, insertIntoManagedObjectContext: managedObjectContext)
        //保存值到Entry
        person.setValue(text, forKey: "name")
        
        //
        do {
            try managedObjectContext.save()
            self.people.append(person)
            self.tableView.insertRowsAtIndexPaths([NSIndexPath(forRow: self.people.count-1, inSection: 0)], withRowAnimation: UITableViewRowAnimation.Automatic)
        }catch _ {
            print("save error")
        }
        
    }
    
    // MARK: - Table view data source


    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return self.people.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath)

        // Configure the cell...

        cell.textLabel?.text = self.people[indexPath.row].valueForKey("name") as? String
        
        return cell
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
