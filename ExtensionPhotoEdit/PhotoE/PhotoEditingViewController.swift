//
//  PhotoEditingViewController.swift
//  PhotoE
//
//  Created by WangHao on 15/11/29.
//  Copyright © 2015年 Tuluobo. All rights reserved.
//

import UIKit
import Photos
import PhotosUI

class PhotoEditingViewController: UIViewController, PHContentEditingController, UITextFieldDelegate {

    var input: PHContentEditingInput?

    @IBOutlet weak var imageA: UIImageView!
    @IBOutlet weak var infoTextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.infoTextField.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - PHContentEditingController

    func canHandleAdjustmentData(adjustmentData: PHAdjustmentData?) -> Bool {
        // Inspect the adjustmentData to determine whether your extension can work with past edits.
        // (Typically, you use its formatIdentifier and formatVersion properties to do this.)
        return false
    }

    func startContentEditingWithInput(contentEditingInput: PHContentEditingInput?, placeholderImage: UIImage) {
        // Present content for editing, and keep the contentEditingInput for use when closing the edit session.
        // If you returned true from canHandleAdjustmentData:, contentEditingInput has the original image and adjustment data.
        // If you returned false, the contentEditingInput has past edits "baked in".
        self.imageA.image = contentEditingInput?.displaySizeImage
        input = contentEditingInput
    }

    func finishContentEditingWithCompletionHandler(completionHandler: ((PHContentEditingOutput!) -> Void)!) {
        // Update UI to reflect that editing has finished and output is being rendered.
        
        // Render and provide output on a background queue.
        dispatch_async(dispatch_get_global_queue(CLong(DISPATCH_QUEUE_PRIORITY_DEFAULT), 0)) {
            
            // Create editing output from the editing input.
            let output = PHContentEditingOutput(contentEditingInput: self.input!)
            
            // Provide new adjustments and render output to given location.
            // output.adjustmentData = <#new adjustment data#>
            // let renderedJPEGData = <#output JPEG#>
            // renderedJPEGData.writeToURL(output.renderedContentURL, atomically: true)
            
            // Call completion handler to commit edit to Photos.
            // 把数据写回照片应用，结束照片扩展编辑（并不是生命周期的结束）
            
            // 1. 生成一个PHAdjustmentData 数据  放入 output
            output.adjustmentData = PHAdjustmentData(formatIdentifier: "com.tuluobo.ExtensionPhoto", formatVersion: "0.1.0", data: NSData())
            
            // 2.写回照片库
            let renderedJPEGData = UIImageJPEGRepresentation(self.imageA.image!, 0.9)
            renderedJPEGData!.writeToURL(output.renderedContentURL, atomically: true)

            completionHandler?(output)
            
            // Clean up temporary files, etc.
        }
    }
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        self.infoTextField.resignFirstResponder()
    }

    @IBAction func requestData(sender: UIButton) {
        
        if let imageSize = self.imageA.image?.size {
        
            UIGraphicsBeginImageContextWithOptions(imageSize, true, 0.0)
            let rect = CGRectMake(0, 0, imageSize.width, imageSize.height)
            self.imageA.image?.drawInRect(rect)
            let infoText: NSString? = self.infoTextField.text
            infoText?.drawAtPoint(CGPointMake(10, 20), withAttributes: [NSForegroundColorAttributeName : UIColor.redColor()])
            let endImage = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()

            self.imageA.image = endImage
        
        }
    }
    
    var shouldShowCancelConfirmation: Bool {
        // Determines whether a confirmation to discard changes should be shown to the user on cancel.
        // (Typically, this should be "true" if there are any unsaved changes.)
        return false
    }

    func cancelContentEditing() {
        // Clean up temporary files, etc.
        // May be called after finishContentEditingWithCompletionHandler: while you prepare output.
    }

    func textFieldDidEndEditing(textField: UITextField) {
        self.infoTextField.resignFirstResponder()
    }
}
