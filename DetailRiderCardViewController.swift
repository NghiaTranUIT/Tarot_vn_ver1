//
//  DetailRiderCardViewController.swift
//  Tarotvn_Ver1
//
//  Created by Nhan Nguyen on 8/17/15.
//  Copyright (c) 2015 Nhan Nguyen. All rights reserved.
//

import UIKit

class DetailRiderCardViewController: UIViewController {
    
    var arrCard:[TarotCard]!
    var card:TarotCard!
    let defaults = NSUserDefaults.standardUserDefaults()

    @IBOutlet weak var myDescription: UITextView!
    @IBOutlet weak var mySegment: UISegmentedControl!
    @IBAction func configFont(sender: AnyObject) {
        
        // 1
        let optionMenu = UIAlertController(title: nil, message: "Choose Option", preferredStyle: .ActionSheet)
        
        // 2
        let mediumSize = UIAlertAction(title: "Vừa", style: .Default, handler: {
            (alert: UIAlertAction!) -> Void in
            println("Font have been changed successfully")
            
            self.myDescription.font = UIFont(name: self.myDescription.font.fontName, size: 18)
            self.defaults.setObject(18, forKey: "mediumFont")
            self.defaults.setObject(nil, forKey: "largeFont")
            
            
        })
        let largeSize = UIAlertAction(title: "Lớn", style: .Default, handler: {
            (alert: UIAlertAction!) -> Void in
            println("Font have been changed successfully")
            
            self.myDescription.font = UIFont(name: self.myDescription.font.fontName, size: 22)
            self.defaults.setObject(22, forKey: "largeFont")
            self.defaults.setObject(nil, forKey: "mediumFont")
        })
        
        //
        let cancelAction = UIAlertAction(title: "Mặc Định", style: .Cancel, handler: {
            (alert: UIAlertAction!) -> Void in
            println("Cancelled")
            
            self.myDescription.font = UIFont(name: self.myDescription.font.fontName, size: 14)
            self.defaults.setObject(14, forKey: "defaultFont")
            self.defaults.setObject(nil, forKey: "mediumFont")
            self.defaults.setObject(nil, forKey: "largeFont")
        })
        
        
        // 4
        optionMenu.addAction(mediumSize)
        optionMenu.addAction(largeSize)
        optionMenu.addAction(cancelAction)
        
        // 5
        self.presentViewController(optionMenu, animated: true, completion: nil)
    }
    
   
    @IBAction func mySelection(sender: AnyObject) {
        
        switch mySegment.selectedSegmentIndex
        {
        case 0:
            myDescription.text = card.keyDetail
        case 1:
            myDescription.text = card.forwardCard
            
        case 2:
            myDescription.text = card.reverseCard
            
        case 3:
            myDescription.text = card.information
        default:
            break;
        }

    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        super.viewDidLoad()
        myDescription.text = card.keyDetail
        
        if (defaults.stringForKey("mediumFont") != nil){
            
            myDescription.font = UIFont(name: myDescription.font.fontName, size: 18)
            
        }else if (defaults.stringForKey("largeFont") != nil){
            myDescription.font = UIFont(name: myDescription.font.fontName, size: 22)
            
            
        }else{
            myDescription.font = UIFont(name: myDescription.font.fontName, size: 14)
        }
        

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
