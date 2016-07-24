//
//  documentosTableViewCell.swift
//  AppGRC
//
//  Created by Crisoper on 23/07/16.
//  Copyright © 2016 Crisoper. All rights reserved.
//

import UIKit

class documentosTableViewCell: UITableViewCell {
    
    //Outlets
    @IBOutlet weak var btnNroMAD: UIButton!
    @IBOutlet weak var lblDocumento: UILabel!
    @IBOutlet weak var btnArchivo: UIButton!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
