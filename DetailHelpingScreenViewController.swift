//
//  DetailHelpingScreenViewController.swift
//  Tarotvn_Ver1
//
//  Created by Nhan Nguyen on 8/21/15.
//  Copyright (c) 2015 Nhan Nguyen. All rights reserved.
//

import UIKit

class DetailHelpingScreenViewController: UIViewController {
    
    var nameOfHelping: String!

    @IBOutlet weak var txtAbout: UITextView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if nameOfHelping == "Tarot.vn" {
            
            println("noi dung tarot.vn")
            txtAbout.text = "noi dung tarot.vn"
            
            
        }else if nameOfHelping ==  "Mystic House" {
            
            println("noi dung mystic House")
            txtAbout.text = "noi dung mystic House"
            
        }else{
            
            println("noi dung tro giup")
            txtAbout.text = "noi dung tro giup"
        }
        // Do any additional setup after loading the view.
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
