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

class StoredBooksTableViewController: UITableViewController, UISearchBarDelegate {
    
    @IBOutlet weak var mySearch: UISearchBar!
    @IBOutlet weak var menuButton: UIBarButtonItem!
    
    @IBOutlet var myTableview: UITableView!
    
    var isConnection: Bool!
    var arrlist: [AnyObject]!
    var arrlistFiltered: [AnyObject]!
    var searchActive: Bool!
    var selected: PFObject!
    var arrFeaturedBook: [String] = ["Rider Waite Tarot","Lenormand Card","Runes","The Clow Card"]
    var arrFeaturedBookFullName: [String] = ["RiderWaiteTarot.sqlite3", "Lenormand.sqlite3", "RunesChart.sqlite3", "TheClowCard.sqlite3"]
    let userDefault = NSUserDefaults.standardUserDefaults()
    
    override func viewDidLoad() {
       
        super.viewDidLoad()
        mySearch.delegate = self
        
        self.navigationController?.navigationBar.tintColor = UIColor.whiteColor()
        self.navigationController?.navigationBar.barTintColor = UIColor(red: 77/255, green: 118/255, blue: 78/255, alpha: 1.0)
        
        self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.whiteColor()]
        self.navigationController?.navigationBar.barStyle = UIBarStyle.Black
        self.navigationController?.navigationBar.translucent = false
        self.view.backgroundColor = UIColor.blackColor()
        self.tableView.backgroundColor = UIColor.whiteColor()
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "reachabilityStatusChanged", name: "ReachStatusChanged", object: nil)
        
        self.reachabilityStatusChanged()
        
        if self.revealViewController() != nil {
            
            menuButton.target = self.revealViewController()
            menuButton.action = "revealToggle:"
            self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
            self.view.addGestureRecognizer(self.revealViewController().tapGestureRecognizer())
        }
    
        if isConnection == true{
            
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
        }
            else{
                
                var alert = UIAlertView(title: "No Internet Connection", message: "Make sure your device is connected to the internet.", delegate: nil, cancelButtonTitle: "OK")
                alert.show()

                
            }
              arrlist = []
        }
        
    
      
        
    
    
    func reachabilityStatusChanged(){
        
        if reachablityStatus == KNOTREACHABLE{
            
            println("Internet connection FAILED")
            var alert = UIAlertView(title: "No Internet Connection", message: "Make sure your device is connected to the internet.", delegate: nil, cancelButtonTitle: "OK")
            alert.show()
            
            isConnection = false
            
        }else if reachablityStatus == KREACHABLEWITHWIFI{
            
            isConnection = true
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
            
            
        }else if reachablityStatus == KREACHABLEWOTHWLAN{
            
            isConnection = true
            
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
    }
    
    deinit{
        
        NSNotificationCenter.defaultCenter().removeObserver(self, name: "ReachStatusChanged", object: nil)
    }
    
    func searchBar(mySearch: UISearchBar, textDidChange searchText: String) {
        
        if isConnection == true{
            
            
            var textFieldInsideSearchBar = mySearch.valueForKey("searchField") as? UITextField
        
        textFieldInsideSearchBar?.textColor = UIColor(red: 77/255, green: 118/255, blue: 78/255, alpha: 1.0)
        
        // Add a where clause if there is a search criteria
        if mySearch.text !=  nil {
            
            
            searchActive = true
            var arrFileNameDownloadedDislay: AnyObject = userDefault.objectForKey("fileDownloadDislay")!
            var readArrayDislay: [NSString] = arrFileNameDownloadedDislay as! [NSString]
            var queryFiltered = PFQuery(className: "DataBook")
            queryFiltered.whereKeyExists("name")
            queryFiltered.whereKey("name", matchesRegex: searchText, modifiers: "i")
            queryFiltered.whereKey("name", notContainedIn: readArrayDislay)
            
            
            
            
            // Order the results
            queryFiltered.orderByAscending("name")
            
            queryFiltered.findObjectsInBackgroundWithBlock {(objects: [AnyObject]?, error: NSError?) -> Void in
                if error == nil {
                    
                    self.arrlistFiltered = objects!
                    
                }
                
                self.tableView.reloadData()
                
            }
            
        }else{
            
            searchActive = false
            arrlist = []
           // mySearch.resignFirstResponder()
            MBProgressHUD.showHUDAddedTo(self.tableView, animated: true)
            
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
                
                MBProgressHUD.hideHUDForView(self.tableView, animated: true)
            }
            
            self.tableView.reloadData()
        }
        }else{
            
            var alert = UIAlertView(title: "No Internet Connection", message: "Make sure your device is connected to the internet.", delegate: nil, cancelButtonTitle: "OK")
            alert.show()

        }
        
        
    }
   

    
    func onCreatedNotification()
    {
        arrlist = []
        MBProgressHUD.showHUDAddedTo(self.tableView, animated: true)
        
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
            
            MBProgressHUD.hideHUDForView(self.tableView, animated: true)
        }
        
        self.tableView.reloadData()
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
       
        if ((searchActive) != nil){
            
            return arrlistFiltered.count
        }
            
        else{
            
            return arrlist.count
            
        }
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("StoredBooks", forIndexPath: indexPath) as! UITableViewCell
        
        
        if (searchActive != nil) {
            var nameBookFiltered: PFObject = arrlistFiltered[indexPath.row] as! PFObject
            
            cell.textLabel?.text = nameBookFiltered["name"] as? String
            cell.textLabel?.textColor = UIColor(red: 77/255, green: 118/255, blue: 78/255, alpha: 1.0)
            
        }else{
           
            
            var nameBook: PFObject = arrlist[indexPath.row] as! PFObject
            
            // Configure the cell...
            cell.textLabel?.text =  nameBook["name"] as? String
            cell.textLabel?.textColor = UIColor(red: 77/255, green: 118/255, blue: 78/255, alpha: 1.0)
            
        }
 
    
        return cell
    }
    
    
    override func viewWillDisappear(animated: Bool) {
        mySearch.resignFirstResponder()
        
        searchActive = nil
        myTableview.reloadData()
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        if isConnection == true{
            
             let alert = UIAlertController(title: "Thông Báo", message: "Bạn Có Muốn Tải Sách Không?", preferredStyle: UIAlertControllerStyle.Alert)
        //alert.addAction(UIAlertAction(title: "Click", style: UIAlertActionStyle.Default, handler: nil))
        
        
        
        alert.addAction(UIAlertAction(title: "Có", style: .Default, handler: { action in
            switch action.style{
            case .Default:
                println("default")
                
                if self.searchActive != nil{
                    
                    self.selected = self.arrlistFiltered[indexPath.row] as! PFObject

                    
                }else{
                    self.selected = self.arrlist[indexPath.row] as! PFObject

                    
                }
                
                let daBook: PFFile = self.selected["file"] as! PFFile
                let daBookName: String = self.selected["fullName"] as! String
                let daBookNameDislay: String = self.selected["name"] as! String
              //  let indexPathParse: Int = self.selected["indexPath"] as! Int
                var checkValidation = NSFileManager.defaultManager()
                
                
                ///
                var myHUb:MBProgressHUD =  MBProgressHUD.showHUDAddedTo(self.tableView, animated: true)
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
                        if self.searchActive != nil{
                            
                            self.arrlistFiltered.removeAtIndex(indexPath.row)
                       
                        }else{
                            
                            self.arrlist.removeAtIndex(indexPath.row)

                            
                        }
                        
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
                    
                    myHUb.labelText = "Kiểm tra mục đã tải"
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
        
        else{
            
            var alert = UIAlertView(title: "No Internet Connection", message: "Make sure your device is connected to the internet.", delegate: nil, cancelButtonTitle: "OK")
            alert.show()

        }
       
        
    }
   
    
}
