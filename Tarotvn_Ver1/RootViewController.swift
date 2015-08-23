//
//  RootViewController.swift
//  Tarotvn_Ver1
//
//  Created by Nhan Nguyen on 8/22/15.
//  Copyright (c) 2015 Nhan Nguyen. All rights reserved.
//

import UIKit

class RootViewController: SWRevealViewController, MenuControllerDelegate {

     var menuController:MenuController?
     var featureBookNavigationController:UINavigationController?
    
    // Home
    var homeScreen:UINavigationController?
    var availableScreen: UINavigationController?
    var downloadedScreen: UINavigationController?
    var infoScreen: UINavigationController?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        if featureBookNavigationController == nil
        {
            featureBookNavigationController = storyboard?.instantiateViewControllerWithIdentifier("featureScreen") as? UINavigationController
            
            setFrontViewController(featureBookNavigationController, animated: false)
        }
        
        if homeScreen == nil
        {
            homeScreen = storyboard?.instantiateViewControllerWithIdentifier("homeScreen") as? UINavigationController
            
            //setFrontViewController(homeScreen, animated: false)
        }
        if availableScreen == nil
        {
            availableScreen = storyboard?.instantiateViewControllerWithIdentifier("storedBooks") as? UINavigationController
            
           // setFrontViewController(availableScreen, animated: false)
        }
        if downloadedScreen == nil
        {
            downloadedScreen = storyboard?.instantiateViewControllerWithIdentifier("downloadedBooks") as? UINavigationController
            
           // setFrontViewController(downloadedScreen, animated: false)
        }
        
        if infoScreen == nil
        {
            infoScreen = storyboard?.instantiateViewControllerWithIdentifier("aboutBooks") as? UINavigationController
            
            //setFrontViewController(infoScreen, animated: false)
        }
       
        
        if menuController == nil
        {
            menuController = storyboard?.instantiateViewControllerWithIdentifier("leftScreen") as? MenuController
            menuController?.delegate = self;
            
            setRearViewController(menuController, animated: false)
        }
        
    
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func didSelectedLeftMenuItem(sender: MenuController, atRow: NSInteger)
    {
        if atRow == 0
        {
            // Do nothing
        }
        else if atRow == 1
        {
            
            if frontViewController == homeScreen
            {
                // close
                revealToggleAnimated(true)

                return
            }
            
            // Trang tru
            if (homeScreen == nil)
            {
                homeScreen = storyboard?.instantiateViewControllerWithIdentifier("homeScreen") as? UINavigationController
            }
            
            setFrontViewController(homeScreen, animated: false)
            // close
            revealToggleAnimated(true)

            
        }
        else if atRow == 2
        {
            
            
            if frontViewController == featureBookNavigationController
            {
                // close
                revealToggleAnimated(true)

                return
            }
            
            setFrontViewController(featureBookNavigationController, animated: false)
            // close
            revealToggleAnimated(true)

          
        }
        else if atRow == 3
        {
            
            if frontViewController == availableScreen
            {
                // close
                revealToggleAnimated(true)

                return
                
            }
            
            // Trang tru
            if (availableScreen == nil)
            {
                availableScreen = storyboard?.instantiateViewControllerWithIdentifier("storedBooks") as? UINavigationController
            }
            
            setFrontViewController(availableScreen, animated: false)
            
            // close
            revealToggleAnimated(true)

        }
        else if atRow == 4
        {
            
            if frontViewController == downloadedScreen
            {
                // close
                revealToggleAnimated(true)

                return
            }
            
            // Trang tru
            if (downloadedScreen == nil)
            {
                downloadedScreen = storyboard?.instantiateViewControllerWithIdentifier("downloadedBooks") as? UINavigationController
            }
            
            setFrontViewController(downloadedScreen, animated: false)
            // close
            revealToggleAnimated(true)

            
            
        }
        else if atRow == 5
        {
           
            
            if frontViewController == infoScreen
            {
                // close
                revealToggleAnimated(true)

                return
            }
            
            // Trang tru
            if (infoScreen == nil)
            {
                infoScreen = storyboard?.instantiateViewControllerWithIdentifier("aboutBooks") as? UINavigationController
            }
            
            setFrontViewController(infoScreen, animated: false)
            
            // close
            revealToggleAnimated(true)

        }
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
