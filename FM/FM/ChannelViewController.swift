//
//  ChannelViewController.swift
//  FM
//
//  Created by WangHao on 15/10/21.
//  Copyright © 2015年 Tuluobo. All rights reserved.
//

import UIKit

class ChannelViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    var mainVC: MainViewController?
    var channels = [NSDictionary]()
    
    @IBOutlet weak var channelTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = "@#@#"
        self.navigationItem.hidesBackButton = true
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return channels.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("channel", forIndexPath: indexPath)
        
        let data = channels[indexPath.row]
        
        var cid: String = ""
        if let channel_id = data.valueForKey("channel_id") as? NSString {
            cid = channel_id as String
        }else if let channel_id = data.valueForKey("channel_id") as? NSNumber {
            cid = "\(channel_id)"
        }
        
        let seq_id = (data.valueForKey("seq_id") as? NSNumber ?? 0).longLongValue
        let addr_en = data.valueForKey("addr_en") as? String ?? ""
        let name = data.valueForKey("name") as! String
        let name_en = data.valueForKey("name_en") as? String ?? ""

        cell.textLabel?.text = "\(name)"
        cell.detailTextLabel?.text = "ID:\(cid),A:\(addr_en),S:\(seq_id),E:\(name_en)"
        
        return cell
    }
    
    func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        cell.layer.transform = CATransform3DMakeScale(0.1, 0.1, 1)
        UIView.animateWithDuration(0.25, animations: { () -> Void in
            cell.layer.transform = CATransform3DMakeScale(1, 1, 1)
        })
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        self.dismissViewControllerAnimated(true) { () -> Void in
            let data = self.channels[indexPath.row]
            var cid: String = ""
            if let channel_id = data.valueForKey("channel_id") as? NSString {
                cid = channel_id as String
            }else if let channel_id = data.valueForKey("channel_id") as? NSNumber {
                cid = "\(channel_id)"
            }
            self.mainVC?.httpResquest.onSearch("\(song_url)\(cid)")
        }
    }

}
