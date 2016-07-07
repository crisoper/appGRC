//
//  NoticiasTVCell.swift
//  AppGRC
//
//  Created by Crisoper on 18/06/16.
//  Copyright © 2016 Crisoper. All rights reserved.
//

import UIKit

class NoticiasTVCell: UITableViewCell {
    
    
    @IBOutlet weak var myTitle: UILabel!
    @IBOutlet weak var myImage: UIImageView!
    @IBOutlet weak var myDate: UILabel!
    @IBOutlet weak var myDescripcion: UILabel!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
