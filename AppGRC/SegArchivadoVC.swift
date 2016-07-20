//
//  SegArchivadoVC.swift
//  AppGRC
//
//  Created by Crisoper on 19/07/16.
//  Copyright © 2016 Crisoper. All rights reserved.
//

import UIKit

class SegArchivadoVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        //Boton cerrar a la derecha
        let btnRegresar = UIBarButtonItem(title: "Cerrar", style: UIBarButtonItemStyle.Plain, target: self, action: #selector(SegArchivadoVC.botonRegresar(_:)))
        self.navigationItem.rightBarButtonItem = btnRegresar
        
        //
        
        if let result = self.convertStringToDictionary(ClassDatosMAD.sharedDatosMAD.seguimiento) {
            //print(result)
            
            //Estableciendo título
            switch result["tipooperacion"]! as! String {
            case "1":
                self.title = "\(result["nrofila"]!) - Recepcionado"
                
            case "2":
                self.title = "\(result["nrofila"]!) - Derivado"
                
            case "3":
                self.title = "\(result["nrofila"]!) - Archivado"
                
            case "4":
                self.title = "\(result["nrofila"]!) - Adjunto"
                
            default:
                self.title = ""
            }

        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    //Cerrar vista
    func botonRegresar (barButtonItem: UIBarButtonItem) {
        //print("Cerrando ventana")
        //navigationController?.popViewControllerAnimated(true)
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    
    //Convertir un String a Json
    func convertStringToDictionary(text: String) -> [String:AnyObject]? {
        if let data = text.dataUsingEncoding(NSUTF8StringEncoding) {
            do {
                return try NSJSONSerialization.JSONObjectWithData(data, options: []) as? [String:AnyObject]
            } catch let error as NSError {
                print(error)
            }
        }
        return nil
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
