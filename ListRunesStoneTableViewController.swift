//
//  ListRunesStoneTableViewController.swift
//  Tarotvn_Ver1
//
//  Created by Nhan Nguyen on 8/17/15.
//  Copyright (c) 2015 Nhan Nguyen. All rights reserved.
//

import UIKit

class ListRunesStoneTableViewController: UITableViewController, UISearchBarDelegate {
    
    @IBOutlet weak var mySearch: UISearchBar!
    @IBOutlet var myTableView: UITableView!
 
    var arrCard:[TarotCard]!
    var card:TarotCard!
    var searchActive : Bool = false
    var database:DatabaseManager!;
    var filtered:[TarotCard] = []
    var selectedCard:TarotCard!
    ///
    var arrDownloadedFile: [NSString] = []
    var arrDownloadedFileDislay: [NSString] = []
    var selectedFile:String!
    
    var nameFileDatabase:String!
    var nameFileDatabaseIndexPaths:Int!
    var indexPathOfFeaturedList: Int!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        arrCard = []
        
        
        mySearch.delegate = self
        
        // self.searchBarContainerView.backgroundColor = UIColor.blueColor()
        
        // self.shyNavBarManager.scrollView = self.myTableView;
        
        database = DatabaseManager();
        
        // Connect
        database .confirgureDatabaseWithName(nameFileDatabase!)
        
        arrCard =  database.getAllOfTarotCaseInDatabase()
        
        self.myTableView.reloadData()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    
    func searchBarTextDidBeginEditing(searchBar: UISearchBar) {
        searchActive = true;
    }
    
    func searchBarTextDidEndEditing(searchBar: UISearchBar) {
        searchActive = false;
    }
    
    func searchBarCancelButtonClicked(searchBar: UISearchBar) {
        searchActive = false;
    }
    
    func searchBarSearchButtonClicked(searchBar: UISearchBar) {
        searchActive = false;
    }
    
    func searchBar(mySearch: UISearchBar, textDidChange searchText: String) {
        
        if searchText.lengthOfBytesUsingEncoding(NSUTF8StringEncoding) > 0
        {
            searchActive = true;
            
            self.filtered = database.getAllCardWithName(searchText);
            
            myTableView.reloadData();
        }
        else
            
        {
            searchActive = false;
            
            myTableView.reloadData();
        }
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
        if(searchActive) {
            
            return filtered.count
        }

        return arrCard.count
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        selectedCard = arrCard[indexPath.row]
        var indexCombined: Int = nameFileDatabaseIndexPaths + indexPathOfFeaturedList
        println(nameFileDatabaseIndexPaths)
        println(indexPathOfFeaturedList)
        
        var  defaultName: String = arrDownloadedFileDislay[indexCombined] as String
        
        if defaultName == "Runes" {
        
            [self.performSegueWithIdentifier("SelectedRunes", sender: nil)]
            
        }else if defaultName == "Rider Waite Tarot"{
            
            [self.performSegueWithIdentifier("SelectedRider", sender: nil)]
        }
        else if defaultName == "The Clow Card"{
            
            [self.performSegueWithIdentifier("SelectedRunes", sender: nil)]
        }
        
        else{
        
            self.performSegueWithIdentifier("SelectedRunes", sender: nil)
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        
        if (segue.identifier == "SelectedRider")
        {
            // pass data to next view
            var detailScreen:DetailRiderCardViewController = segue.destinationViewController as! DetailRiderCardViewController;
            
            detailScreen.card = selectedCard;
            
        }
        
        if (segue.identifier == "SelectedTarot")
        {
            // pass data to next view
            var detailScreen1:DeatailGeneralCardViewController = segue.destinationViewController as! DeatailGeneralCardViewController;
            
            detailScreen1.card = selectedCard;
            
        }
        
        if (segue.identifier == "SelectedRunes")
        {
            // pass data to next view
            var detailScreen1:DeatailGeneralCardViewController = segue.destinationViewController as! DeatailGeneralCardViewController;
            
            detailScreen1.card = selectedCard;
            
        }
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> RunesStoneTableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("RunesCell", forIndexPath: indexPath) as! RunesStoneTableViewCell

        // Configure the cell...
        if(searchActive){
            
            // cell.textLabel?.text = filtered[indexPath.row].nameCard
            cell.lblRunes.text = filtered[indexPath.row].nameCard
            cell.imgRunes.image = UIImage(named: filtered[indexPath.row].images)
            
        } else {
            let card = arrCard[indexPath.row] as TarotCard
            cell.lblRunes.text = card.nameCard
            cell.imgRunes.image = UIImage(named: card.images)
        }
        
        return cell
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
        
        
    }



}
