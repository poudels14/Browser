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
    
    @IBOutlet weak var bottomToolbar: UIToolbar!
    
    let notification = NSNotificationCenter.defaultCenter()
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        self.view.backgroundColor = UIColor.redColor()
        notification.addObserver(self, selector: "keyboardAppreared:", name: UIKeyboardWillShowNotification, object: nil)
        notification.addObserver(self, selector: "keyboardDisappear:", name: UIKeyboardWillHideNotification, object: nil)
        
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
    
    /* Keyboard notification selector */
    func keyboardAppreared(notif: NSNotification){
        let userInfo = notif.userInfo
//        let endFrame = userInfo[UIKeyboardFrameEndUserInfoKey] as? NSValue;
        println("Here it comes, Keyboard!")
//        bottomToolbar.frame = CGRectOffset(self.view.frame, 0,  -100)
        animateViewMoving(true, moveValue: 220)
        
    }
    
    func keyboardDisappear(notif: NSNotification){
        println("Keyboard hidden")
        animateViewMoving(true, moveValue: -220)
    }
    
    func animateViewMoving (up:Bool, moveValue :CGFloat){
        var movementDuration:NSTimeInterval = 0.2
        var movement:CGFloat = ( up ? -moveValue : moveValue)
        UIView.beginAnimations( "animateView", context: nil)
        UIView.setAnimationBeginsFromCurrentState(true)
        UIView.setAnimationDuration(movementDuration )
        self.view.frame = CGRectOffset(self.view.frame, 0,  movement)
        UIView.commitAnimations()
    }
    
}

