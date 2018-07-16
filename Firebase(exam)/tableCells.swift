//
//  tableCells.swift
//  Firebase(exam)
//
//  Created by Yusuf DEMİRKOPARAN on 15.07.2018.
//  Copyright © 2018 Yusuf DEMİRKOPARAN. All rights reserved.
//

import UIKit

class tableCells: UITableViewCell {
    @IBOutlet weak var homaImage: UIImageView!
    
    @IBOutlet weak var homeuserName: UILabel!
    @IBOutlet weak var homeComment: UITextView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
