//
//  TodoItem.swift
//  LocalNotifications
//
//  Created by WangHao on 15/10/23.
//  Copyright © 2015年 Tuluobo. All rights reserved.
//

import Foundation

struct TodoItem {
    var title: String
    var deadline: NSDate
    var UUID: String
    
    var isOverdue: Bool {
        return (NSDate().compare(self.deadline) == NSComparisonResult.OrderedDescending)
    }
    
    init(title: String, deadline: NSDate, UUID: String){
        self.title = title
        self.deadline = deadline
        self.UUID = UUID
    }
}