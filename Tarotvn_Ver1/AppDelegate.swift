//
//  AppDelegate.swift
//  Tarotvn_Ver1
//
//  Created by Nhan Nguyen on 8/17/15.
//  Copyright (c) 2015 Nhan Nguyen. All rights reserved.
//

import UIKit
import Parse
import Bolts

let KREACHABLEWITHWIFI = "ReachableWithWifi"
let KNOTREACHABLE = "NotReachable"
let KREACHABLEWOTHWLAN = "ReachableWithWLAN"

var reachability: Reachability?
var reachablityStatus = KNOTREACHABLE

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var internerReach: Reachability?


    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        // Override point for customization after application launch.
        // [Optional] Power your app with Local Datastore. For more info, go to
        // https://parse.com/docs/ios_guide#localdatastore/iOS
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "reachabilityChanged:", name: kReachabilityChangedNotification, object: nil)
        
        internerReach = Reachability.reachabilityForInternetConnection()
        internerReach?.startNotifier()
        
        if internerReach != nil{
            
            self.StatusChangedWithReachability(internerReach!)
            
        }
        
        Parse.enableLocalDatastore()
        
        // Initialize Parse.
        Parse.setApplicationId("DPto2wRkgnK6HDANapSatJBatmCVZhawwKePk2ck",
            clientKey: "EAEcto3ocmxy4Est6mguZb18cM1QSgbOacEFcKrR")
        
        // [Optional] Track statistics around application opens.
        PFAnalytics.trackAppOpenedWithLaunchOptions(launchOptions)
       
        return true
    }
    
    func reachabilityChanged(notification: NSNotification)
    {
        
        println("Reachability Status changed....")
        reachability = notification.object as? Reachability
        self.StatusChangedWithReachability(reachability!)
        
        
    }
    
    func StatusChangedWithReachability(currentReachabilityStatus: Reachability){
        
        var networkStatus: NetworkStatus = currentReachabilityStatus.currentReachabilityStatus()
        var statusString: String = ""
        println("statusValue: \(networkStatus.value)")
        
        if networkStatus.value == NotReachable.value{
            
            println("network not reachable...")
            reachablityStatus = KNOTREACHABLE
        }
        else if networkStatus.value == ReachableViaWiFi.value {
            
            println("Reachable Via WIFI")
            reachablityStatus = KREACHABLEWITHWIFI
            
        }else if networkStatus.value == ReachableViaWWAN.value{
            
            println("reachane via WLAN")
            reachablityStatus = KREACHABLEWOTHWLAN
            
        }
        
        NSNotificationCenter.defaultCenter().postNotificationName("ReachStatusChanged", object: nil)
    }
    
    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
        
        NSNotificationCenter.defaultCenter().removeObserver(self, name: kReachabilityChangedNotification, object: nil)

    }


}

