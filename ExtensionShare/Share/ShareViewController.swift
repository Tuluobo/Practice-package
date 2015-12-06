//
//  ShareViewController.swift
//  Share
//
//  Created by WangHao on 15/11/29.
//  Copyright © 2015年 Tuluobo. All rights reserved.
//

import UIKit
import MobileCoreServices

import Social
import ReactiveCocoa
import SnapKit

class ShareViewController: SLComposeServiceViewController {

    override var placeholder: String! {
        get { return "分享" }
        set { self.placeholder = newValue }
    }
    
    // 判断Host app 提供的资源是否满足我们的要求
    override func isContentValid() -> Bool {
        // Do validation of contentText and/or NSExtensionContext attachments here
        //假设我们的文字限制为14个字
        if self.contentText.lengthOfBytesUsingEncoding(NSUTF8StringEncoding) >= 15 {
           return false
        }
        return true
    }

    override func didSelectPost() {
        // This is called after the user selects Post. Do the upload of contentText and/or NSExtensionContext attachments.
    
        // Inform the host that we're done, so it un-blocks its UI. Note: Alternatively you could call super's -didSelectPost, which will similarly complete the extension context.
        
        // 提取出来Host App 提供的资源
        for item in self.extensionContext?.inputItems as! [NSExtensionItem] {
            // item NSExtensionItem----------attachments
            for provider in item.attachments as! [NSItemProvider] {
                if provider.hasItemConformingToTypeIdentifier(kUTTypeImage as String) {
                    provider.loadItemForTypeIdentifier(kUTTypeImage as String, options: nil, completionHandler: { (imageProvider, error) -> Void in
                        let image = imageProvider as! UIImage
                        //异步处理资源
                        
                    })
                }
            }
        }
        // 异步处理
        
        self.extensionContext!.completeRequestReturningItems([], completionHandler: nil)
    }

    override func configurationItems() -> [AnyObject]! {
        // To add configuration options via table cells at the bottom of the sheet, return an array of SLComposeSheetConfigurationItem here.
        // 配置一些可选项目
        // 学校，专业
        
        let item0: SLComposeSheetConfigurationItem = SLComposeSheetConfigurationItem()
        item0.title = "学校"
        item0.value = "未选择"
        item0.tapHandler = { () -> Void in
            item0.value = "Tuluobo"
        }
        let item1: SLComposeSheetConfigurationItem = SLComposeSheetConfigurationItem()
        item1.title = "专业"
        item1.value = "未选择"
        item1.tapHandler = { () -> Void in
            item1.value = "iOS开发"
        }
        return [item0, item1]
    }

}
