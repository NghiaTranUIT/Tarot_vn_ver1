//
//  StoredBooksTableViewController.swift
//  Tarotvn_Ver1
//
//  Created by Nhan Nguyen on 8/17/15.
//  Copyright (c) 2015 Nhan Nguyen. All rights reserved.
//

import UIKit
import Parse
import Refresher

class StoredBooksTableViewController: UITableViewController {
    
    @IBOutlet weak var menuButton: UIBarButtonItem!
    
    @IBOutlet var myTableview: UITableView!
    var arrlist: [AnyObject]!
    var selected: PFObject!
    var arrFeaturedBook: [String] = ["Rider Waite Tarot","Lenormand Card","Runes","The Clow Card"]
    var arrFeaturedBookFullName: [String] = ["RiderWaiteTarot.sqlite3", "Lenormand.sqlite3", "RunesChart.sqlite3", "TheClowCard.sqlite3"]
    let userDefault = NSUserDefaults.standardUserDefaults()
    
    

    override func viewDidLoad() {
       
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.tintColor = UIColor.whiteColor()
        self.navigationController?.navigationBar.barTintColor = UIColor.blackColor()
        self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.whiteColor()]
        self.navigationController?.navigationBar.barStyle = UIBarStyle.Black
        self.navigationController?.navigationBar.translucent = false
        self.view.backgroundColor = UIColor.blackColor()
        self.tableView.backgroundColor = UIColor.whiteColor()
        if self.revealViewController() != nil {
            
            menuButton.target = self.revealViewController()
            menuButton.action = "revealToggle:"
            self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
            self.view.addGestureRecognizer(self.revealViewController().tapGestureRecognizer())
        }
        
        if let customSubview = NSBundle.mainBundle().loadNibNamed("CustomSubview", owner: self, options: nil).first as? CustomSubview {
            myTableview.addPullToRefreshWithAction({
                NSOperationQueue().addOperationWithBlock {
                    var query = PFQuery(className: "DataBook")
                    if let arrFileNameDownloaded: AnyObject = self.userDefault.objectForKey("fileDownload")
                    {
                        var readArray: [NSString] = arrFileNameDownloaded as! [NSString]
                        query.whereKey("fullName", notContainedIn: readArray)
                        
                    }
                    ///add to dislay
                    if let arrFileNameDownloadedDislay: AnyObject = self.userDefault.objectForKey("fileDownloadDislay")
                    {
                        var readArrayDislay: [NSString] = arrFileNameDownloadedDislay as! [NSString]
                        query.whereKey("name", notContainedIn: readArrayDislay)
                        
                        
                    }
                    
                    query.findObjectsInBackgroundWithBlock {(objects: [AnyObject]?, error: NSError?) -> Void in
                        if error == nil {
                            
                            self.arrlist = objects
                        }
                        
                        self.tableView.reloadData()
                        
                        
                        MBProgressHUD.hideHUDForView(self.tableView, animated: true)
                    }

                    
                    NSOperationQueue.mainQueue().addOperationWithBlock {
                        self.tableView.stopPullToRefresh()
                    }
                }
                }, withAnimator: customSubview)
        }
        
//        userDefault.setObject(arrFeaturedBookFullName, forKey: "fileDownload")
//        userDefault.setObject(arrFeaturedBook, forKey: "fileDownloadDislay")
        
        
        arrlist = []
        
        
        if Reachability.isConnectedToNetwork() == true {
            println("Internet connection OK")
            
            MBProgressHUD.showHUDAddedTo(self.tableView, animated: true)
        
       var query = PFQuery(className: "DataBook")
            if let arrFileNameDownloaded: AnyObject = userDefault.objectForKey("fileDownload")
        {
            var readArray: [NSString] = arrFileNameDownloaded as! [NSString]
            query.whereKey("fullName", notContainedIn: readArray)
            
        }
        ///add to dislay
        if let arrFileNameDownloadedDislay: AnyObject = userDefault.objectForKey("fileDownloadDislay")
        {
            var readArrayDislay: [NSString] = arrFileNameDownloadedDislay as! [NSString]
            query.whereKey("name", notContainedIn: readArrayDislay)
           

        }
            
            query.findObjectsInBackgroundWithBlock {(objects: [AnyObject]?, error: NSError?) -> Void in
                if error == nil {
                    
                    self.arrlist = objects
                }
                
                self.tableView.reloadData()
                
                
                MBProgressHUD.hideHUDForView(self.tableView, animated: true)
            }
            
            
            NSNotificationCenter.defaultCenter().addObserver(self, selector: "onCreatedNotification", name: "reloadListBooks" , object: nil)
            
            
        }

        
        else {
            println("Internet connection FAILED")
            var alert = UIAlertView(title: "No Internet Connection", message: "Make sure your device is connected to the internet.", delegate: nil, cancelButtonTitle: "OK")
            alert.show()
        }
        
        
                }
        //
//        if let arrFileNameDownloadedShowUp: AnyObject = userDefault.objectForKey("fileDownloadShowUp")
//        {
//            var readArrayDislay: [NSString] = arrFileNameDownloadedShowUp as! [NSString]
//            query.whereKey("name", notContainedIn: readArrayDislay)
//        }

        
    
    func onCreatedNotification()
    {
        arrlist = []
        MBProgressHUD.showHUDAddedTo(self.view, animated: true)
        
        var query = PFQuery(className: "DataBook")
        let userDefault = NSUserDefaults.standardUserDefaults()
        
        if let arrFileNameDownloaded: AnyObject = userDefault.objectForKey("fileDownload")
        {
            var readArray: [NSString] = arrFileNameDownloaded as! [NSString]
            query.whereKey("fullName", notContainedIn: readArray)
        }
        
        ///add to dislay
        if let arrFileNameDownloadedDislay: AnyObject = userDefault.objectForKey("fileDownloadDislay")
        {
            var readArrayDislay: [NSString] = arrFileNameDownloadedDislay as! [NSString]
            query.whereKey("name", notContainedIn: readArrayDislay)
        }
        
        
        query.findObjectsInBackgroundWithBlock {(objects: [AnyObject]?, error: NSError?) -> Void in
            if error == nil {
                
                self.arrlist = objects
            }
            
            self.tableView.reloadData()
            
            MBProgressHUD.hideHUDForView(self.view, animated: true)
        }
        
        //self.tableView.reloadData()
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        
        return 1
        
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.
        return arrlist.count
    }
    
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("StoredBooks", forIndexPath: indexPath) as! UITableViewCell
        
        var nameBook: PFObject = arrlist[indexPath.row] as! PFObject
        
        // Configure the cell...
        cell.textLabel?.text =  nameBook["name"] as? String
        
        
        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        let alert = UIAlertController(title: "Thông Báo", message: "Bạn Có Muốn Tải Sách Không?", preferredStyle: UIAlertControllerStyle.Alert)
        //alert.addAction(UIAlertAction(title: "Click", style: UIAlertActionStyle.Default, handler: nil))
        
        
        
        alert.addAction(UIAlertAction(title: "Có", style: .Default, handler: { action in
            switch action.style{
            case .Default:
                println("default")
                
                self.selected = self.arrlist[indexPath.row] as! PFObject
                let daBook: PFFile = self.selected["file"] as! PFFile
                let daBookName: String = self.selected["fullName"] as! String
                let daBookNameDislay: String = self.selected["name"] as! String
                var checkValidation = NSFileManager.defaultManager()
                
                
                ///
                var myHUb:MBProgressHUD =  MBProgressHUD.showHUDAddedTo(UIApplication.sharedApplication().keyWindow, animated: true)
                myHUb.labelText = "Đang Tải..."
                myHUb.dimBackground = true;
                
                ///
                
                daBook.getDataInBackgroundWithBlock { (fileTarot: NSData?, error: NSError?) -> Void in
                    let dirPaths = NSSearchPathForDirectoriesInDomains( .DocumentDirectory, .UserDomainMask, true)
                    let docsDir = dirPaths[0] as! String
                    let databasePath: String = String(format: "%@/%@", arguments: [docsDir, daBookName])
                    
                    NSLog("dataPath = %@", databasePath)
                    
                    fileTarot?.writeToFile(databasePath, atomically: true)
                    
                    
                    if (checkValidation.fileExistsAtPath(databasePath))
                    {
                        
                        self.arrlist.removeAtIndex(indexPath.row)
                        tableView.reloadData()
                        
                        let userDefault = NSUserDefaults.standardUserDefaults()
                        //userDefault.setObject(NSNumber(bool: true), forKey: daBookName)
                        
                        if let arrFileNameDownloaded: AnyObject = userDefault.objectForKey("fileDownload")
                        {
                            var readArray:[NSString] = arrFileNameDownloaded as! [NSString]
                            
                            readArray.append(daBookName)
                            
                            userDefault.setObject(readArray, forKey: "fileDownload")
                        }
                        else
                        {
                            // NIl
                            var readArray:[NSString]  = []
                            readArray.append(daBookName)
                            
                            userDefault.setObject(readArray, forKey: "fileDownload")
                        }
                        
                        if let arrFileNameDownloadedDislay: AnyObject = userDefault.objectForKey("fileDownloadDislay")
                        {
                            var readArrayDislay:[NSString] = arrFileNameDownloadedDislay as! [NSString]
                            
                            readArrayDislay.append(daBookNameDislay)
                            
                            userDefault.setObject(readArrayDislay, forKey: "fileDownloadDislay")
                        }
                        else
                        {
                            // NIl
                            var readArrayDislay:[NSString]  = []
                            readArrayDislay.append(daBookNameDislay)
                            
                            userDefault.setObject(readArrayDislay, forKey: "fileDownloadDislay")
                        }
                        
                        
                    }else {
                        println("file already exitence")
                    }
                  
                    myHUb.hide(true, afterDelay: 0)
                    
                }
                
            case .Cancel:
                println("cancel")
                
            case .Destructive:
                println("destructive")
            }
            
        }))
        
        let cancel = UIAlertAction(title: "Không", style: .Cancel, handler: {
            action in
            
            self.tableView.reloadData()
            
        })
        
        alert.addAction(cancel)
        
        self.presentViewController(alert, animated: true, completion: nil)
        
    }
   
    
}
