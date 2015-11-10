//
//  ViewController.swift
//  QRCode
//
//  Created by WangHao on 15/11/8.
//  Copyright © 2015年 Tuluobo. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController, AVCaptureMetadataOutputObjectsDelegate {

    // 视频捕捉会话
    var session = AVCaptureSession()
    // 视频画面预览层
    var videoPreviewLayer: AVCaptureVideoPreviewLayer?
    // 自动锁定小方框
    let autolockView = UIView()
    
    @IBOutlet weak var labelResult: UILabel!
    @IBOutlet weak var reScanBtn: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // 初始化视频捕捉会话
        session = AVCaptureSession()
        // 指定设备为摄像机
        let device = AVCaptureDevice.defaultDeviceWithMediaType(AVMediaTypeVideo)
        do {
            // 输入
            let input = try AVCaptureDeviceInput(device: device)
            session.addInput(input)
        } catch _ {
            NSLog("无法使用摄像头。")
            return
        }
        // 输出
        let output = AVCaptureMetadataOutput()
        session.addOutput(output)
        
        // 添加元数据对象输出代理
        output.setMetadataObjectsDelegate(self, queue: dispatch_get_main_queue())
        output.metadataObjectTypes = [
            AVMetadataObjectTypeQRCode,
            AVMetadataObjectTypeFace,
            AVMetadataObjectTypeEAN13Code
        ]
        // 视频预览层与视频捕捉绘画关联
        videoPreviewLayer = AVCaptureVideoPreviewLayer(session: session)
        videoPreviewLayer?.videoGravity = AVLayerVideoGravityResizeAspectFill
        videoPreviewLayer?.frame = self.view.layer.bounds
        self.view.layer.addSublayer(videoPreviewLayer!)
    
        // 将结果Label标签显示在最上面
        self.view.bringSubviewToFront(labelResult)
        
        // 自动锁定矿初始化
        autolockView.layer.borderColor = UIColor.greenColor().CGColor
        autolockView.layer.borderWidth = 2.0
        self.view.addSubview(autolockView)
        self.view.bringSubviewToFront(autolockView)
        
        // 启动会话
        startScan()
        
    }

    // 一旦视频捕捉有输出
    func captureOutput(captureOutput: AVCaptureOutput!, didOutputMetadataObjects metadataObjects: [AnyObject]!, fromConnection connection: AVCaptureConnection!) {
        // 判断元数据是否有输出
        if metadataObjects == nil || metadataObjects.count == 0 {
            autolockView.frame = CGRectZero
            labelResult.text = "间谍雷达正在扫描中..."
            return
        }
        
        // 如果是人脸
        for metadataObject in metadataObjects{
            
            if let obj = metadataObject as? AVMetadataFaceObject {
                if obj.type == AVMetadataObjectTypeFace {
                    let faceObject = videoPreviewLayer?.transformedMetadataObjectForMetadataObject(obj) as! AVMetadataFaceObject
                    
                    autolockView.frame = faceObject.bounds
                    labelResult.text = "发现人脸"
                }
            }
        }
        
        // 如果是条形码
        if let obj = metadataObjects.first as? AVMetadataMachineReadableCodeObject {
            let machObject = videoPreviewLayer?.transformedMetadataObjectForMetadataObject(obj) as!AVMetadataMachineReadableCodeObject
            autolockView.frame = machObject.bounds
            switch obj.type {
            case AVMetadataObjectTypeQRCode:
                if let decodeStr = machObject.stringValue {
                    self.stopScan()
                    labelResult.text = "二维码：\(decodeStr)"
                    self.launchApp(decodeStr)
                }
            case AVMetadataObjectTypeEAN13Code:
                if let decodeStr = machObject.stringValue {
                    self.stopScan()
                    self.getInfo(decodeStr)
                }
            default:break
            }
        }
        
    }
    
    func launchApp(urlStr: String){
        let alertController = UIAlertController(title: "二维码", message: "将要打开\(urlStr)", preferredStyle: UIAlertControllerStyle.ActionSheet)
        
        let openAction = UIAlertAction(title: "打开", style: UIAlertActionStyle.Destructive ) { (_) -> Void in
            if let url = NSURL(string: urlStr){
                if UIApplication.sharedApplication().canOpenURL(url){
                    UIApplication.sharedApplication().openURL(url)
                }
            }
        }
        let cancelAction = UIAlertAction(title: "取消", style: UIAlertActionStyle.Cancel, handler: { (_) -> Void in
            self.startScan()
        })
        alertController.addAction(openAction)
        alertController.addAction(cancelAction)
        
        alertController.popoverPresentationController?.sourceView = self.view
        alertController.popoverPresentationController?.sourceRect = labelResult.frame
        
        self.presentViewController(alertController, animated: true, completion: nil)
        
    }
    func getInfo(numberStr: String){
        let urlApi = "http://api.juheapi.com/jhbar/bar?appkey=b4533418e408e8689f62b00631d955fd&pkg=com.tuluobo.QRCode&cityid=1&barcode="
        
        let netSession = NSURLSession(configuration: NSURLSessionConfiguration.defaultSessionConfiguration())
        let request = NSURLRequest(URL: NSURL(string: "\(urlApi)\(numberStr)")!)
        let task = netSession.dataTaskWithRequest(request, completionHandler: { (data, _, e) -> Void in
            if e == nil {
                do {
                    let json = try NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.AllowFragments)
                    NSLog("\(json)")
                    
                    if let result = json["result"] as? NSDictionary {
                        if let summary = result["summary"] as? NSDictionary {
                            let name = summary.valueForKey("name") as! String
                            dispatch_async(dispatch_get_main_queue(), { () -> Void in
                                self.labelResult.text = "条形码：\(numberStr) -> \(name)"
                            })
                        } else {
                            self.labelResult.text = "条形码：\(numberStr) 没有找到这个商品摘要。"
                        }
                    } else {
                        self.labelResult.text = "条形码：\(numberStr) 是未知码。"
                    }
                }catch _ {
                    NSLog("Net Error")
                }
                
            }
        })
        task.resume()
    }
    
    @IBAction func reScan(sender: AnyObject) {
        self.startScan()
    }
    
    func stopScan(){
        session.stopRunning()
        reScanBtn.enabled = true
    }
    func startScan(){
        autolockView.frame = CGRectZero
        session.startRunning()
        reScanBtn.enabled = false
    }
    
}

