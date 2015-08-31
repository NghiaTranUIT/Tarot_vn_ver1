//
//  ListTarotCardTableViewController.swift
//  Tarotvn_Ver1
//
//  Created by Nhan Nguyen on 8/17/15.
//  Copyright (c) 2015 Nhan Nguyen. All rights reserved.
//

import UIKit

class ListTarotCardTableViewController: UITableViewController, UISearchBarDelegate {
    
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


    @IBOutlet var myTableView: UITableView!
    @IBOutlet weak var mySearch: UISearchBar!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        arrCard = []
        mySearch.delegate = self
        database = DatabaseManager();
        
        // Connect
        database .confirgureDatabaseWithName(nameFileDatabase)
        
        arrCard =  database.getAllOfTarotCaseInDatabase()
        


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
        
        var textFieldInsideSearchBar = mySearch.valueForKey("searchField") as? UITextField
        
        textFieldInsideSearchBar?.textColor = UIColor(red: 77/255, green: 118/255, blue: 78/255, alpha: 1.0)
        
        if searchText.lengthOfBytesUsingEncoding(NSUTF8StringEncoding) > 0
        {
            searchActive = true;
            
            self.filtered = database.getAllCardWithName(searchText);
            
            myTableView.reloadData();
        }
        else
            
        {
            searchActive = false;
           // mySearch.resignFirstResponder()
            
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
        return arrCard.count;
    }
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        selectedCard = arrCard[indexPath.row]
        
        var indexConbined: Int? = nameFileDatabaseIndexPaths + indexPathOfFeaturedList
        
        var  defaultName: String = arrDownloadedFileDislay[indexConbined!] as String
        
//        if defaultName == "Rider Waite Tarot"
//        {
//            
//            [self .performSegueWithIdentifier("SelectedRider", sender: nil)]
//            
//        }
//            
//        else{
        
                [self.performSegueWithIdentifier("SelectedTarot", sender: nil)]
            

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
            var detailScreen1: DeatailGeneralCardViewController = segue.destinationViewController as! DeatailGeneralCardViewController;
            
            detailScreen1.card = selectedCard;
            
        }
        
        
    }

   
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("TarotCard", forIndexPath: indexPath) as! UITableViewCell

        // Configure the cell...
        
        if(searchActive){
            
            cell.textLabel?.text = filtered[indexPath.row].nameCard
            cell.textLabel?.textColor = UIColor(red: 77/255, green: 118/255, blue: 78/255, alpha: 1.0)
            
        } else {
            let card = arrCard[indexPath.row] as TarotCard
            cell.textLabel?.text = card.nameCard
            cell.textLabel?.textColor = UIColor(red: 77/255, green: 118/255, blue: 78/255, alpha: 1.0)
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

   

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

}
