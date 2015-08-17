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
    var arrFeatureBookFullName: [String] = ["RiderWaiteTarot.sqlite3", "Lenormand.sqlite3", "RunesChart.sqlite3", "TheClowCard.sqlite3"]
    
    var selectedFile: String!
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
        
        self.revealViewController().rearViewRevealWidth =  180
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
        let name:String = arrFeaturedBook[indexPath.row] as String;
        let fullName: String = arrFeatureBookFullName[indexPath.row] as String
        
        selectedFile = fullName
        indexPathOfDownloadedList = indexPath.row;
    
        
        if arrFeaturedBook[indexPath.row] == "Runes"{
            
            self.performSegueWithIdentifier("pushFeaturedRunes", sender: nil)
            
        }else{
            
            self.performSegueWithIdentifier("pushFeaturedTarot", sender: nil);
        }
    }
    
    
 override func  prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?)
{
    if segue.identifier == "pushFeaturedTarot"{
        var destination:ListTarotCardTableViewController = segue.destinationViewController as! ListTarotCardTableViewController
        
        destination.nameFileDatabase = selectedFile
        destination.nameFileDatabaseIndexPaths = indexPathOfDownloadedList
        
    }else{
        
        var destinationRunes:ListRunesStoneTableViewController = segue.destinationViewController as! ListRunesStoneTableViewController
        
        destinationRunes.nameFileDatabase = selectedFile
        destinationRunes.nameFileDatabaseIndexPaths = indexPathOfDownloadedList
        
    }
}

}


