//
//  ProyectosTVCell.swift
//  AppGRC
//
//  Created by Crisoper on 23/07/16.
//  Copyright © 2016 Crisoper. All rights reserved.
//

import UIKit

class ProyectosTVCell: UITableViewCell {
    
    //Outlets
    @IBOutlet weak var myImage: UIImageView!
    @IBOutlet weak var lblNombre: UILabel!
    @IBOutlet weak var lblSNIP: UILabel!
    @IBOutlet weak var lblMonto: UILabel!
    @IBOutlet weak var lblAnio: UILabel!
    @IBOutlet weak var bntMas: UIButton!
    
    var tapAction: ((UITableViewCell) -> Void)?

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    @IBAction func detalleProyectos(sender: AnyObject) {
        self.tapAction?(self)
    }
    
    

}
