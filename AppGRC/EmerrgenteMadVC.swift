//
//  EmerrgenteMadVC.swift
//  AppGRC
//
//  Created by Crisoper on 9/07/16.
//  Copyright © 2016 Crisoper. All rights reserved.
//

import UIKit

class EmerrgenteMadVC: UIViewController, NSXMLParserDelegate {
    
    //Para mostrar emergente
    let alert = UIAlertController(title: nil, message: "Espere por favor...", preferredStyle: .Alert)
    
    //Outlets
    @IBOutlet weak var lblExpediente: UILabel!
    @IBOutlet weak var lblDocumento: UILabel!
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
        
        
        //Boton cerrar a la derecha
        let btnRegresar = UIBarButtonItem(title: "Cerrar", style: UIBarButtonItemStyle.Plain, target: self, action: #selector(EmerrgenteMadVC.botonRegresar(_:)))
        self.navigationItem.rightBarButtonItem = btnRegresar
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    override func viewDidAppear(animated: Bool) {
        self.title = "Expediente \(ClassDatosMAD.sharedDatosMAD.idMadReferencia)"
        //self.lblExpediente.text = "EXPEDIENTE N° \(ClassDatosMAD.sharedDatosMAD.idMadReferencia)"
        
        //print(ClassDatosMAD.sharedDatosMAD.seguimiento)
        
        self.mostrarActivity()
        
        self.buscarExpediente()
        
    }
    
    
    //Mostrar mensaje de cargando
    func mostrarActivity(){
        
        alert.view.tintColor = UIColor.blackColor()
        let loadingIndicator: UIActivityIndicatorView = UIActivityIndicatorView(frame: CGRectMake(10, 5, 50, 50)) as UIActivityIndicatorView
        loadingIndicator.hidesWhenStopped = true
        loadingIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.Gray
        loadingIndicator.startAnimating();
        
        alert.view.addSubview(loadingIndicator)
        presentViewController(alert, animated: true, completion: nil)
    }
    
    //Ocultar Mensaje de cargando
    func ocultarActivity() {
        self.alert.dismissViewControllerAnimated(false, completion: nil)
        //self.view.endEditing(true)
        
        
    }
    
    //Funcion buscar expediente
    func buscarExpediente() -> Void {
        
        //Mostramos mensaje de cargando datos
        
        let is_SoapMessMAD = String("<?xml version=\"1.0\" encoding=\"utf-8\"?><soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\"><soap:Body><MadGetSeguimiento xmlns=\"RegionCajamarcaANDROIDServicios\"><numeromad>\(ClassDatosMAD.sharedDatosMAD.idMadReferencia)</numeromad><tipo>D</tipo></MadGetSeguimiento></soap:Body></soap:Envelope>")
        
        
        let is_URL: String = "http://sar.regioncajamarca.gob.pe/App_Servicios/androidservicios.asmx"
        let session = NSURLSession.sharedSession()
        let lobj_Request = NSMutableURLRequest(URL: NSURL(string: is_URL)!)
        lobj_Request.HTTPMethod = "POST"
        lobj_Request.HTTPBody = is_SoapMessMAD.dataUsingEncoding(NSUTF8StringEncoding)
        lobj_Request.addValue("sar.regioncajamarca.gob.pe", forHTTPHeaderField: "Host")
        lobj_Request.addValue("text/xml; charset=utf-8", forHTTPHeaderField: "Content-Type")
        lobj_Request.addValue(String(is_SoapMessMAD.characters.count), forHTTPHeaderField: "Content-Length")
        lobj_Request.addValue("RegionCajamarcaANDROIDServicios/MadGetSeguimiento", forHTTPHeaderField: "SOAPAction")
        
        let task = session.dataTaskWithRequest(lobj_Request, completionHandler: {data, response, error -> Void in
            
            //dispatch_async
            dispatch_async(dispatch_get_main_queue()) { () -> Void in
                
                if error != nil {
                    //self.ocultarActivity()
                    return
                    
                }
                else {
                    self.beginParsing(data!)
                }
                
            } //dispatch_async
            
        })
        task.resume()
    }
    
    
    
    //Cerrar vista
    func botonRegresar (barButtonItem: UIBarButtonItem) {
        //print("Cerrando ventana")
        //navigationController?.popViewControllerAnimated(true)
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    
    //Parseamos el resultado obtenido
    
    func beginParsing(contentString:NSData)
    {
        self.posts = []
        self.parser = NSXMLParser(data: contentString)
        self.parser.delegate = self
        self.parser.parse()
        
        if self.posts.count == 1 {
            
            for post in self.posts {
            
                self.lblAsunto.text = post.objectForKey("asunto") as? String
                self.lblFirma.text = post.objectForKey("firma") as? String
                self.lblUOrganica.text = post.objectForKey("provienede") as? String
                let aatext = post.objectForKey("expedienteid") as? String
                self.lblExpediente.text = "EXPEDIENTE N° \(aatext!)"
                self.lblDocumento.text = post.objectForKey("documento") as? String
                
                if let treferencia = post.objectForKey("referencia") as? String where treferencia != ""  {
                    self.lblReferencia.text = treferencia
                }
                else {
                    self.lblReferencia.text = " - "
                }
                
                self.lblFecha.text = post.objectForKey("fechaexpediente") as? String
                self.lblCargo.text = post.objectForKey("cargo") as? String
                self.lblFolios.text = post.objectForKey("folios") as? String
                
            }
            
        }
        
        //Ocultamos mensaje de cargando datos
        self.ocultarActivity()
        
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
    
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
