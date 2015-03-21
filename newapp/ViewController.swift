//
//  ViewController.swift
//  newapp
//
//  Created by Sagar Poudel on 3/15/15.
//  Copyright (c) 2015 Sagar Poudel. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIWebViewDelegate{
    
    
    @IBOutlet weak var httpTextBox: UIBarButtonItem!
    @IBOutlet weak var webpage: UIWebView!
    
    @IBOutlet weak var backButton: UIBarButtonItem!
    @IBOutlet weak var forwardButton: UIBarButtonItem!
    @IBOutlet weak var bottomToolbar: UIToolbar!
    
    let notification = NSNotificationCenter.defaultCenter()
    var keepKeyboardHeight:CGFloat = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        notification.addObserver(self, selector: "keyboardAppreared:", name: UIKeyboardWillShowNotification, object: nil)
        notification.addObserver(self, selector: "keyboardDisappear:", name: UIKeyboardWillHideNotification, object: nil)
        
        var request:NSURLRequest = NSURLRequest (URL: NSURL(string: "http://google.com")!)
        backButton.action = Selector("goBack")
        forwardButton.action = Selector("goForward")
        
        webpage.loadRequest(request)
        webpage.delegate = self
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
        let userInfo:Dictionary = notif.userInfo!
        var dictUserInfo = userInfo as Dictionary<String, NSValue>
        var keyboardSize = dictUserInfo["UIKeyboardFrameEndUserInfoKey"]?.CGRectValue()
        var height:Optional = keyboardSize?.height
        var heightTo = height! - keepKeyboardHeight
        keepKeyboardHeight = height!
        var keyboardTime:Optional = dictUserInfo["UIKeyboardAnimationDurationUserInfoKey"]?
        animateViewMoving(true, height: -heightTo, time: keyboardTime!)
    }
    
    func keyboardDisappear(notif: NSNotification){
        var dictUserInfo = notif.userInfo as Dictionary<String, NSValue>
        var keyboardSize = dictUserInfo["UIKeyboardBoundsUserInfoKey"]?.CGRectValue()
        var height:Optional = keyboardSize?.height
        var keyboardTime:Optional = dictUserInfo["UIKeyboardAnimationDurationUserInfoKey"]?
        keepKeyboardHeight = 0
        animateViewMoving(false, height: height!, time: keyboardTime!)
    }
    
    func animateViewMoving (up :Bool, height :CGFloat, time :AnyObject)->Void{
        var movementDuration:NSTimeInterval = NSTimeInterval(time as NSNumber)
        var movement:CGFloat = height
        UIView.beginAnimations( "animateView", context: nil)
        UIView.setAnimationBeginsFromCurrentState(true)
        UIView.setAnimationDuration(movementDuration )
        var frame = self.view.frame
        self.view.frame = CGRectOffset(self.view.frame, 0, movement)
        UIView.commitAnimations()
    }
    
    func goBack(){
        println("go back")
        if (webpage.canGoBack){
            webpage.goBack()
        }
    }
    
    func goForward(){
        println("go forward")
        if (webpage.canGoForward){
            webpage.goForward()
        }
    }
    
}

