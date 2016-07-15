//
//  SeguimientoUTVCell.swift
//  AppGRC
//
//  Created by Crisoper on 12/07/16.
//  Copyright © 2016 Crisoper. All rights reserved.
//

import UIKit

class SeguimientoUTVCell: UITableViewCell {
    
    
    //Outlets
    @IBOutlet weak var lblExpediente: UILabel!
    @IBOutlet weak var lblDocumento: UILabel!
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
    
    
    @IBAction func mostrarExpediente(sender: AnyObject) {
        
        //Seteamos expediente id
        
        //ClassDatosMAD.sharedDatosMAD.idMadReferencia = lblExpediente.text!
        
        self.tapAction?(self)
        
        
        /*
         
        //Mostrando datos
        let storyboard:UIStoryboard = UIStoryboard(name: "Mad", bundle: nil)
        let popoverContent:EmerrgenteMadVC = (storyboard.instantiateViewControllerWithIdentifier("EmerrgenteMadVCID")) as! EmerrgenteMadVC
        let nav = UINavigationController(rootViewController: popoverContent)
        nav.modalPresentationStyle = UIModalPresentationStyle.Popover
        self.presentViewController(nav, animated: true, completion: nil)
        
        //nav.
         
        
         let storyboard:UIStoryboard = UIStoryboard(name: "Noticias", bundle: nil)
         let controller:NoticiasTVC  = storyboard.instantiateViewControllerWithIdentifier("NoticiasVCID") as! NoticiasTVC
         self.showViewController(controller, sender: self)
        */
    }
    

}
