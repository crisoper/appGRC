//
//  cellSeguimientoTVCell.swift
//  AppGRC
//
//  Created by Crisoper on 15/07/16.
//  Copyright © 2016 Crisoper. All rights reserved.
//

import UIKit

class cellSeguimientoTVCell: UITableViewCell {
    
    
    @IBOutlet weak var lblEqtiqueta: UILabel!
    @IBOutlet weak var lblText: UILabel!
    @IBOutlet weak var btnInformacion: UIButton!
    
    //Declaramos un método
    var tapAction: ((UITableViewCell) -> Void)?
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func showInformacionSeguimiento(sender: AnyObject) {
        self.tapAction?(self)
    }
    
    
    

}
