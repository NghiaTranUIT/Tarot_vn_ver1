//
//  FeaturedBooksTableViewController.swift
//  Tarotvn_Ver1
//
//  Created by Nhan Nguyen on 8/17/15.
//  Copyright (c) 2015 Nhan Nguyen. All rights reserved.
//

import UIKit
import Parse

class FeaturedBooksTableViewController: UITableViewController {
    
    var arrFeaturedBook: [String] = ["Rider Waite Tarot","Lenormand Card","Runes","The Clow Card"]
    var arrFeaturedBookFullName: [String] = ["RiderWaiteTarot.sqlite3", "Lenormand.sqlite3", "RunesChart.sqlite3", "TheClowCard.sqlite3"]
    
    var fixBooks: [String] = ["RiderWaiteTarot", "Lenormand", "RunesChart", "TheClowCard"]
    var selectedFile: String!
    var indexPathOfDownloadedList: Int!
    var indexPathOfFeaturedList: Int!
    //var isFirstLauch : Bool!
    

    @IBOutlet weak var menuButton: UIBarButtonItem!
    
    @IBOutlet var myTableView: UITableView!
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        var query = PFQuery(className: "DataBook")
        let userDefault = NSUserDefaults.standardUserDefaults()
//        
        self.revealViewController().rearViewRevealWidth = 238
        
        self.navigationController?.navigationBar.tintColor = UIColor.whiteColor()
        self.navigationController?.navigationBar.barTintColor = UIColor.blackColor()
        self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.whiteColor()]
        self.navigationController?.navigationBar.translucent = false
        self.navigationController?.navigationBar.barStyle = UIBarStyle.Black
        
        if self.revealViewController() != nil{
            
            menuButton.target = self.revealViewController()
            menuButton.action = "revealToggle:"
            self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
            self.view.addGestureRecognizer(self.revealViewController().tapGestureRecognizer())
            
            
            }
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        var book: String = ""
        
        for book in fixBooks {
            
            let theFileManager = NSFileManager.defaultManager()
            
            let pathToBundledDB: String? = NSBundle.mainBundle().pathForResource(book, ofType: "sqlite3")
            let pathToDevice = pathToDocsFolder(book)
            
            var error: NSError?
            
            // Here is where I get the error:
            if (theFileManager.copyItemAtPath(pathToBundledDB!, toPath:pathToDevice, error: &error)) {
                // success
                NSLog(pathToDocsFolder(book))
            }
            else {
                // failure
            }
            
        }
       
        
        
        if userDefault.objectForKey("isFirstLaunch") == nil {
            
            userDefault.setObject(arrFeaturedBookFullName, forKey: "fileDownload")
            userDefault.setObject(arrFeaturedBook, forKey: "fileDownloadDislay")
            
            userDefault.setBool(true, forKey: "isFirstLaunch")
            
        }
        
     
        
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
        
        

        
        
    }
    func pathToDocsFolder(bookTarot: String) -> String {
        let pathToDocumentsFolder = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)[0] as! String
        var bookTarot = NSString(format: "/%@.sqlite3", bookTarot)
        
        return pathToDocumentsFolder.stringByAppendingPathComponent(bookTarot as String)
    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Potentially incomplete method implementation.
        // Return the number of sections.
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.
        return arrFeaturedBook.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("FeaturedCell", forIndexPath: indexPath) as! UITableViewCell

        // Configure the cell...
        cell.textLabel?.text = arrFeaturedBook[indexPath.row]
        cell.textLabel?.font = UIFont(name: "System", size: 17)
        //cell.selectionStyle = .None

        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        let name:String = arrFeaturedBook[indexPath.row] as String
        let fullName: String = arrFeaturedBookFullName[indexPath.row] as String
        
        selectedFile = fullName
        indexPathOfFeaturedList = indexPath.row
        
        
        
        if name == "Runes"  {
            
            self.performSegueWithIdentifier("pushFeaturedRunes", sender: nil)
            
        } else if  name == "Rider Waite Tarot" {
            
            self.performSegueWithIdentifier("pushFeaturedRunes", sender: nil)
        }
        
        else {
            
            self.performSegueWithIdentifier("pushFeaturedTarot", sender: nil)
        }
    }
    
//    override func tableView(tableView: UITableView, didHighlightRowAtIndexPath indexPath: NSIndexPath) {
//        let cell = tableView.cellForRowAtIndexPath(indexPath)
//        cell?.contentView.backgroundColor = UIColor.blackColor()
//        cell?.textLabel?.backgroundColor = UIColor.blackColor()
//        cell?.textLabel?.textColor = UIColor.whiteColor()
//        
//    }
//    
//    override func tableView(tableView: UITableView, didUnhighlightRowAtIndexPath indexPath: NSIndexPath) {
//        let cell = tableView.cellForRowAtIndexPath(indexPath)
//        cell?.contentView.backgroundColor = UIColor.whiteColor()
//        cell?.textLabel?.backgroundColor = UIColor.whiteColor()
//        cell?.textLabel?.textColor = UIColor.blackColor()
//
//
//    }
    
 override func  prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?)

 {
    if segue.identifier == "pushFeaturedRunes" {
        
        var destinationRunes:ListRunesStoneTableViewController = segue.destinationViewController as! ListRunesStoneTableViewController
        
        destinationRunes.nameFileDatabase = selectedFile
        destinationRunes.indexPathOfFeaturedList = indexPathOfFeaturedList
        destinationRunes.nameFileDatabaseIndexPaths = 0
        
    }else{
        
        var destination:ListTarotCardTableViewController = segue.destinationViewController as! ListTarotCardTableViewController
        
        destination.nameFileDatabase = selectedFile
        destination.indexPathOfFeaturedList = indexPathOfFeaturedList
        destination.nameFileDatabaseIndexPaths = 0

        
    }
}
    
   
        
    
}


