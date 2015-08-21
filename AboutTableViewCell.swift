//
//  AboutTableViewCell.swift
//  Tarotvn_Ver1
//
//  Created by Nhan Nguyen on 8/21/15.
//  Copyright (c) 2015 Nhan Nguyen. All rights reserved.
//

import UIKit

class AboutTableViewCell: UITableViewCell {
    
    @IBOutlet weak var lblAbout: UILabel!
    @IBOutlet weak var imgAbout: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
