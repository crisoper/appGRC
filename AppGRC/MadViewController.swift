//
//  MadViewController.swift
//  AppGRC
//
//  Created by Crisoper on 12/06/16.
//  Copyright © 2016 Crisoper. All rights reserved.
//

import UIKit

class MadViewController: UIViewController, UITextFieldDelegate {
    
    //NSURLConnectionDelegate, NSXMLParserDelegate
    //Iniciamos variables globales
    
    let myConstants = MyClassConstants()
    
//    var mutableData:NSMutableData  = NSMutableData()
//    var currentElementName:NSString = ""
    
    //Mensaje
    let alert = UIAlertController(title: nil, message: "Espere por favor...", preferredStyle: .Alert)
    
    
    @IBOutlet weak var viewFondo: UIView!
    @IBOutlet weak var myScrollView: UIScrollView!
    
    @IBOutlet weak var myLabel: UILabel!
    @IBOutlet weak var myTextField: UITextField!
    
    //Declaramos un button
    let button = UIButton(type: UIButtonType.Custom)
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //Set title
        self.title = " Trámite documentario"
        self.viewFondo.backgroundColor = myConstants.colorFondo2
        self.myScrollView.backgroundColor = myConstants.colorFondo2
        
        //Ajustamos tamaño del Label
        self.myLabel.numberOfLines = 0
        
        //Delegate de TextField
        self.myTextField.delegate = self
        
        //Creamos el boton
        button.setTitle("Buscar", forState: UIControlState.Normal)
        button.setTitleColor(UIColor.blackColor(), forState: UIControlState.Normal)
        button.frame = CGRectMake(0, 163, 102, 53)
        button.backgroundColor = UIColor.yellowColor()
        button.adjustsImageWhenHighlighted = false
        button.addTarget(self, action: #selector(MadViewController.BuscarMAD), forControlEvents: UIControlEvents.TouchUpInside)
        
        //Funcion para ocultar el teclado
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(MadViewController.BuscarMAD))
        view.addGestureRecognizer(tap)
        
        //Seteamos el foco
        self.myTextField.becomeFirstResponder()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    //Funcion Buscar MAD
    func BuscarMAD() {
        
        //Si no existe red, retornamos
        if !VerificaConexion.isConnectedToNetwork() {
            //self.tableView.reloadData()
            self.showMessageAlert("No existe conexión de red")
            return
        }
        
        //Ocultamos el botón
        self.button.hidden = true
        //Ocultamos el teclado
        view.endEditing(true)
        
        //print(myTextField.text)
        
        
        
        let is_SoapMessMAD = String("<?xml version=\"1.0\" encoding=\"utf-8\"?><soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\"><soap:Body><MadGetSeguimiento xmlns=\"RegionCajamarcaANDROIDServicios\"><numeromad>\(self.myTextField.text!)</numeromad><tipo>T</tipo></MadGetSeguimiento></soap:Body></soap:Envelope>")
 
        self.myTextField.text = ""
        
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
            
            if let strData = NSString(data: data!, encoding: NSUTF8StringEncoding) {
                
                //Navegamos a la pestaña de datos, seguimiento, relacionado y adjunto
                
                dispatch_async(dispatch_get_main_queue()) { () -> Void in
                    let storyboard:UIStoryboard = UIStoryboard(name: "Mad", bundle: nil)
                    let controller:TabsViewController  = storyboard.instantiateViewControllerWithIdentifier("SeguimientoMadID") as! TabsViewController
                    self.showViewController(controller, sender: self)
                    
                    //self.performSegueWithIdentifier("showtabsMad", sender: self)
                    
                    print("Body: \(strData)")
                }
                
                
                
            }
            
            
            if error != nil
            {
                print("Error: " + error!.description)
            }
            
        })
        task.resume()
        
        
    }
    
    
//    
//    func connection(connection: NSURLConnection!, didReceiveResponse response: NSURLResponse!) {
//        mutableData.length = 0;
//    }
//    
//    func connection(connection: NSURLConnection!, didReceiveData data: NSData!) {
//        mutableData.appendData(data)
//    }
//    
//    func connectionDidFinishLoading(connection: NSURLConnection!) {
//        _ = NSString(data: mutableData, encoding: NSUTF8StringEncoding)
//        
//        let xmlParser = NSXMLParser(data: mutableData)
//        xmlParser.delegate = self
//        xmlParser.parse()
//        xmlParser.shouldResolveExternalEntities = true
//    }
//    
//    
//
//    func parser(parser: NSXMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String]) {
//        currentElementName = elementName
//    }
//    
//    
//    func parser(parser: NSXMLParser, foundCharacters string: String) {
//        if currentElementName == "CelsiusToFahrenheitResult" {
//            print(string)
//        }
//    }
    
    
    //Alertas
    func showMessageAlert(userMessage:String) {
        let alertController = UIAlertController(title: "GRC Movil", message: userMessage, preferredStyle: UIAlertControllerStyle.Alert)
        alertController.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default,handler: nil))
        self.presentViewController(alertController, animated: true, completion: nil)
    }
    
    
    
    
    //Cuando aparece el teclado
    func textFieldDidBeginEditing(textField: UITextField) {
        //print("Estamos Acáaaaaasasdasdasdsa")
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(MadViewController.keyboardWillShow(_:)), name: UIKeyboardWillShowNotification, object: nil)
    }
    
    
    //Sobreescribimos el teclado
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
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
//    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
//        // Get the new view controller using segue.destinationViewController.
//        // Pass the selected object to the new view controller.
//
//    }
    

}
