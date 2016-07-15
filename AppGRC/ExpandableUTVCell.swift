//
//  ExpandableUTVCell.swift
//  AppGRC
//
//  Created by Crisoper on 12/07/16.
//  Copyright © 2016 Crisoper. All rights reserved.
//

import UIKit

class ExpandableUTVCell: UITableViewCell {

    //Outlets
    @IBOutlet weak var imgLeft: UIImageView!
    @IBOutlet weak var lblExpediente: UILabel!
    @IBOutlet weak var lblFecha: UILabel!
    @IBOutlet weak var btnInformacion: UIButton!
    
    
    
    //Declaramos un métodos para mostrar información
    //var tapActionPor: ((UITableViewCell) -> Void)?
    //var tapActionDe: ((UITableViewCell) -> Void)?
    var tapActionA: ((UITableViewCell) -> Void)?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    @IBAction func mostrarDetalleSeguimiento(sender: AnyObject) {
        self.tapActionA?(self)
    }
    
    
    
}
