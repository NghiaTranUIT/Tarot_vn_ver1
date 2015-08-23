//
//  HomeViewController.swift
//  Tarotvn_Ver1
//
//  Created by Nhan Nguyen on 8/21/15.
//  Copyright (c) 2015 Nhan Nguyen. All rights reserved.
//

import UIKit
import WebKit

class HomeViewController: UIViewController, UIWebViewDelegate {
    
    @IBOutlet weak var containerView: UIWebView!
    
    @IBOutlet weak var menuButton: UIBarButtonItem!
    
    @IBAction func refreshButton(sender: AnyObject) {
        
        myHUb =  MBProgressHUD.showHUDAddedTo(self.containerView, animated: true)
        myHUb.labelText = "Đang Tải..."
        myHUb.dimBackground = true
        
        // Do any additional setup after loading the view.
        var url = NSURL(string: "http://tarot.vn")
        var req = NSURLRequest(URL:url!)
        
        self.containerView!.loadRequest(req)
        
        
    }
    var myHUb: MBProgressHUD!
    
//    var webView: WKWebView?
//    
//    override func loadView() {
//        super.loadView()
//        
//        self.webView = WKWebView()
//
//        self.view = self.webView!
//    }
    
   
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.tintColor = UIColor.whiteColor()
        self.navigationController?.navigationBar.barTintColor = UIColor.blackColor()
        self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.whiteColor()]
        self.navigationController?.navigationBar.barStyle = UIBarStyle.Black
        self.navigationController?.navigationBar.translucent = false

         containerView.delegate = self
        
        if Reachability.isConnectedToNetwork() == true {
            
            myHUb =  MBProgressHUD.showHUDAddedTo(self.containerView, animated: true)
            myHUb.labelText = "Đang Tải..."
            myHUb.dimBackground = true
            
            // Do any additional setup after loading the view.
            var url = NSURL(string: "http://tarot.vn")
            var req = NSURLRequest(URL:url!)
            
            self.containerView!.loadRequest(req)

            
            println("Internet connection OK")
        } else {
            println("Internet connection FAILED")
            var alert = UIAlertView(title: "No Internet Connection", message: "Make sure your device is connected to the internet.", delegate: nil, cancelButtonTitle: "OK")
            alert.show()
        }
      
       
        

        
        ///

        if self.revealViewController() != nil {
            
            menuButton.target = self.revealViewController()
            menuButton.action = "revealToggle:"
            self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
            self.view.addGestureRecognizer(self.revealViewController().tapGestureRecognizer())
        }

//        
        // Do any additional setup after loading the view.
        var url = NSURL(string: "http://tarot.vn")
        var req = NSURLRequest(URL:url!)
       
        self.containerView!.loadRequest(req)
        
        
    }
    func webViewDidFinishLoad(webView: UIWebView) {
        
         myHUb.hide(true, afterDelay: 0)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
