//
//  SegDerivadoVC.swift
//  AppGRC
//
//  Created by Crisoper on 20/07/16.
//  Copyright © 2016 Crisoper. All rights reserved.
//

import UIKit

class SegDerivadoVC: UIViewController {
    
    let myConstants = MyClassConstants()
    
    //OUTLETS
    @IBOutlet weak var lblForma: UILabel!
    @IBOutlet weak var lblDe: UILabel!
    @IBOutlet weak var lblDependencia: UILabel!
    @IBOutlet weak var lblUO: UILabel!
    @IBOutlet weak var lblUsuario: UILabel!
    @IBOutlet weak var lblA: UILabel!
    @IBOutlet weak var lblDependenciaA: UILabel!
    @IBOutlet weak var lblUOA: UILabel!
    @IBOutlet weak var lblUsuarioA: UILabel!
    @IBOutlet weak var lblMotivo: UILabel!
    @IBOutlet weak var lblFecha: UILabel!
        
    @IBOutlet weak var myScrollView: UIScrollView!
    @IBOutlet weak var myView: UIView!
    
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.myView.backgroundColor = myConstants.colorFondo2
        self.myScrollView.backgroundColor = myConstants.colorFondo2
        
        // Do any additional setup after loading the view.
        let btnRegresar = UIBarButtonItem(title: "Cerrar", style: UIBarButtonItemStyle.Plain, target: self, action: #selector(SegDerivadoVC.botonRegresar(_:)))
        self.navigationItem.rightBarButtonItem = btnRegresar
        
        //
        
        if let result = self.convertStringToDictionary(ClassDatosMAD.sharedDatosMAD.seguimiento) {
            
            //print(result)
            
            self.title = "\(result["nrofila"]!) - Derivado"
            self.lblForma.text = "\(result["forma"]!)"
            self.lblDe.text = "\(result["dependencia"]!) - \(result["oficinaorigensiglas"]!) - \(result["usuarioorigen"]!)"
            
            self.lblDependencia.text = "\(result["dependenciafull"]!)"
            self.lblUO.text = "\(result["oficinaorigen"]!)"
            self.lblUsuario.text = "\(result["usuarioorigenfull"]!)"
            
            self.lblA.text = "\(result["dependenciadestinosiglas"]!) - \(result["oficinadestinosiglas"]!) - \(result["usuariodestino"]!)"
            self.lblDependenciaA.text = "\(result["dependenciadestino"]!)"
            self.lblUOA.text = "\(result["oficinadestino"]!)"
            self.lblUsuarioA.text = "\(result["usuariodestinofull"]!)"
            
            self.lblMotivo.text = "\(result["destinoproveido"]!)"
            
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
