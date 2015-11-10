//
//  HTTPRequest.swift
//  FM
//
//  Created by WangHao on 15/10/21.
//  Copyright © 2015年 Tuluobo. All rights reserved.
//

import Foundation

protocol HttpProtocol {
    func didRecieveResults(results: NSDictionary)
}

class HTTPRequest: NSObject {
    
    var delegate: HttpProtocol?
    
    func onSearch(url: String){
        
        let nsUrl = NSURL(string: url)
        let request = NSURLRequest(URL: nsUrl!)
        
        NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue.mainQueue()) { (response, data, error) -> Void in
            
            do {
              let jsonResults = try NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.MutableContainers) as! NSDictionary
              self.delegate?.didRecieveResults(jsonResults)
                
            } catch _ {
                print(error)
            }
        }
        
    }
    
}