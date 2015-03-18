//
//  ViewController.swift
//  newapp
//
//  Created by Sagar Poudel on 3/15/15.
//  Copyright (c) 2015 Sagar Poudel. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIWebViewDelegate{
    
    
    @IBOutlet weak var webpage: UIWebView!
    let notification = NSNotificationCenter.defaultCenter()
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        self.view.backgroundColor = UIColor.redColor()
        
        var request:NSURLRequest = NSURLRequest (URL: NSURL(string: "http://google.com")!)
        
        
        webpage.loadRequest(request)
//        webpage.delegate = self
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func webView(webView: UIWebView!, didFailLoadWithError error: NSError!) {
        println("Webview fail with error \(error)");
    }
    
    func webView(webView: UIWebView!, shouldStartLoadWithRequest request: NSURLRequest!, navigationType: UIWebViewNavigationType) -> Bool {
        println(request)
        return true;
    }
    
    func webViewDidStartLoad(webView: UIWebView!) {
        println("Webview started Loading")
    }
    
    func webViewDidFinishLoad(webView: UIWebView!) {
        println("Webview did finish load")
    }
    
}

