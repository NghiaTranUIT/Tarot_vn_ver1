//
//  DownloadedBooksTableViewController.swift
//  Tarotvn_Ver1
//
//  Created by Nhan Nguyen on 8/17/15.
//  Copyright (c) 2015 Nhan Nguyen. All rights reserved.
//

import UIKit

class DownloadedBooksTableViewController: UITableViewController {
    
    var arrDownloadedFile: [NSString] = []
    var arrDownloadedFileDislay: [NSString] = []
    var arrFileNameDownloadedShowUp: [NSString] = []
    var selectedFile:String!
    var indexPathOfDownloadedList: Int!


    @IBOutlet weak var menuButton: UIBarButtonItem!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if self.revealViewController() != nil{
            
            menuButton.target = self.revealViewController()
            menuButton.action = "revealToggle:"
            self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        }

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
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
        return arrDownloadedFileDislay.count
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        let userDefault = NSUserDefaults.standardUserDefaults()
        
        if let arrFileNameDownloaded: AnyObject = userDefault.objectForKey("fileDownload")
        {
            var readArray: [NSString] = arrFileNameDownloaded as! [NSString]
            
            arrDownloadedFile = readArray
        }
        
        if let arrFileNameDownloadedDislay: AnyObject = userDefault.objectForKey("fileDownloadDislay")
        {
            var readArrayDislay: [NSString] = arrFileNameDownloadedDislay as! [NSString]
            
            arrDownloadedFileDislay = readArrayDislay
        }
        
//        if let arrFileNameDownloadedFileShowUp: AnyObject = userDefault.objectForKey("fileDownloadShowUp")
//        {
//            var readArrayShowUp: [NSString] = arrFileNameDownloadedFileShowUp as! [NSString]
//            arrFileNameDownloadedShowUp = readArrayShowUp
//            
//        }
        
        self.tableView .reloadData()
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("DownloadedBooks", forIndexPath: indexPath) as! UITableViewCell

        // Configure the cell...
        cell.textLabel?.text = arrDownloadedFileDislay[indexPath.row] as String

        return cell
    }
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        let name:String = arrDownloadedFile[indexPath.row] as String;
        indexPathOfDownloadedList = indexPath.row;
        
        selectedFile = name;
        
        if arrDownloadedFileDislay[indexPath.row] == "Runes"{
            
            self.performSegueWithIdentifier("pushDetailRunes", sender: nil)
            
        }else{
        
            self.performSegueWithIdentifier("pushDetailCard", sender: nil);
        }
    }
    
    override func  prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?)
    {
        if segue.identifier == "pushDetailCard"{
            var destination:ListTarotCardTableViewController = segue.destinationViewController as! ListTarotCardTableViewController
            
            destination.nameFileDatabase = selectedFile
            destination.nameFileDatabaseIndexPaths = indexPathOfDownloadedList
            destination.indexPathOfFeaturedList = 0
            
        }
        else{
            
            var destinationRunes:ListRunesStoneTableViewController = segue.destinationViewController as! ListRunesStoneTableViewController
            
            destinationRunes.nameFileDatabase = selectedFile
            destinationRunes.nameFileDatabaseIndexPaths = indexPathOfDownloadedList
            
        }
    }
    


    
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the specified item to be editable.
        return true
    }
    
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            //self.tableView.reloadData()
            let userDefault = NSUserDefaults.standardUserDefaults()
            if let arrFileNameDownloaded: AnyObject = userDefault.objectForKey("fileDownload"){
                
                var readArray: [NSString] = arrFileNameDownloaded as! [NSString]
                readArray.removeAtIndex(indexPath.row)
                userDefault.setObject(readArray, forKey: "fileDownload")
            }
            
            if let arrFileNameDownloadedDislay: AnyObject = userDefault.objectForKey("fileDownloadDislay"){
                
                var readArrayDislay: [NSString] = arrFileNameDownloadedDislay as! [NSString]
                readArrayDislay.removeAtIndex(indexPath.row)
                userDefault.setObject(readArrayDislay, forKey: "fileDownloadDislay")
            }
            
            
            removeData(arrDownloadedFile[indexPath.row] as String)
            removeData(arrDownloadedFileDislay[indexPath.row] as String)
            
            arrDownloadedFile .removeAtIndex(indexPath.row)
            arrDownloadedFileDislay.removeAtIndex(indexPath.row)
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
            
            ///add notification
            
            let newCreatedNotification = NSNotification(name: "reloadListBooks", object: nil)
            NSNotificationCenter.defaultCenter().postNotification(newCreatedNotification)
            ///
            
            
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }
    }
    func removeData(itemName: String){
        
        var fileManager: NSFileManager = NSFileManager.defaultManager()
        let nsDocumentDirectory = NSSearchPathDirectory.DocumentDirectory
        let nsUserDomainMask = NSSearchPathDomainMask.UserDomainMask
        if let paths = NSSearchPathForDirectoriesInDomains(nsDocumentDirectory, nsUserDomainMask, true){
            
            if paths.count > 0{
                
                if let dirPath = paths[0] as? String {
                    var filePath = NSString(format:"%@/%@", dirPath, itemName) as String
                    NSLog("%@",filePath)
                    var error: NSErrorPointer = NSErrorPointer()
                    fileManager.removeItemAtPath(filePath, error: error)
                    if error != nil{
                        println(error.debugDescription)
                    }
                    
                    
                }
            }
            
        }
        
    }


   

}
