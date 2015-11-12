//
//  DataHandle.swift
//  GesturePasswd
//
//  Created by WangHao on 15/11/12.
//  Copyright © 2015年 Tuluobo. All rights reserved.
//

import UIKit

struct UserKey {
    static let PASSWORD = "password"
    static let CACHEPWD = "cachepassword"
}

class DataHandle {
    
    private let userDefault: NSUserDefaults
    
    //单例
    class var sharedInstance: DataHandle {
        struct Static {
            static let instance: DataHandle = DataHandle()
        }
        return Static.instance
    }
    
    init() {
        userDefault = NSUserDefaults.standardUserDefaults()
        deletePasswd(UserKey.CACHEPWD)
    }
    
    func deletePasswd(key: String) {
        userDefault.removeObjectForKey(key)
    }
    
    func hasPasswd(key: String) -> [Int]? {
        return userDefault.objectForKey(key) as? [Int]
    }
    
    func savePasswd(key: String, password: [Int]){
        userDefault.setObject(password, forKey: key)
    }
    
}