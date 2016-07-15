//
//  FirstTabViewController.swift
//  AppGRC
//
//  Created by Crisoper on 7/07/16.
//  Copyright © 2016 Crisoper. All rights reserved.
//

import UIKit

class FirstTabViewController: UIViewController, UIPopoverPresentationControllerDelegate, NSXMLParserDelegate {
    
    //Colores globales
    let myConstants = MyClassConstants()
    
    //Outlets
    @IBOutlet weak var btnDetail: UIButton!
    @IBOutlet weak var lblExpediente: UILabel!
    @IBOutlet weak var lblTitulo: UILabel!
    @IBOutlet weak var lblFecha: UILabel!
    @IBOutlet weak var lblReferencia: UILabel!
    @IBOutlet weak var lblFolios: UILabel!
    @IBOutlet weak var lblUOrganica: UILabel!
    @IBOutlet weak var lblFirma: UILabel!
    @IBOutlet weak var lblCargo: UILabel!
    @IBOutlet weak var lblAsunto: UILabel!
    
    
    //Variables para parsear XML
    var parser = NSXMLParser()
    var posts = NSMutableArray()
    var elements = NSMutableDictionary()
    var element = NSString()
    
    //Variables del expediente
    var expedienteid = NSMutableString()
    var documento = NSMutableString()
    var fechaexpediente = NSMutableString()
    var referencia = NSMutableString()
    var folios = NSMutableString()
    var provienede = NSMutableString()
    var firma = NSMutableString()
    var cargo = NSMutableString()
    var asunto = NSMutableString()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = myConstants.colorFondo2
        
        self.btnDetail.tintColor = myConstants.colorIconos
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        //print(ClassDatosMAD.sharedDatosMAD.datos)
        
        //let nsdata:NSData =
        
        self.beginParsing(ClassDatosMAD.sharedDatosMAD.datos.dataUsingEncoding(NSUTF8StringEncoding)!)
        
        
        //print(ClassDatosMAD.sharedDatosMAD.datos)
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        
        
        //print("First VC will disappear")
    }
    
    
    @IBAction func MostrarMadReferencia(sender: AnyObject) {
        
        
        ClassDatosMAD.sharedDatosMAD.idMadReferencia = self.lblReferencia.text!
        
//        
        let popoverContent:EmerrgenteMadVC = (self.storyboard?.instantiateViewControllerWithIdentifier("EmerrgenteMadVCID"))! as! EmerrgenteMadVC
        let nav = UINavigationController(rootViewController: popoverContent)
        nav.modalPresentationStyle = UIModalPresentationStyle.Popover
//        let popover = nav.popoverPresentationController
//        //popoverContent.preferredContentSize = CGSizeMake(500,600)
//        popover!.delegate = self
//        popover!.sourceView = self.view
        //popover!.sourceRect = CGRectMake(100,100,0,0)
        
        self.presentViewController(nav, animated: false, completion: nil)
        
//        let storyboard:UIStoryboard = UIStoryboard(name: "Mad", bundle: nil)
//        let controlador:EmerrgenteMadVC  = storyboard.instantiateViewControllerWithIdentifier("EmerrgenteMadVCID") as! EmerrgenteMadVC
//        self.showViewController(controlador, sender: self)
        
        //
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
    
    
    func beginParsing(contentString:NSData)
    {
        posts = []
                
        self.parser = NSXMLParser(data: contentString)
        
        
        
        
        self.parser.delegate = self
        self.parser.parse()
        
        
        //Iniciamos a setear cada elemento
        //self.lblAsunto.text = posts.valueForKey("asunto") as! String
        
        for post in posts {
            
            //print(post.objectForKey("asunto")!)
            
            self.lblAsunto.text = post.objectForKey("asunto") as? String
            self.lblFirma.text = post.objectForKey("firma") as? String
            self.lblUOrganica.text = post.objectForKey("provienede") as? String
            let aatext = post.objectForKey("expedienteid") as? String
            self.lblExpediente.text = "EXPEDIENTE N° \(aatext!)"
            self.lblTitulo.text = post.objectForKey("documento") as? String
            
            if let treferencia = post.objectForKey("referencia") as? String where (treferencia != "" &&  treferencia != "0" )  {
                self.lblReferencia.text = treferencia
            }
            else {
                self.lblReferencia.text = " - "
                self.btnDetail.hidden = true
            }
            
            self.lblFecha.text = post.objectForKey("fechaexpediente") as? String
            self.lblCargo.text = post.objectForKey("cargo") as? String
            self.lblFolios.text = post.objectForKey("folios") as? String
            
        }
        
    }
    
    
    
    //XMLParser Methods
    
    func parser(parser: NSXMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String])
    {
        element = elementName
        if (elementName as NSString).isEqualToString("SeguimientoCab")
        {
            elements = NSMutableDictionary()
            elements = [:]
            
            expedienteid = NSMutableString()
            expedienteid = ""
            
            documento = NSMutableString()
            documento = ""
            
            fechaexpediente = NSMutableString()
            fechaexpediente = ""
            
            referencia = NSMutableString()
            referencia = ""
            
            folios = NSMutableString()
            folios = ""
            
            provienede = NSMutableString()
            provienede = ""
            
            firma = NSMutableString()
            firma = ""
            
            cargo = NSMutableString()
            cargo = ""
            
            asunto = NSMutableString()
            asunto = ""
            
        }
    }
    
    func parser(parser: NSXMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?)
    {
        if (elementName as NSString).isEqualToString("SeguimientoCab") {
            
            if !expedienteid.isEqual(nil) {
                elements.setObject(expedienteid, forKey: "expedienteid")
            }
            if !documento.isEqual(nil) {
                elements.setObject(documento, forKey: "documento")
            }
            
            if !fechaexpediente.isEqual(nil) {
                elements.setObject(fechaexpediente, forKey: "fechaexpediente")
            }
            
            if !referencia.isEqual(nil) {
                elements.setObject(referencia, forKey: "referencia")
            }
            
            if !folios.isEqual(nil) {
                elements.setObject(folios, forKey: "folios")
            }
            
            if !provienede.isEqual(nil) {
                elements.setObject(provienede, forKey: "provienede")
            }
            
            if !firma.isEqual(nil) {
                elements.setObject(firma, forKey: "firma")
            }
            
            if !cargo.isEqual(nil) {
                elements.setObject(cargo, forKey: "cargo")
            }
            
            if !asunto.isEqual(nil) {
                elements.setObject(asunto, forKey: "asunto")
            }
            
            posts.addObject(elements)
        }
    }
    
    
    func parser(parser: NSXMLParser, foundCharacters string: String)
    {
        if element.isEqualToString("expedienteid") {
            expedienteid.appendString(string)
            
        } else if element.isEqualToString("documento") {
            //print(string)
            documento.appendString(string)
        }
        else if element.isEqualToString("fechaexpediente") {
            fechaexpediente.appendString(string)
        }
        else if element.isEqualToString("referencia") {
            referencia.appendString(string)
        }
        else if element.isEqualToString("folios") {
            folios.appendString(string)
        }
        else if element.isEqualToString("provienede") {
            provienede.appendString(string)
        }
        else if element.isEqualToString("firma") {
            firma.appendString(string)
        }
        else if element.isEqualToString("cargo") {
            cargo.appendString(string)
        }
        else if element.isEqualToString("asunto") {
            asunto.appendString(string)
        }
    }
    
    
    
//    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
//        
//        if segue.identifier == "popupReferenciaMAD" {
//            if let destination = segue.destinationViewController as? EmerrgenteMadVC {
//                
//                destination.madIDReferencia = self.lblReferencia.text!
//                
//            }
//        }
//    }
    
    

}
