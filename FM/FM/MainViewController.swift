//
//  ViewController.swift
//  FM
//
//  Created by WangHao on 15/10/21.
//  Copyright © 2015年 Tuluobo. All rights reserved.
//

import UIKit
import MediaPlayer

let channel_url = "http://www.douban.com/j/app/radio/channels"
let song_url = "http://douban.fm/j/mine/playlist?channel="

class MainViewController: BaseViewController, UITableViewDataSource, UITableViewDelegate, HttpProtocol {
    
    var httpResquest: HTTPRequest! = HTTPRequest()
    var channels = [NSDictionary]()
    var songs = [NSDictionary]()
    var imageCache = [String: UIImage]()
    var audioPlayer = MPMoviePlayerController()
    var timer: NSTimer?
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var fmTableView: UITableView!
    @IBOutlet weak var progressView: UIProgressView!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var playImageView: UIImageView!
    @IBOutlet var tapGesture: UITapGestureRecognizer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        httpResquest.delegate = self
        httpResquest.onSearch(channel_url)
        httpResquest.onSearch("\(song_url)0")

        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return songs.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("douban", forIndexPath: indexPath)
        let data = songs[indexPath.row]
        cell.textLabel?.text = data.valueForKey("title") as? String
        cell.detailTextLabel?.text = data.valueForKey("artist") as? String
        cell.imageView?.image = UIImage(named: "detail.png")
        let url = data["picture"] as! String
        if let image = self.imageCache[url] {
            cell.imageView?.image = image
        }else{
            let imgUrl = NSURL(string: url)
            let request = NSURLRequest(URL: imgUrl!)
            NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue.mainQueue()) { (response, data, error) -> Void in
                do {
                    let image = UIImage(data: data!)
                    cell.imageView?.image = image
                    self.imageCache[url] = image
                }
            }

        }
        return cell
    }

    func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        cell.layer.transform = CATransform3DMakeScale(0.1, 0.1, 1)
        UIView.animateWithDuration(0.25, animations: { () -> Void in
            cell.layer.transform = CATransform3DMakeScale(1, 1, 1)
        })
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let data = songs[indexPath.row]
        let song_url = data.valueForKey("url") as! String
        onSetAudio(song_url)
        let image_url = data.valueForKey("picture") as! String
        onSetImage(image_url)
    }
    
    
    func didRecieveResults(results: NSDictionary) {
        if (results.valueForKey("channels") != nil) {
            channels = results.valueForKey("channels") as! [NSDictionary]
        }else{
            songs = results.valueForKey("song") as! [NSDictionary]
            self.fmTableView.reloadData()
            if songs.count > 0 {
                let firstDict = songs[0]
                let audioUrl = firstDict.valueForKey("url") as! String
                onSetAudio(audioUrl)
                let imgUrl = firstDict.valueForKey("picture") as! String
                onSetImage(imgUrl)
            }else{
                performSegueWithIdentifier("channel", sender: nil)
            }
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if let identifier = segue.identifier {
            switch identifier{
            case "channel":
                if let cvc = segue.destinationViewController as? ChannelViewController {
                    cvc.mainVC = self
                    cvc.channels = self.channels
                }
            default:
                break
            }
        }
    }
    
    @IBAction func onTap(sender: UITapGestureRecognizer) {
        if self.tapGesture.view == imageView {
            playImageView.hidden = false
            self.audioPlayer.pause()
            self.playImageView.addGestureRecognizer(tapGesture)
        }else{
            playImageView.hidden = true
            self.audioPlayer.play()
            self.imageView.addGestureRecognizer(tapGesture)
        }
    }
    
    func onSetAudio(url: String) {
        self.imageView.addGestureRecognizer(tapGesture)
        self.playImageView.hidden = true
        self.timer?.invalidate()
        self.timeLabel.text = "00:00"
        self.audioPlayer.stop()
        self.audioPlayer.contentURL = NSURL(string: url)
        self.audioPlayer.play()
        self.timer = NSTimer.scheduledTimerWithTimeInterval(0.4, target: self, selector: "onUpdate", userInfo: nil, repeats: true)
    }
    
    func onUpdate(){
        let c = self.audioPlayer.currentPlaybackTime
        if c > 0.0 {
            self.progressView.progress = Float(c/audioPlayer.duration)
            self.timeLabel.text = String(format: "%02d:%02d", Int(c/60), Int(c%60))
        }
    }
    
    func onSetImage(url: String) {
        if let image = self.imageCache[url] {
            self.imageView.image = image
        }else{
            let imgUrl = NSURL(string: url)
            let request = NSURLRequest(URL: imgUrl!)
            NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue.mainQueue()) { (response, data, error) -> Void in
                do {
                    let image = UIImage(data: data!)
                    self.imageView.image = image
                    self.imageCache[url] = image
                }
            }
            
        }
    }
}

