//
//  AcecadeTableViewCell.swift
//  AppGRC
//
//  Created by Crisoper on 11/06/16.
//  Copyright © 2016 Crisoper. All rights reserved.
//

import UIKit

class AcecadeTableViewCell: UITableViewCell {
    
    @IBOutlet weak var imageCell: UIImageView!
    @IBOutlet weak var labelCell: UILabel!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
