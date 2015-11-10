//
//  BaseInfo.swift
//  NewsClient
//
//  Created by WangHao on 15/10/17.
//  Copyright © 2015年 Tuluobo. All rights reserved.
//

import Foundation

class BaseInfo: NSObject {
    
    var ID: NSString!
    var name: NSString!
    
    func infoFromDict(dict: NSDictionary) -> BaseInfo {
        let info = BaseInfo()
        
        info.ID = dict["id"] as? String
        info.name = dict["name"] as? String

        return info
        
    }
    
//    func arrayFromDict(dict: NSDictionary) -> NSArray {
//        var array = dict.objectForKey(NetData)
//        return self.arrayFromArray(array)
//    }
    
    func arrayFromArray(array: NSArray) -> NSArray {
        let infos = NSMutableArray()
        for dict in array {
            infos.addObject(self.infoFromDict(dict as! NSDictionary))
        }
        return infos
    }
    
    func compare(bInfo: BaseInfo) -> NSComparisonResult {
        return self.ID.caseInsensitiveCompare(bInfo.ID as String)
    }
    
//    func isEqual(bInfo: BaseInfo) -> Bool {
//        return self.ID.isEqualToString(bInfo.ID as String)
//    }
    
}