//
//  TodoList.swift
//  LocalNotifications
//
//  Created by WangHao on 15/10/23.
//  Copyright © 2015年 Tuluobo. All rights reserved.
//

import UIKit


class TodoList {
    //单例实现
    class var sharedInstance: TodoList {
        struct Static {
            static let instance: TodoList = TodoList()
        }
        return Static.instance
    }
    private let ITEMS_KEY = "todoItems"
    private let defaults = NSUserDefaults.standardUserDefaults()
    
    func addItem(item: TodoItem){
        var todoDictionary = defaults.dictionaryForKey(ITEMS_KEY) ?? Dictionary()
        todoDictionary[item.UUID] = ["deadline": item.deadline, "title": item.title, "UUID": item.UUID]
        NSUserDefaults.standardUserDefaults().setObject(todoDictionary, forKey: ITEMS_KEY)
        
        let notification = UILocalNotification()
        notification.alertBody = "Todo Item [\(item.title)] Is Overdue"
        notification.alertAction = "open"
        notification.fireDate = item.deadline
        notification.soundName = UILocalNotificationDefaultSoundName
        notification.userInfo = ["UUID": item.UUID]
        notification.category = "TODO_CATEGORY"
        UIApplication.sharedApplication().scheduleLocalNotification(notification)
    }
    
    func allItems() -> [TodoItem] {
        let todoDictionary = defaults.dictionaryForKey(ITEMS_KEY) ?? [:]
        let items = Array(todoDictionary.values)
        return items.map({
            TodoItem(title: $0["title"] as! String, deadline: $0["deadline"] as! NSDate, UUID: $0["UUID"] as! String!)
        }).sort({(left: TodoItem, right: TodoItem) -> Bool in
                (left.deadline.compare(right.deadline) == .OrderedAscending)
        })
    }
    
    func removeItem(item: TodoItem){
        for notification in UIApplication.sharedApplication().scheduledLocalNotifications! as [UILocalNotification] {
            if (notification.userInfo!["UUID"] as! String == item.UUID) {
                UIApplication.sharedApplication().cancelLocalNotification(notification)
                break
            }
        }
        
        if var todoItems = NSUserDefaults.standardUserDefaults().dictionaryForKey(ITEMS_KEY) {
            todoItems.removeValueForKey(item.UUID)
            NSUserDefaults.standardUserDefaults().setObject(todoItems, forKey: ITEMS_KEY)
        }
    }
}