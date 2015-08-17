//
//  BookTarot.swift
//  tarotvn
//
//  Created by Nhan Nguyen on 8/16/15.
//  Copyright (c) 2015 Nhan Nguyen. All rights reserved.
//

import Foundation

import UIKit

class BookTarot: NSObject {
    
    var name: String
    var fullName: String
    
    init(name:String, fullName: String){
        
        self.name = name
        self.fullName = fullName
        super.init()
    }
    
}

