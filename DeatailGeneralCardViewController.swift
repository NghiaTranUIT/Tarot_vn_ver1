//
//  DeatailGeneralCardViewController.swift
//  Tarotvn_Ver1
//
//  Created by Nhan Nguyen on 8/17/15.
//  Copyright (c) 2015 Nhan Nguyen. All rights reserved.
//

import UIKit

class DeatailGeneralCardViewController: UIViewController {
   
    var arrCard:[TarotCard]!
    var card:TarotCard!
    let defaults = NSUserDefaults.standardUserDefaults()


    @IBOutlet weak var myDescription: UITextView!
    
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
        
        let nightMode = UIAlertAction(title: "Chế Độ Nhìn Đêm", style: .Default, handler: {
            (alert: UIAlertAction!) -> Void in
            println("Background have been changed successfully")
            
            self.myDescription.textColor = UIColor.whiteColor()
            self.myDescription.backgroundColor = UIColor.blackColor()
            self.view.backgroundColor = UIColor.blackColor()
            self.defaults.setObject("whiteFont", forKey: "nightMode")
            
            
            
        })
        
        //
        let cancelAction = UIAlertAction(title: "Mặc Định", style: .Cancel, handler: {
            (alert: UIAlertAction!) -> Void in
            println("Cancelled")
            
            self.myDescription.font = UIFont(name: self.myDescription.font.fontName, size: 14)
            
            self.defaults.setObject(14, forKey: "defaultFont")
            self.defaults.setObject(nil, forKey: "mediumFont")
            self.defaults.setObject(nil, forKey: "largeFont")
            self.defaults.setObject(nil, forKey: "nightMode")
            
            self.myDescription.textColor = UIColor.blackColor()
            self.myDescription.backgroundColor = UIColor.whiteColor()
             self.view.backgroundColor = UIColor.whiteColor()
        })
        
        
        // 4
        optionMenu.addAction(mediumSize)
        optionMenu.addAction(largeSize)
        optionMenu.addAction(nightMode)
        optionMenu.addAction(cancelAction)
        
        
        // 5
        self.presentViewController(optionMenu, animated: true, completion: nil)
        

    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        myDescription.text = card.forwardCard
        
        if (defaults.stringForKey("mediumFont") != nil) {
            
            myDescription.font = UIFont(name: myDescription.font.fontName, size: 18)
            
            if defaults.stringForKey("nightMode") != nil{
                
                myDescription.textColor = UIColor.whiteColor()
                myDescription.backgroundColor = UIColor.blackColor()
                 self.view.backgroundColor = UIColor.blackColor()
            }
            
        } else if (defaults.stringForKey("largeFont") != nil) {
            
            myDescription.font = UIFont(name: myDescription.font.fontName, size: 22)
            
            if defaults.stringForKey("nightMode") != nil{
                
                myDescription.textColor = UIColor.whiteColor()
                myDescription.backgroundColor = UIColor.blackColor()
                self.view.backgroundColor = UIColor.blackColor()
            }
            
        } else if (defaults.stringForKey("nightMode") != nil) {
            
            myDescription.textColor = UIColor.whiteColor()
            myDescription.backgroundColor = UIColor.blackColor()
             self.view.backgroundColor = UIColor.blackColor()
            
        } else{
            
          myDescription.font = UIFont(name: myDescription.font.fontName, size: 14)
            
            myDescription.textColor = UIColor.blackColor()
            myDescription.backgroundColor = UIColor.whiteColor()
             self.view.backgroundColor = UIColor.whiteColor()
            
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
