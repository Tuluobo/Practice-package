//
//  ViewController.swift
//  ExtensionFSProvider
//
//  Created by WangHao on 15/12/2.
//  Copyright © 2015年 Tuluobo. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIDocumentMenuDelegate, UIDocumentPickerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    @IBAction func openDoc(sender: UIBarButtonItem) {
        
        let menuVC = UIDocumentMenuViewController(documentTypes: ["public.content"], inMode: UIDocumentPickerMode.Open)
        self.presentViewController(menuVC, animated: true, completion: nil)
    }
    
    func documentMenu(documentMenu: UIDocumentMenuViewController, didPickDocumentPicker documentPicker: UIDocumentPickerViewController) {
        self.presentViewController(documentPicker, animated: true, completion: nil)
    }
    
    func documentPicker(controller: UIDocumentPickerViewController, didPickDocumentAtURL url: NSURL) {
        
    }
    
    func documentMenuWasCancelled(documentMenu: UIDocumentMenuViewController) {
        
    }
}

