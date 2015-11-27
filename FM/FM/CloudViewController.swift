//
//  CloudViewController.swift
//  FM
//
//  Created by WangHao on 15/11/27.
//  Copyright © 2015年 Tuluobo. All rights reserved.
//

import UIKit

class CloudViewController: BaseViewController {
    
    @IBOutlet weak var playQuanImageView: PlayImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "playBtn"), style: UIBarButtonItemStyle.Plain, target: self, action: "showChannels")
            
            KVNProgress.setConfiguration(KVNProgressConfiguration.defaultConfiguration())
        
    }

    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        KVNProgress.show()
    }
    
    
    func showChannels() {
        
    }
    
}
