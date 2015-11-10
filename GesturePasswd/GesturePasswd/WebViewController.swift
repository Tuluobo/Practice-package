//
//  WebViewController.swift
//  GesturePasswd
//
//  Created by WangHao on 15/11/7.
//  Copyright © 2015年 Tuluobo. All rights reserved.
//

import UIKit

class WebViewController: UIViewController {

    @IBOutlet weak var webView: UIWebView!
    override func viewDidLoad() {
        super.viewDidLoad()
        let url = NSURL(string: "http://www.tuluobo.com")
        webView.loadRequest(NSURLRequest(URL: url!))
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    @IBAction func shot(sender: UIBarButtonItem) {
        
        let sView = UIScreen.mainScreen().snapshotViewAfterScreenUpdates(true)
        let image = self.captureImageFromView(sView)
        
        let paths:NSArray = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.DocumentDirectory, NSSearchPathDomainMask.UserDomainMask, true)
        let documentPath = paths.objectAtIndex(0) as! NSString
        let filename = documentPath.stringByAppendingPathComponent("name_pic.png")
        NSLog("\(filename)")
        let imageData = UIImagePNGRepresentation(image)
        let f = imageData?.writeToFile(filename, atomically: true)
        NSLog("\(f)")

    }
    
    func captureImageFromView(view: UIView) -> UIImage {
        
        let screenRect = view.bounds
        UIGraphicsBeginImageContextWithOptions(screenRect.size, true, 0)
        let ctx = UIGraphicsGetCurrentContext()
        view.layer.renderInContext(ctx!)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image
    }
}
