//
//  tabDocumentosProyectosVC.swift
//  AppGRC
//
//  Created by Crisoper on 23/07/16.
//  Copyright © 2016 Crisoper. All rights reserved.
//

import UIKit

class tabDocumentosProyectosVC: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    //Colores globales
    let myConstants = MyClassConstants()
    
    //Outlets
    @IBOutlet weak var mytable: UITableView!
    @IBOutlet weak var viewHeader: UIView!
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.view.backgroundColor = myConstants.colorFondo2
        self.mytable.backgroundColor = myConstants.colorFondo2
        self.viewHeader.backgroundColor = myConstants.colorFondo2
        
        self.mytable.estimatedRowHeight = 40
        self.mytable.rowHeight = UITableViewAutomaticDimension
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //99 000 000
    
    //Implementando métodos de tablas
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 25
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell:documentosTableViewCell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as! documentosTableViewCell
        
        
        cell.backgroundColor = myConstants.colorFondo2
        
        cell.btnNroMAD.backgroundColor = myConstants.colorFondo2
        cell.btnNroMAD.tintColor = myConstants.colorIconos
        
        cell.lblDocumento.backgroundColor = myConstants.colorFondo2
        cell.lblDocumento.numberOfLines = 0
        
        if indexPath.row % 2 == 0 {
            cell.btnArchivo.hidden = true
        }
        else {
            cell.btnArchivo.hidden = false
        }
        
        
        /*
        cell.lblExpediente.text = self.posts.objectAtIndex(indexPath.row).valueForKey("ExpedienteId") as! NSString as String
        cell.lblDocumento.text = self.posts.objectAtIndex(indexPath.row).valueForKey("Documento") as! NSString as String
        
        //Desabilitar seleccion de la fila
        cell.selectionStyle = UITableViewCellSelectionStyle.None
        
        cell.btnInformacion.tintColor = myConstants.colorIconos
        
        
        cell.tapAction = { (cell) in
            
            
            let storyboard:UIStoryboard = UIStoryboard(name: "Mad", bundle: nil)
            let popoverContent:EmerrgenteMadVC = (storyboard.instantiateViewControllerWithIdentifier("EmerrgenteMadVCID")) as! EmerrgenteMadVC
            let nav = UINavigationController(rootViewController: popoverContent)
            nav.modalPresentationStyle = UIModalPresentationStyle.Popover
            self.presentViewController(nav, animated: false, completion: nil)
            
            
        }
         */
        
        
        return cell
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
