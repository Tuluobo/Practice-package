//
//  DocumentPickerViewController.swift
//  FSProvider
//
//  Created by WangHao on 15/12/2.
//  Copyright © 2015年 Tuluobo. All rights reserved.
//

import UIKit

class DocumentPickerViewController: UIDocumentPickerExtensionViewController {

    @IBAction func openDocument(sender: AnyObject?) {
        let documentURL = self.documentStorageURL!.URLByAppendingPathComponent("Untitled.txt")
      
        // TODO: if you do not have a corresponding file provider, you must ensure that the URL returned here is backed by a file
        self.dismissGrantingAccessToURL(documentURL)
    }

    override func prepareForPresentationInMode(mode: UIDocumentPickerMode) {
        // TODO: present a view controller appropriate for picker mode here
    }

}
