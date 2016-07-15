//
//  MadViewController.swift
//  AppGRC
//
//  Created by Crisoper on 12/06/16.
//  Copyright © 2016 Crisoper. All rights reserved.
//

import UIKit

class MadViewController: UIViewController, UITextFieldDelegate, NSXMLParserDelegate {
    
    //NSURLConnectionDelegate, NSXMLParserDelegate
    //Iniciamos variables globales
    
    let myConstants = MyClassConstants()
    
//    var mutableData:NSMutableData  = NSMutableData()
//    var currentElementName:NSString = ""
    
    //Mensaje
    //let alert = UIAlertController(title: nil, message: "Espere por favor...", preferredStyle: .Alert)
    
    
    @IBOutlet weak var viewFondo: UIView!
    @IBOutlet weak var myScrollView: UIScrollView!
    
    @IBOutlet weak var myLabel: UILabel!
    @IBOutlet weak var myTextField: UITextField!
    @IBOutlet weak var btnBuscarMad: UIButton!
    @IBOutlet weak var myActivityIndicator: UIActivityIndicatorView!
    
    
    
    
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

        //Set title
        
        self.myActivityIndicator.stopAnimating()
        
        self.title = " MAD"
        self.viewFondo.backgroundColor = myConstants.colorFondo2
        self.myScrollView.backgroundColor = myConstants.colorFondo2
        
        //Ajustamos tamaño del Label
        self.myLabel.numberOfLines = 0
        
        //Delegate de TextField
        self.myTextField.delegate = self
        
        
        self.btnBuscarMad.backgroundColor = myConstants.colorIconos
        self.btnBuscarMad.layer.cornerRadius = 5
        
        
        //Creamos el boton
        /*
        button.setTitle("Buscar", forState: UIControlState.Normal)
        button.setTitleColor(UIColor.blackColor(), forState: UIControlState.Normal)
        button.frame = CGRectMake(0, 163, 102, 53)
        button.backgroundColor = UIColor.yellowColor()
        button.adjustsImageWhenHighlighted = false
        button.addTarget(self, action: #selector(MadViewController.BuscarMAD), forControlEvents: UIControlEvents.TouchUpInside)
        */
        //Funcion para ocultar el teclado
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(MadViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
        
        //Seteamos el foco
        self.myTextField.becomeFirstResponder()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    //Mostrar mensaje de cargando
    /*
    func mostrarActivity(){
        
        //self.tableView.allowsSelection = false
        
        alert.view.tintColor = UIColor.blackColor()
        let loadingIndicator: UIActivityIndicatorView = UIActivityIndicatorView(frame: CGRectMake(10, 5, 50, 50)) as UIActivityIndicatorView
        loadingIndicator.hidesWhenStopped = true
        loadingIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.Gray
        loadingIndicator.startAnimating();
        
        alert.view.addSubview(loadingIndicator)
        presentViewController(alert, animated: true, completion: nil)
    }
     */
    
    //Ocultar Mensaje de cargando
    /*
    func ocultarActivity() {
        self.alert.dismissViewControllerAnimated(false, completion: nil)
        //self.view.endEditing(true)
        //self.tableView.allowsSelection = true
        
        
        
    }
     */
    
    
    
    func dismissKeyboard () {
        self.view.endEditing(true)
    }
    
    @IBAction func BuscarExpedienteMAD(sender: AnyObject) {
        
        //Ocultamos teclado
        dismissKeyboard()
        
        //Validamos si existe conexion de red
        if !VerificaConexion.isConnectedToNetwork() {
            self.showMessageAlert("No existe conexión de red")
            return
        }
        
        
        if ((myTextField.text?.isEmpty) == nil) {
            return
        }
        else{
            self.BuscarMAD()
        }
    }
    
    
    
    
    //Funcion Buscar MAD
    func BuscarMAD() {
        
        //Mostramos mensaje buscando ...
        //self.mostrarActivity()
        self.myActivityIndicator.startAnimating()
        
        //Obtenemos objeto requesto en formato soap
        let obrDocumento = self.createObj_Request(self.myTextField.text!, tipoExpediente: "D")
        
        let session = NSURLSession.sharedSession()
        let task = session.dataTaskWithRequest(obrDocumento, completionHandler: {data, response, error -> Void in
            
            //dispatch_async
            dispatch_async(dispatch_get_main_queue()) { () -> Void in

                if error != nil {
                    
                    //Mostramos error
                    self.myActivityIndicator.stopAnimating()
                    self.showMessageAlert((error?.localizedDescription)!)
                    return
                    
                }
                else {
                    
                    
                    //Empezamos a traer datos del Seguimiento
                    let obrSeguimiento = self.createObj_Request(self.myTextField.text!, tipoExpediente: "S")
                    
                    let taskSeguimiento = session.dataTaskWithRequest(obrSeguimiento, completionHandler: { (dataSeguimiento, responseSeguimiento, errorSeguimiento) in
                        
                        //Dispacth Seguimiento
                        dispatch_async(dispatch_get_main_queue()) { () -> Void in
                            
                            if errorSeguimiento != nil {
                                
                                //Mostramos error
                                self.myActivityIndicator.stopAnimating()
                                self.showMessageAlert((errorSeguimiento?.localizedDescription)!)
                                return
                                
                            }
                            else {
                                
                                
                                //Empezamos a traer datos de Adjuntos
                                let obrAdjunto = self.createObj_Request(self.myTextField.text!, tipoExpediente: "A")
                                
                                let taskAdjunto = session.dataTaskWithRequest(obrAdjunto, completionHandler: { (dataAdjunto, responseAdjunto, errorAdjunto) in
                                    
                                    //Dispacth Adjunto
                                    dispatch_async(dispatch_get_main_queue()) { () -> Void in
                                        
                                        
                                        if errorAdjunto != nil {
                                            
                                            //Mostramos error
                                            self.myActivityIndicator.stopAnimating()
                                            self.showMessageAlert((errorAdjunto?.localizedDescription)!)
                                            return
                                            
                                        }
                                        else {
                                            
                                            
                                            //Empezamos a traer datos de Relacionados
                                            let obrRelacionado = self.createObj_Request(self.myTextField.text!, tipoExpediente: "R")
                                            
                                            let taskRelacionado = session.dataTaskWithRequest(obrRelacionado, completionHandler: { (dataRelacionado, responseRelacionado, errorRelacionado) in
                                                
                                                
                                                //Dispacth Relacionado
                                                dispatch_async(dispatch_get_main_queue()) { () -> Void in
                                                
                                                    if errorRelacionado != nil {
                                                        
                                                        //Mostramos error
                                                        self.myActivityIndicator.stopAnimating()
                                                        self.showMessageAlert((errorRelacionado?.localizedDescription)!)
                                                        return
                                                        
                                                    }
                                                    else {
                                                        
                                                        //Empezamos a parsear el xml, una vez traidos todos los datos
                                                        self.beginParsing(data!)

                                                        //Almacenamos cadenas obtenidas
                                                        
                                                        //Almacenamos la cadena obtenida
                                                        if let strDatos = NSString(data: data!, encoding: NSUTF8StringEncoding) {
                                                            ClassDatosMAD.sharedDatosMAD.datos = strDatos as String
                                                        }
                                                        if let strSeguimieto = NSString(data: dataSeguimiento!, encoding: NSUTF8StringEncoding) {
                                                            ClassDatosMAD.sharedDatosMAD.seguimiento = strSeguimieto as String
                                                        }
                                                        if let strAdjunto = NSString(data: dataAdjunto!, encoding: NSUTF8StringEncoding) {
                                                            
                                                            //print(strAdjunto)
                                                            ClassDatosMAD.sharedDatosMAD.adjunto = strAdjunto as String
                                                        }
                                                        if let strRelacionado = NSString(data: dataRelacionado!, encoding: NSUTF8StringEncoding) {
                                                            
                                                            //print(strRelacionado)
                                                            
                                                            ClassDatosMAD.sharedDatosMAD.relacionado = strRelacionado as String
                                                        }
                                                        
                                                    }
                                                }//Fin Dispacth Relacionado
                                                
                                            })
                                            taskRelacionado.resume()
                                            
                                            
                                            
                                        }
                                        
                                    } //Fin Dispacth Adjunto
                                    
                                })
                                taskAdjunto.resume()
                            
                            }
                            
                        }//Fin dispatch Seguimiento
                        
                    })
                    taskSeguimiento.resume()
                    
                
                }
                
            } //dispatch_async
            
        })
        task.resume()
        
        
    }
    
    
    //Funciona para crear el object request soap
    func createObj_Request(nroMAD:String, tipoExpediente:String) -> NSMutableURLRequest {
        
        let soapMessage = String("<?xml version=\"1.0\" encoding=\"utf-8\"?><soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\"><soap:Body><MadGetSeguimiento xmlns=\"RegionCajamarcaANDROIDServicios\"><numeromad>\(nroMAD)</numeromad><tipo>\(tipoExpediente)</tipo></MadGetSeguimiento></soap:Body></soap:Envelope>")
        
        let is_URL: String = "http://sar.regioncajamarca.gob.pe/App_Servicios/androidservicios.asmx"
        //let session = NSURLSession.sharedSession()
        let lobj_Request = NSMutableURLRequest(URL: NSURL(string: is_URL)!)
        lobj_Request.HTTPMethod = "POST"
        lobj_Request.HTTPBody = soapMessage.dataUsingEncoding(NSUTF8StringEncoding)
        lobj_Request.addValue("sar.regioncajamarca.gob.pe", forHTTPHeaderField: "Host")
        lobj_Request.addValue("text/xml; charset=utf-8", forHTTPHeaderField: "Content-Type")
        lobj_Request.addValue(String(soapMessage.characters.count), forHTTPHeaderField: "Content-Length")
        lobj_Request.addValue("RegionCajamarcaANDROIDServicios/MadGetSeguimiento", forHTTPHeaderField: "SOAPAction")
        
        return lobj_Request
    
    }
    
    
    
    
    //Alertas
    func showMessageAlert(userMessage:String) {
        let alertController = UIAlertController(title: "GRCMóvil", message: userMessage, preferredStyle: UIAlertControllerStyle.Alert)
        alertController.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default,handler: nil))
        self.presentViewController(alertController, animated: true, completion: nil)
    }
    
    
    
    
    //Cuando aparece el teclado
    func textFieldDidBeginEditing(textField: UITextField) {
        
        //Mostramos botón
        //NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(MadViewController.keyboardWillShow(_:)), name: UIKeyboardWillShowNotification, object: nil)
        
    }
    
    
    //Sobreescribimos el teclado
    /*
    func keyboardWillShow(note : NSNotification) -> Void{
        
        //print("Entramos en esta seccion")
        
        dispatch_async(dispatch_get_main_queue()) { () -> Void in
            self.button.hidden = false
            let keyBoardWindow = UIApplication.sharedApplication().windows.last
            self.button.frame = CGRectMake(0, (keyBoardWindow?.frame.size.height)!-53, 106, 53)
            keyBoardWindow?.addSubview(self.button)
            keyBoardWindow?.bringSubviewToFront(self.button)
            UIView.animateWithDuration(((note.userInfo! as NSDictionary).objectForKey(UIKeyboardAnimationCurveUserInfoKey)?.doubleValue)!, delay: 0, options: UIViewAnimationOptions.CurveEaseIn, animations: { () -> Void in
                self.view.frame = CGRectOffset(self.view.frame, 0, 0)
                }, completion: { (complete) -> Void in
                    //print("Complete")
            })
        }
    }
     */
    
    
    
    func beginParsing(contentString:NSData)
    {
        self.posts = []
        self.parser = NSXMLParser(data: contentString)
        self.parser.delegate = self
        self.parser.parse()
        
        //print(posts.count)
        
        if self.posts.count == 1 {
            
            
            ClassDatosMAD.sharedDatosMAD.idMadReferencia = self.myTextField.text!
            self.myTextField.text = ""
            self.myActivityIndicator.stopAnimating()
            
            
            
            
            
            let storyboard:UIStoryboard = UIStoryboard(name: "Mad", bundle: nil)
            let controlador:TabsViewController  = storyboard.instantiateViewControllerWithIdentifier("SeguimientoMadID") as! TabsViewController
            self.showViewController(controlador, sender: self)
        }
        else {
            
            self.myActivityIndicator.stopAnimating()
            self.showMessageAlert("No se ha encontrado el expediente con N° MAD \(self.myTextField.text!)")
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
    
    
    
    /* Crear string a partir de un NSData con formato utf8
     if let strData = NSString(data: data!, encoding: NSUTF8StringEncoding) {
     
     print("Body: \(strData)")
     
     //Navegamos
     let storyboard:UIStoryboard = UIStoryboard(name: "Mad", bundle: nil)
     let controlador:TabsViewController  = storyboard.instantiateViewControllerWithIdentifier("SeguimientoMadID") as! TabsViewController
     self.showViewController(controlador, sender: self)
     
     }
     else {
     
     //self.ocultarActivity()
     self.myActivityIndicator.stopAnimating()
     
     }
     */
    

}