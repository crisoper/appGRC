//
//  SegArchivadoVC.swift
//  AppGRC
//
//  Created by Crisoper on 19/07/16.
//  Copyright © 2016 Crisoper. All rights reserved.
//

import UIKit

class SegArchivadoVC: UIViewController {
    
    let myConstants = MyClassConstants()
    
    //OUTLETS
    @IBOutlet weak var lblForma: UILabel!
    @IBOutlet weak var lblPor: UILabel!
    @IBOutlet weak var lblDependenciaOrigen: UILabel!
    @IBOutlet weak var lblUnidadOrganica: UILabel!
    @IBOutlet weak var lblUsuario: UILabel!
    @IBOutlet weak var lblEn: UILabel!
    @IBOutlet weak var lblMotivo: UILabel!
    @IBOutlet weak var lblFecha: UILabel!
    
    @IBOutlet weak var myScrollView: UIScrollView!
    @IBOutlet weak var myView: UIView!
    
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.myView.backgroundColor = myConstants.colorFondo2
        self.myScrollView.backgroundColor = myConstants.colorFondo2
        
        //Boton cerrar a la derecha
        let btnRegresar = UIBarButtonItem(title: "Cerrar", style: UIBarButtonItemStyle.Plain, target: self, action: #selector(SegArchivadoVC.botonRegresar(_:)))
        self.navigationItem.rightBarButtonItem = btnRegresar
        
        //
        
        if let result = self.convertStringToDictionary(ClassDatosMAD.sharedDatosMAD.seguimiento) {
            //print(result)
            
            self.title = "\(result["nrofila"]!) - Archivado"
            self.lblForma.text = "\(result["forma"]!)"
            self.lblPor.text = "\(result["dependencia"]!) - \(result["oficinaorigensiglas"]!) - \(result["usuarioorigen"]!)"
            
            self.lblDependenciaOrigen.text = "\(result["dependenciafull"]!)"
            self.lblUnidadOrganica.text = "\(result["oficinaorigen"]!)"
            self.lblUsuario.text = "\(result["usuarioorigenfull"]!)"
            self.lblEn.text = result["operacion"]! as? String
            self.lblMotivo.text = result["destinoproveido"]! as? String
            
            let fechaoriginal = "\(result["fecha"]!)"
            
            self.lblFecha.text = String2DateFormat.String2DateFormatSpanish(fechaoriginal.substringToIndex(fechaoriginal.startIndex.advancedBy(10)))
            

        }
        else {
            //Cerramos la vista
            self.botonRegresar(btnRegresar)
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
