//
//  TodoSchedulingViewController.swift
//  LocalNotifications
//
//  Created by WangHao on 15/10/23.
//  Copyright © 2015年 Tuluobo. All rights reserved.
//

import UIKit

class TodoSchedulingViewController: UIViewController {
    
    var tTableView: TodoTableViewController?
    
    @IBOutlet weak var titleField: UITextField!
    @IBOutlet weak var deadlinePicker: UIDatePicker!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func savePressed(sender: UIButton) {
        
        let todoItem = TodoItem(title: self.titleField.text!, deadline: self.deadlinePicker.date, UUID: NSUUID().UUIDString)
        TodoList.sharedInstance.addItem(todoItem)
        self.navigationController?.popToRootViewControllerAnimated(true)
        self.tTableView?.refreshList()
    }


}
