//
//  FeaturedBooksTableViewController.swift
//  Tarotvn_Ver1
//
//  Created by Nhan Nguyen on 8/17/15.
//  Copyright (c) 2015 Nhan Nguyen. All rights reserved.
//

import UIKit

class FeaturedBooksTableViewController: UITableViewController {
    
    var arrFeaturedBook: [String] = ["Rider Waite Tarot","Lenormand Card","Runes","The Clow Card"]
    var arrFeaturedBookFullName: [String] = ["RiderWaiteTarot.sqlite3", "Lenormand.sqlite3", "RunesChart.sqlite3", "TheClowCard.sqlite3"]
    
    var fixBooks: [String] = ["RiderWaiteTarot", "Lenormand", "RunesChart", "TheClowCard"]
    var selectedFile: String!
    var indexPathOfDownloadedList: Int!
    var indexPathOfFeaturedList: Int!

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
        
        self.revealViewController().rearViewRevealWidth =  180
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

        return cell
    }
    
    override func tableView(tableView: UITableView, didDeselectRowAtIndexPath indexPath: NSIndexPath) {
        
        let name:String = arrFeaturedBook[indexPath.row] as String
        let fullName: String = arrFeaturedBookFullName[indexPath.row] as String
        
        selectedFile = fullName
        indexPathOfFeaturedList = indexPath.row
    
        
        if name == "Runes" {
            
            self.performSegueWithIdentifier("pushFeaturedRunes", sender: nil)
            
        }else{
            
            self.performSegueWithIdentifier("pushFeaturedTarot", sender: nil)
        }
    }
    
    
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


