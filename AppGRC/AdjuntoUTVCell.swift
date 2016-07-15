//
//  AdjuntoUTVCell.swift
//  AppGRC
//
//  Created by Crisoper on 12/07/16.
//  Copyright © 2016 Crisoper. All rights reserved.
//

import UIKit

class AdjuntoUTVCell: UITableViewCell {
    
    //Outlets
    @IBOutlet weak var lblExpediente: UILabel!
    @IBOutlet weak var lblDocumento: UILabel!
    @IBOutlet weak var btnInformacion: UIButton!

    //cellA
    
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
    
    //Mostramos emergente
    @IBAction func mostrarEmergenteMAD(sender: AnyObject) {
        self.tapAction?(self)
    }
    

}
