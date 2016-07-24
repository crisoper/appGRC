//
//  ProyectosTableVC.swift
//  AppGRC
//
//  Created by Crisoper on 21/07/16.
//  Copyright © 2016 Crisoper. All rights reserved.
//

import UIKit

class ProyectosTableVC: UITableViewController, UISearchBarDelegate, NSXMLParserDelegate {
    
    //Colores globales
    let myConstants = MyClassConstants()
    
    //Para mostrar emergente
    let alert = UIAlertController(title: nil, message: "Espere por favor...", preferredStyle: .Alert)
    
    //Outlets
    @IBOutlet weak var mySearchBar: UISearchBar!
    
    
    //Variables para parsear XML
    var parser = NSXMLParser()
    var posts = NSMutableArray()
    var elements = NSMutableDictionary()
    var element = NSString()
    
    //Variables del expediente
    var idProyecto = NSMutableString()
    var CodigoSNIP = NSMutableString()
    var CodigoInterno = NSMutableString()
    var NombreProyecto = NSMutableString()
    var MontoInversion = NSMutableString()
    var FechaCreacion = NSMutableString()
    var DocumentoProyecto = NSMutableString()
    var ObservacionesProyecto = NSMutableString()
    var Estado = NSMutableString()
    var NombresFormulador = NSMutableString()
    var TelefonosFormulador = NSMutableString()
    var EmailsFormulador = NSMutableString()
    var beneficiarios = NSMutableString()
    var DescripcionIntervencion = NSMutableString()
    var CodigoActividad = NSMutableString()
    var Formato15 = NSMutableString()
    var Formato14 = NSMutableString()
    var idUF = NSMutableString()
    var idUE = NSMutableString()
    var idProvincia = NSMutableString()
    var idNivelEstudio = NSMutableString()
    var idFuncion = NSMutableString()
    var NombreProvincia = NSMutableString()
    var NroDistritos = NSMutableString()
    var idControlOPI = NSMutableString()
    var FechaIngresoOPI = NSMutableString()
    var NroRegistroIngresoOPI = NSMutableString()
    var DocumentoIngresoOPI = NSMutableString()
    var FechaSalidaOPI = NSMutableString()
    var NroRegistroSalidaOPI = NSMutableString()
    var DocumentoSalidaOPI = NSMutableString()
    var FechaAsignacion = NSMutableString()
    var MemoAsignacion = NSMutableString()
    var DocumentoAsignacion = NSMutableString()
    var PlazoEstablecido = NSMutableString()
    var FechaDevolucionRecomendado = NSMutableString()
    var FechaDevolucion = NSMutableString()
    var CodigoInformeTecnico = NSMutableString()
    var DocumentoInformeTecnico = NSMutableString()
    var FechaViabilidad = NSMutableString()
    var DocumentoViabilidad = NSMutableString()
    var AsuntoDocumentoAsignacion = NSMutableString()
    var CuerpoDocumentoAsignacion = NSMutableString()
    var ObservacionesEvaluador = NSMutableString()
    var ComentariosEvaluador = NSMutableString()
    var idEvaluador = NSMutableString()
    var idEstadoEstudio = NSMutableString()
    var idEvaluacion = NSMutableString()
    var idSituacion = NSMutableString()
    var idjefeevaluadora = NSMutableString()
    var idestado_f16 = NSMutableString()
    var idestado_f15 = NSMutableString()
    var idestado_f17 = NSMutableString()
    var idestado_f14 = NSMutableString()
    var NombreUF = NSMutableString()
    var Prof_Responsable_UF = NSMutableString()
    var ResponsableUF = NSMutableString()
    var CargoUF = NSMutableString()
    var Direccion = NSMutableString()
    var TelefonoUF = NSMutableString()
    var EmailUF1 = NSMutableString()
    var CelularUF = NSMutableString()
    var NombreEstadoEstudio = NSMutableString()
    var NombreUE = NSMutableString()
    var ResponsableUE = NSMutableString()
    var CargoUE = NSMutableString()
    var TelefonoUE = NSMutableString()
    var EmailUE1 = NSMutableString()
    var CelularUE = NSMutableString()
    var estadoP = NSMutableString()
    var NombreNivelEstudio = NSMutableString()
    var PlazoEvaluacion = NSMutableString()
    var NombreFuncion = NSMutableString()
    var NombresEvaluador = NSMutableString()
    var ApellidosEvaluador = NSMutableString()
    var Profesion = NSMutableString()
    var Telefono1 = NSMutableString()
    var Celular = NSMutableString()
    var CorreoElectronico1 = NSMutableString()
    var CorreoElectronico2 = NSMutableString()
    var DNI = NSMutableString()
    var RUC = NSMutableString()
    var FechaNacimiento = NSMutableString()
    var Usuario = NSMutableString()
    var EstadoEvaluador = NSMutableString()
    var NombreEvaluacion = NSMutableString()
    var JefeEvaluadora = NSMutableString()
    var nombreImagenEstado = NSMutableString()
    
    

    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = myConstants.colorFondo2
        
        self.tableView.dataSource = self
        self.tableView.reloadData()
        
        self.title = "Proyectos"
        
        //let uisb = UISearchBar()
        
        self.mySearchBar.becomeFirstResponder()
        
        
        self.tableView.separatorStyle = UITableViewCellSeparatorStyle.None
        self.tableView.estimatedRowHeight = 244.0
        self.tableView.rowHeight = UITableViewAutomaticDimension
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    //Mostrar mensaje de cargando
    func mostrarActivity(){
        
        self.tableView.allowsSelection = false
        
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
        self.view.endEditing(true)
        self.tableView.allowsSelection = true
        
        
    }
    
    
    
    func searchBarShouldBeginEditing(searchBar: UISearchBar) -> Bool {
        self.tableView.allowsSelection = false
        return true
    }
    
    
    func searchBarTextDidEndEditing(searchBar: UISearchBar) {
        self.tableView.allowsSelection = true
    }
    
    
    //Boton Buscar
    func searchBarSearchButtonClicked(searchBar: UISearchBar) {
        
        //self.resultNoticias.removeAll()
        self.tableView.reloadData()
        
        if ((searchBar.text?.isEmpty) == nil) {
            print("El texto esta vacio o es nil")
        }
        else{
            //print(searchBar.text!)
            
            //Hacemos la busqueda de datos
            self.hacerBusqueda(searchBar.text!)
            
            //Ocultamos el teclado, no es necesario llamarlo pues lo hicimos en el viewDidLoad
            //self.dismissKeyboard()
        }
        
    }
    
    
    func searchBarCancelButtonClicked(searchBar: UISearchBar) {
        self.view.endEditing(true)
        searchBar.text = ""
        self.tableView.allowsSelection = true
    }
    
    func hacerBusqueda(descripcion:String) -> Void {
        
        //Si no existe red, retornamos
        if !VerificaConexion.isConnectedToNetwork() {
            self.tableView.reloadData()
            self.showMessageAlert("No existe conexión de red")
            return
        }
        
        self.mostrarActivity()
        
        /*
        POST /nusoap/seguimiento.php HTTP/1.0
        */
        
        
        //Consultamos data
        let obrProyectos = self.createObj_Request(descripcion)
        let session = NSURLSession.sharedSession()
        
        let taskProyectos = session.dataTaskWithRequest(obrProyectos, completionHandler: { (data:NSData?, response:NSURLResponse?, error:NSError?) in
            
            
            //Dispacth Relacionado
            dispatch_async(dispatch_get_main_queue()) { () -> Void in
                
                if error != nil {
                    
                    //Mostramos error
                    self.showMessageAlert((error?.localizedDescription)!)
                    return
                    
                }
                else {
                    
                    //Empezamos a parsear el xml, una vez traidos todos los datos
                    
                    
                    //Almacenamos la cadena obtenida
                    if let strProyectos = NSString(data: data!, encoding: NSISOLatin1StringEncoding) {
                        
                    
                        
                        self.ocultarActivity()
                        
                        let strData = strProyectos as String
                        let newString = strData.stringByReplacingOccurrencesOfString(" xsi:type=\"tns:Proyecto\"", withString: "").stringByReplacingOccurrencesOfString(" xsi:type=\"xsd:string\"", withString: "").stringByReplacingOccurrencesOfString(" xsi:nil=\"true\"", withString: "") as NSString
                        
                        //print(strData)
                        
                        let nsDataString = newString.dataUsingEncoding(NSISOLatin1StringEncoding, allowLossyConversion: true)
                        
                        ClassDatosMAD.sharedDatosMAD.relacionado = strProyectos as String
                        
                        //:Iniciamos a recorrer XML
                        self.beginParsing(nsDataString!)
                        
                    }
                    else {
                        self.ocultarActivity()
                        self.showMessageAlert("Se ha producido un error")
                    }
                    
                }
            }//Fin Dispacth
            
        })
        taskProyectos.resume()
        
        
        //self.searchBar.resignFirstResponder()
    }
    
    
    //Funciona para crear el object request soap
    func createObj_Request(txtbuscar:String) -> NSMutableURLRequest {
        
        let soapMessage = String("<?xml version='1.0'?><SOAP-ENV:Envelope xmlns:SOAP-ENV='http://schemas.xmlsoap.org/soap/envelope/' xmlns:SOAP-ENC='http://schemas.xmlsoap.org/soap/encoding/' xmlns:tns='urn:proyectospip' xmlns:wsdl='http://schemas.xmlsoap.org/wsdl/' xmlns:xsd='http://www.w3.org/2001/XMLSchema' xmlns:xsi='http://www.w3.org/2001/XMLSchema-instance'><SOAP-ENV:Body><ns1:listar SOAP-ENV:encodingStyle='http://schemas.xmlsoap.org/soap/encoding/' xmlns:ns1='urn:proyectospip'><buscar xsi:type='xsd:string'>\(txtbuscar)</buscar></ns1:listar></SOAP-ENV:Body></SOAP-ENV:Envelope>")
        
        let is_URL: String = "http://opi.regioncajamarca.gob.pe/nusoap/seguimientodatos.php"
        //let session = NSURLSession.sharedSession()
        let lobj_Request = NSMutableURLRequest(URL: NSURL(string: is_URL)!)
        lobj_Request.HTTPMethod = "POST"
        lobj_Request.HTTPBody = soapMessage.dataUsingEncoding(NSUTF8StringEncoding)
        lobj_Request.addValue("opi.regioncajamarca.gob.pe", forHTTPHeaderField: "Host")
        lobj_Request.addValue("text/xml; charset=ISO-8859-1", forHTTPHeaderField: "Content-Type")
        lobj_Request.addValue(String(soapMessage.characters.count), forHTTPHeaderField: "Content-Length")
        lobj_Request.addValue("urn:proyectospip#listar", forHTTPHeaderField: "SOAPAction")
        
        return lobj_Request
        
    }
    
    
    //Alertas
    func showMessageAlert(userMessage:String) {
        let alertController = UIAlertController(title: "GRC Movil", message: userMessage, preferredStyle: UIAlertControllerStyle.Alert)
        alertController.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default,handler: nil))
        
        self.presentViewController(alertController, animated: true, completion: nil)
    }
    
    
    
    
    

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return self.posts.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell:ProyectosTVCell = tableView.dequeueReusableCellWithIdentifier("cellProyecto", forIndexPath: indexPath) as! ProyectosTVCell
        
        //cell.textLabel?.text = sections[indexPath.section].items[indexPath.row]
        cell.backgroundColor = myConstants.colorFondo2
        
        //Desabilitar seleccion de la fila
        cell.selectionStyle = UITableViewCellSelectionStyle.None
        
        cell.lblNombre.text = "\(self.posts.objectAtIndex(indexPath.row).valueForKey("NombreProyecto") as! NSString as String)"
        cell.lblSNIP.text = "\(self.posts.objectAtIndex(indexPath.row).valueForKey("CodigoSNIP") as! NSString as String)"
        cell.lblMonto.text = "S/. \(self.posts.objectAtIndex(indexPath.row).valueForKey("MontoInversion") as! NSString as String)"
        cell.lblAnio.text = "\(self.posts.objectAtIndex(indexPath.row).valueForKey("FechaCreacion") as! NSString as String)"
        cell.myImage.image = UIImage(named: "boletas")
        cell.myImage.tintColor = myConstants.colorIconos
        cell.bntMas.tintColor = myConstants.colorIconos
        
        
        cell.tapAction = { (cell) in
            
//            let storyboard:UIStoryboard = UIStoryboard(name: "Proyectos", bundle: nil)
//            let controller:TabsProyectosVC  = storyboard.instantiateViewControllerWithIdentifier("MadVCID") as! TabsProyectosVC
//            self.showViewController(controller, sender: self)
            
            //self.showMessageAlert("Estamos en una celda")
            
            self.mostrarDetalleMovimientoSef()
        }
        
        

        // Configure the cell...

        return cell
    }
    
    func mostrarDetalleMovimientoSef() -> Void {
        
        let storyboard:UIStoryboard = UIStoryboard(name: "Proyectos", bundle: nil)
        let controlador:TabsProyectosVC  = storyboard.instantiateViewControllerWithIdentifier("TabsProyectosVCID") as! TabsProyectosVC
        self.showViewController(controlador, sender: self)
    
    }
 

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */
    
    
    
    func beginParsing(contentString:NSData)
    {
        self.posts = []
        self.parser = NSXMLParser(data: contentString)
        self.parser.delegate = self
        self.parser.parse()
        
        //print(posts)
        
        
        if self.posts.count >= 1 {
            
            print("Reload data", posts.count)
            self.tableView.separatorStyle = UITableViewCellSeparatorStyle.SingleLine
            self.tableView.reloadData()
            
        }
        else {
            
            //self.myActivityIndicator.stopAnimating()
            self.showMessageAlert("No se han encontrado resultados")
        }
        
        
    }
    
    
    
    
    
    //XMLParser Methods
    
    func parser(parser: NSXMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String])
    {
        element = elementName
        if (elementName as NSString).isEqualToString("item")
        {
            elements = NSMutableDictionary()
            elements = [:]
            
            idProyecto = NSMutableString()
            idProyecto = ""
            CodigoSNIP = NSMutableString()
            CodigoSNIP = ""
            CodigoInterno = NSMutableString()
            CodigoInterno = ""
            NombreProyecto = NSMutableString()
            NombreProyecto = ""
            MontoInversion = NSMutableString()
            MontoInversion = ""
            FechaCreacion = NSMutableString()
            FechaCreacion = ""
            DocumentoProyecto = NSMutableString()
            DocumentoProyecto = ""
            ObservacionesProyecto = NSMutableString()
            ObservacionesProyecto = ""
            Estado = NSMutableString()
            Estado = ""
            NombresFormulador = NSMutableString()
            NombresFormulador = ""
            TelefonosFormulador = NSMutableString()
            TelefonosFormulador = ""
            EmailsFormulador = NSMutableString()
            EmailsFormulador = ""
            beneficiarios = NSMutableString()
            beneficiarios = ""
            DescripcionIntervencion = NSMutableString()
            DescripcionIntervencion = ""
            CodigoActividad = NSMutableString()
            CodigoActividad = ""
            Formato15 = NSMutableString()
            Formato15 = ""
            Formato14 = NSMutableString()
            Formato14 = ""
            idUF = NSMutableString()
            idUF = ""
            idUE = NSMutableString()
            idUE = ""
            idProvincia = NSMutableString()
            idProvincia = ""
            idNivelEstudio = NSMutableString()
            idNivelEstudio = ""
            idFuncion = NSMutableString()
            idFuncion = ""
            NombreProvincia = NSMutableString()
            NombreProvincia = ""
            NroDistritos = NSMutableString()
            NroDistritos = ""
            idControlOPI = NSMutableString()
            idControlOPI = ""
            FechaIngresoOPI = NSMutableString()
            FechaIngresoOPI = ""
            NroRegistroIngresoOPI = NSMutableString()
            NroRegistroIngresoOPI = ""
            DocumentoIngresoOPI = NSMutableString()
            DocumentoIngresoOPI = ""
            FechaSalidaOPI = NSMutableString()
            FechaSalidaOPI = ""
            NroRegistroSalidaOPI = NSMutableString()
            NroRegistroSalidaOPI = ""
            DocumentoSalidaOPI = NSMutableString()
            DocumentoSalidaOPI = ""
            FechaAsignacion = NSMutableString()
            FechaAsignacion = ""
            MemoAsignacion = NSMutableString()
            MemoAsignacion = ""
            DocumentoAsignacion = NSMutableString()
            DocumentoAsignacion = ""
            PlazoEstablecido = NSMutableString()
            PlazoEstablecido = ""
            FechaDevolucionRecomendado = NSMutableString()
            FechaDevolucionRecomendado = ""
            FechaDevolucion = NSMutableString()
            FechaDevolucion = ""
            CodigoInformeTecnico = NSMutableString()
            CodigoInformeTecnico = ""
            DocumentoInformeTecnico = NSMutableString()
            DocumentoInformeTecnico = ""
            FechaViabilidad = NSMutableString()
            FechaViabilidad = ""
            DocumentoViabilidad = NSMutableString()
            DocumentoViabilidad = ""
            AsuntoDocumentoAsignacion = NSMutableString()
            AsuntoDocumentoAsignacion = ""
            CuerpoDocumentoAsignacion = NSMutableString()
            CuerpoDocumentoAsignacion = ""
            ObservacionesEvaluador = NSMutableString()
            ObservacionesEvaluador = ""
            ComentariosEvaluador = NSMutableString()
            ComentariosEvaluador = ""
            idEvaluador = NSMutableString()
            idEvaluador = ""
            idEstadoEstudio = NSMutableString()
            idEstadoEstudio = ""
            idEvaluacion = NSMutableString()
            idEvaluacion = ""
            idSituacion = NSMutableString()
            idSituacion = ""
            idjefeevaluadora = NSMutableString()
            idjefeevaluadora = ""
            idestado_f16 = NSMutableString()
            idestado_f16 = ""
            idestado_f15 = NSMutableString()
            idestado_f15 = ""
            idestado_f17 = NSMutableString()
            idestado_f17 = ""
            idestado_f14 = NSMutableString()
            idestado_f14 = ""
            NombreUF = NSMutableString()
            NombreUF = ""
            Prof_Responsable_UF = NSMutableString()
            Prof_Responsable_UF = ""
            ResponsableUF = NSMutableString()
            ResponsableUF = ""
            CargoUF = NSMutableString()
            CargoUF = ""
            Direccion = NSMutableString()
            Direccion = ""
            TelefonoUF = NSMutableString()
            TelefonoUF = ""
            EmailUF1 = NSMutableString()
            EmailUF1 = ""
            CelularUF = NSMutableString()
            CelularUF = ""
            NombreEstadoEstudio = NSMutableString()
            NombreEstadoEstudio = ""
            NombreUE = NSMutableString()
            NombreUE = ""
            ResponsableUE = NSMutableString()
            ResponsableUE = ""
            CargoUE = NSMutableString()
            CargoUE = ""
            TelefonoUE = NSMutableString()
            TelefonoUE = ""
            EmailUE1 = NSMutableString()
            EmailUE1 = ""
            CelularUE = NSMutableString()
            CelularUE = ""
            estadoP = NSMutableString()
            estadoP = ""
            NombreNivelEstudio = NSMutableString()
            NombreNivelEstudio = ""
            PlazoEvaluacion = NSMutableString()
            PlazoEvaluacion = ""
            NombreFuncion = NSMutableString()
            NombreFuncion = ""
            NombresEvaluador = NSMutableString()
            NombresEvaluador = ""
            ApellidosEvaluador = NSMutableString()
            ApellidosEvaluador = ""
            Profesion = NSMutableString()
            Profesion = ""
            Telefono1 = NSMutableString()
            Telefono1 = ""
            Celular = NSMutableString()
            Celular = ""
            CorreoElectronico1 = NSMutableString()
            CorreoElectronico1 = ""
            CorreoElectronico2 = NSMutableString()
            CorreoElectronico2 = ""
            DNI = NSMutableString()
            DNI = ""
            RUC = NSMutableString()
            RUC = ""
            FechaNacimiento = NSMutableString()
            FechaNacimiento = ""
            Usuario = NSMutableString()
            Usuario = ""
            EstadoEvaluador = NSMutableString()
            EstadoEvaluador = ""
            NombreEvaluacion = NSMutableString()
            NombreEvaluacion = ""
            JefeEvaluadora = NSMutableString()
            JefeEvaluadora = ""
            nombreImagenEstado = NSMutableString()
            nombreImagenEstado = ""
            
        }
    }
    
    func parser(parser: NSXMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?)
    {
        if (elementName as NSString).isEqualToString("item") {
            
            if !idProyecto.isEqual(nil) {
                elements.setObject(idProyecto, forKey: "idProyecto")
            }
            if !CodigoSNIP.isEqual(nil) {
                elements.setObject(CodigoSNIP, forKey: "CodigoSNIP")
            }
            if !CodigoInterno.isEqual(nil) {
                elements.setObject(CodigoInterno, forKey: "CodigoInterno")
            }
            if !NombreProyecto.isEqual(nil) {
                elements.setObject(NombreProyecto, forKey: "NombreProyecto")
            }
            if !MontoInversion.isEqual(nil) {
                elements.setObject(MontoInversion, forKey: "MontoInversion")
            }
            if !FechaCreacion.isEqual(nil) {
                elements.setObject(FechaCreacion, forKey: "FechaCreacion")
            }
            if !DocumentoProyecto.isEqual(nil) {
                elements.setObject(DocumentoProyecto, forKey: "DocumentoProyecto")
            }
            if !ObservacionesProyecto.isEqual(nil) {
                elements.setObject(ObservacionesProyecto, forKey: "ObservacionesProyecto")
            }
            if !Estado.isEqual(nil) {
                elements.setObject(Estado, forKey: "Estado")
            }
            if !NombresFormulador.isEqual(nil) {
                elements.setObject(NombresFormulador, forKey: "NombresFormulador")
            }
            if !TelefonosFormulador.isEqual(nil) {
                elements.setObject(TelefonosFormulador, forKey: "TelefonosFormulador")
            }
            if !EmailsFormulador.isEqual(nil) {
                elements.setObject(EmailsFormulador, forKey: "EmailsFormulador")
            }
            if !beneficiarios.isEqual(nil) {
                elements.setObject(beneficiarios, forKey: "beneficiarios")
            }
            if !DescripcionIntervencion.isEqual(nil) {
                elements.setObject(DescripcionIntervencion, forKey: "DescripcionIntervencion")
            }
            if !CodigoActividad.isEqual(nil) {
                elements.setObject(CodigoActividad, forKey: "CodigoActividad")
            }
            if !Formato15.isEqual(nil) {
                elements.setObject(Formato15, forKey: "Formato15")
            }
            if !Formato14.isEqual(nil) {
                elements.setObject(Formato14, forKey: "Formato14")
            }
            if !idUF.isEqual(nil) {
                elements.setObject(idUF, forKey: "idUF")
            }
            if !idUE.isEqual(nil) {
                elements.setObject(idUE, forKey: "idUE")
            }
            if !idProvincia.isEqual(nil) {
                elements.setObject(idProvincia, forKey: "idProvincia")
            }
            if !idNivelEstudio.isEqual(nil) {
                elements.setObject(idNivelEstudio, forKey: "idNivelEstudio")
            }
            if !idFuncion.isEqual(nil) {
                elements.setObject(idFuncion, forKey: "idFuncion")
            }
            if !NombreProvincia.isEqual(nil) {
                elements.setObject(NombreProvincia, forKey: "NombreProvincia")
            }
            if !NroDistritos.isEqual(nil) {
                elements.setObject(NroDistritos, forKey: "NroDistritos")
            }
            if !idControlOPI.isEqual(nil) {
                elements.setObject(idControlOPI, forKey: "idControlOPI")
            }
            if !FechaIngresoOPI.isEqual(nil) {
                elements.setObject(FechaIngresoOPI, forKey: "FechaIngresoOPI")
            }
            if !NroRegistroIngresoOPI.isEqual(nil) {
                elements.setObject(NroRegistroIngresoOPI, forKey: "NroRegistroIngresoOPI")
            }
            if !DocumentoIngresoOPI.isEqual(nil) {
                elements.setObject(DocumentoIngresoOPI, forKey: "DocumentoIngresoOPI")
            }
            if !FechaSalidaOPI.isEqual(nil) {
                elements.setObject(FechaSalidaOPI, forKey: "FechaSalidaOPI")
            }
            if !NroRegistroSalidaOPI.isEqual(nil) {
                elements.setObject(NroRegistroSalidaOPI, forKey: "NroRegistroSalidaOPI")
            }
            if !DocumentoSalidaOPI.isEqual(nil) {
                elements.setObject(DocumentoSalidaOPI, forKey: "DocumentoSalidaOPI")
            }
            if !FechaAsignacion.isEqual(nil) {
                elements.setObject(FechaAsignacion, forKey: "FechaAsignacion")
            }
            if !MemoAsignacion.isEqual(nil) {
                elements.setObject(MemoAsignacion, forKey: "MemoAsignacion")
            }
            if !DocumentoAsignacion.isEqual(nil) {
                elements.setObject(DocumentoAsignacion, forKey: "DocumentoAsignacion")
            }
            if !PlazoEstablecido.isEqual(nil) {
                elements.setObject(PlazoEstablecido, forKey: "PlazoEstablecido")
            }
            if !FechaDevolucionRecomendado.isEqual(nil) {
                elements.setObject(FechaDevolucionRecomendado, forKey: "FechaDevolucionRecomendado")
            }
            if !FechaDevolucion.isEqual(nil) {
                elements.setObject(FechaDevolucion, forKey: "FechaDevolucion")
            }
            if !CodigoInformeTecnico.isEqual(nil) {
                elements.setObject(CodigoInformeTecnico, forKey: "CodigoInformeTecnico")
            }
            if !DocumentoInformeTecnico.isEqual(nil) {
                elements.setObject(DocumentoInformeTecnico, forKey: "DocumentoInformeTecnico")
            }
            if !FechaViabilidad.isEqual(nil) {
                elements.setObject(FechaViabilidad, forKey: "FechaViabilidad")
            }
            if !DocumentoViabilidad.isEqual(nil) {
                elements.setObject(DocumentoViabilidad, forKey: "DocumentoViabilidad")
            }
            if !AsuntoDocumentoAsignacion.isEqual(nil) {
                elements.setObject(AsuntoDocumentoAsignacion, forKey: "AsuntoDocumentoAsignacion")
            }
            if !CuerpoDocumentoAsignacion.isEqual(nil) {
                elements.setObject(CuerpoDocumentoAsignacion, forKey: "CuerpoDocumentoAsignacion")
            }
            if !ObservacionesEvaluador.isEqual(nil) {
                elements.setObject(ObservacionesEvaluador, forKey: "ObservacionesEvaluador")
            }
            if !ComentariosEvaluador.isEqual(nil) {
                elements.setObject(ComentariosEvaluador, forKey: "ComentariosEvaluador")
            }
            if !idEvaluador.isEqual(nil) {
                elements.setObject(idEvaluador, forKey: "idEvaluador")
            }
            if !idEstadoEstudio.isEqual(nil) {
                elements.setObject(idEstadoEstudio, forKey: "idEstadoEstudio")
            }
            if !idEvaluacion.isEqual(nil) {
                elements.setObject(idEvaluacion, forKey: "idEvaluacion")
            }
            if !idSituacion.isEqual(nil) {
                elements.setObject(idSituacion, forKey: "idSituacion")
            }
            if !idjefeevaluadora.isEqual(nil) {
                elements.setObject(idjefeevaluadora, forKey: "idjefeevaluadora")
            }
            if !idestado_f16.isEqual(nil) {
                elements.setObject(idestado_f16, forKey: "idestado_f16")
            }
            if !idestado_f15.isEqual(nil) {
                elements.setObject(idestado_f15, forKey: "idestado_f15")
            }
            if !idestado_f17.isEqual(nil) {
                elements.setObject(idestado_f17, forKey: "idestado_f17")
            }
            if !idestado_f14.isEqual(nil) {
                elements.setObject(idestado_f14, forKey: "idestado_f14")
            }
            if !NombreUF.isEqual(nil) {
                elements.setObject(NombreUF, forKey: "NombreUF")
            }
            if !Prof_Responsable_UF.isEqual(nil) {
                elements.setObject(Prof_Responsable_UF, forKey: "Prof_Responsable_UF")
            }
            if !ResponsableUF.isEqual(nil) {
                elements.setObject(ResponsableUF, forKey: "ResponsableUF")
            }
            if !CargoUF.isEqual(nil) {
                elements.setObject(CargoUF, forKey: "CargoUF")
            }
            if !Direccion.isEqual(nil) {
                elements.setObject(Direccion, forKey: "Direccion")
            }
            if !TelefonoUF.isEqual(nil) {
                elements.setObject(TelefonoUF, forKey: "TelefonoUF")
            }
            if !EmailUF1.isEqual(nil) {
                elements.setObject(EmailUF1, forKey: "EmailUF1")
            }
            if !CelularUF.isEqual(nil) {
                elements.setObject(CelularUF, forKey: "CelularUF")
            }
            if !NombreEstadoEstudio.isEqual(nil) {
                elements.setObject(NombreEstadoEstudio, forKey: "NombreEstadoEstudio")
            }
            if !NombreUE.isEqual(nil) {
                elements.setObject(NombreUE, forKey: "NombreUE")
            }
            if !ResponsableUE.isEqual(nil) {
                elements.setObject(ResponsableUE, forKey: "ResponsableUE")
            }    
            if !CargoUE.isEqual(nil) {
                elements.setObject(CargoUE, forKey: "CargoUE")
            }    
            if !TelefonoUE.isEqual(nil) {
                elements.setObject(TelefonoUE, forKey: "TelefonoUE")
            }    
            if !EmailUE1.isEqual(nil) {
                elements.setObject(EmailUE1, forKey: "EmailUE1")
            }    
            if !CelularUE.isEqual(nil) {
                elements.setObject(CelularUE, forKey: "CelularUE")
            }    
            if !estadoP.isEqual(nil) {
                elements.setObject(estadoP, forKey: "estadoP")
            }    
            if !NombreNivelEstudio.isEqual(nil) {
                elements.setObject(NombreNivelEstudio, forKey: "NombreNivelEstudio")
            }    
            if !PlazoEvaluacion.isEqual(nil) {
                elements.setObject(PlazoEvaluacion, forKey: "PlazoEvaluacion")
            }    
            if !NombreFuncion.isEqual(nil) {
                elements.setObject(NombreFuncion, forKey: "NombreFuncion")
            }    
            if !NombresEvaluador.isEqual(nil) {
                elements.setObject(NombresEvaluador, forKey: "NombresEvaluador")
            }    
            if !ApellidosEvaluador.isEqual(nil) {
                elements.setObject(ApellidosEvaluador, forKey: "ApellidosEvaluador")
            }    
            if !Profesion.isEqual(nil) {
                elements.setObject(Profesion, forKey: "Profesion")
            }    
            if !Telefono1.isEqual(nil) {
                elements.setObject(Telefono1, forKey: "Telefono1")
            }    
            if !Celular.isEqual(nil) {
                elements.setObject(Celular, forKey: "Celular")
            }    
            if !CorreoElectronico1.isEqual(nil) {
                elements.setObject(CorreoElectronico1, forKey: "CorreoElectronico1")
            }    
            if !CorreoElectronico2.isEqual(nil) {
                elements.setObject(CorreoElectronico2, forKey: "CorreoElectronico2")
            }    
            if !DNI.isEqual(nil) {
                elements.setObject(DNI, forKey: "DNI")
            }    
            if !RUC.isEqual(nil) {
                elements.setObject(RUC, forKey: "RUC")
            }    
            if !FechaNacimiento.isEqual(nil) {
                elements.setObject(FechaNacimiento, forKey: "FechaNacimiento")
            }    
            if !Usuario.isEqual(nil) {
                elements.setObject(Usuario, forKey: "Usuario")
            }    
            if !EstadoEvaluador.isEqual(nil) {
                elements.setObject(EstadoEvaluador, forKey: "EstadoEvaluador")
            }    
            if !NombreEvaluacion.isEqual(nil) {
                elements.setObject(NombreEvaluacion, forKey: "NombreEvaluacion")
            }    
            if !JefeEvaluadora.isEqual(nil) {
                elements.setObject(JefeEvaluadora, forKey: "JefeEvaluadora")
            }    
            if !nombreImagenEstado.isEqual(nil) {
                elements.setObject(nombreImagenEstado, forKey: "nombreImagenEstado")
            }
            
            posts.addObject(elements)
        }
    }
    
    
    func parser(parser: NSXMLParser, foundCharacters string: String)
    {
        if element.isEqualToString("idProyecto"){
            idProyecto.appendString(string)
        }
        else if element.isEqualToString("CodigoSNIP"){
            CodigoSNIP.appendString(string)
        }
        else if element.isEqualToString("CodigoInterno"){
            CodigoInterno.appendString(string)
        }
        else if element.isEqualToString("NombreProyecto"){
            NombreProyecto.appendString(string)
        }
        else if element.isEqualToString("MontoInversion"){
            MontoInversion.appendString(string)
        }
        else if element.isEqualToString("FechaCreacion"){
            FechaCreacion.appendString(string)
        }
        else if element.isEqualToString("DocumentoProyecto"){
            DocumentoProyecto.appendString(string)
        }
        else if element.isEqualToString("ObservacionesProyecto"){
            ObservacionesProyecto.appendString(string)
        }
        else if element.isEqualToString("Estado"){
            Estado.appendString(string)
        }
        else if element.isEqualToString("NombresFormulador"){
            NombresFormulador.appendString(string)
        }
        else if element.isEqualToString("TelefonosFormulador"){
            TelefonosFormulador.appendString(string)
        }
        else if element.isEqualToString("EmailsFormulador"){
            EmailsFormulador.appendString(string)
        }
        else if element.isEqualToString("beneficiarios"){
            beneficiarios.appendString(string)
        }
        else if element.isEqualToString("DescripcionIntervencion"){
            DescripcionIntervencion.appendString(string)
        }
        else if element.isEqualToString("CodigoActividad"){
            CodigoActividad.appendString(string)
        }
        else if element.isEqualToString("Formato15"){
            Formato15.appendString(string)
        }
        else if element.isEqualToString("Formato14"){
            Formato14.appendString(string)
        }
        else if element.isEqualToString("idUF"){
            idUF.appendString(string)
        }
        else if element.isEqualToString("idUE"){
            idUE.appendString(string)
        }
        else if element.isEqualToString("idProvincia"){
            idProvincia.appendString(string)
        }
        else if element.isEqualToString("idNivelEstudio"){
            idNivelEstudio.appendString(string)
        }
        else if element.isEqualToString("idFuncion"){
            idFuncion.appendString(string)
        }
        else if element.isEqualToString("NombreProvincia"){
            NombreProvincia.appendString(string)
        }
        else if element.isEqualToString("NroDistritos"){
            NroDistritos.appendString(string)
        }
        else if element.isEqualToString("idControlOPI"){
            idControlOPI.appendString(string)
        }
        else if element.isEqualToString("FechaIngresoOPI"){
            FechaIngresoOPI.appendString(string)
        }
        else if element.isEqualToString("NroRegistroIngresoOPI"){
            NroRegistroIngresoOPI.appendString(string)
        }
        else if element.isEqualToString("DocumentoIngresoOPI"){
            DocumentoIngresoOPI.appendString(string)
        }
        else if element.isEqualToString("FechaSalidaOPI"){
            FechaSalidaOPI.appendString(string)
        }
        else if element.isEqualToString("NroRegistroSalidaOPI"){
            NroRegistroSalidaOPI.appendString(string)
        }
        else if element.isEqualToString("DocumentoSalidaOPI"){
            DocumentoSalidaOPI.appendString(string)
        }
        else if element.isEqualToString("FechaAsignacion"){
            FechaAsignacion.appendString(string)
        }
        else if element.isEqualToString("MemoAsignacion"){
            MemoAsignacion.appendString(string)
        }
        else if element.isEqualToString("DocumentoAsignacion"){
            DocumentoAsignacion.appendString(string)
        }
        else if element.isEqualToString("PlazoEstablecido"){
            PlazoEstablecido.appendString(string)
        }
        else if element.isEqualToString("FechaDevolucionRecomendado"){
            FechaDevolucionRecomendado.appendString(string)
        }
        else if element.isEqualToString("FechaDevolucion"){
            FechaDevolucion.appendString(string)
        }
        else if element.isEqualToString("CodigoInformeTecnico"){
            CodigoInformeTecnico.appendString(string)
        }
        else if element.isEqualToString("DocumentoInformeTecnico"){
            DocumentoInformeTecnico.appendString(string)
        }
        else if element.isEqualToString("FechaViabilidad"){
            FechaViabilidad.appendString(string)
        }
        else if element.isEqualToString("DocumentoViabilidad"){
            DocumentoViabilidad.appendString(string)
        }
        else if element.isEqualToString("AsuntoDocumentoAsignacion"){
            AsuntoDocumentoAsignacion.appendString(string)
        }
        else if element.isEqualToString("CuerpoDocumentoAsignacion"){
            CuerpoDocumentoAsignacion.appendString(string)
        }
        else if element.isEqualToString("ObservacionesEvaluador"){
            ObservacionesEvaluador.appendString(string)
        }
        else if element.isEqualToString("ComentariosEvaluador"){
            ComentariosEvaluador.appendString(string)
        }
        else if element.isEqualToString("idEvaluador"){
            idEvaluador.appendString(string)
        }
        else if element.isEqualToString("idEstadoEstudio"){
            idEstadoEstudio.appendString(string)
        }
        else if element.isEqualToString("idEvaluacion"){
            idEvaluacion.appendString(string)
        }
        else if element.isEqualToString("idSituacion"){
            idSituacion.appendString(string)
        }
        else if element.isEqualToString("idjefeevaluadora"){
            idjefeevaluadora.appendString(string)
        }
        else if element.isEqualToString("idestado_f16"){
            idestado_f16.appendString(string)
        }
        else if element.isEqualToString("idestado_f15"){
            idestado_f15.appendString(string)
        }
        else if element.isEqualToString("idestado_f17"){
            idestado_f17.appendString(string)
        }
        else if element.isEqualToString("idestado_f14"){
            idestado_f14.appendString(string)
        }
        else if element.isEqualToString("NombreUF"){
            NombreUF.appendString(string)
        }
        else if element.isEqualToString("Prof_Responsable_UF"){
            Prof_Responsable_UF.appendString(string)
        }
        else if element.isEqualToString("ResponsableUF"){
            ResponsableUF.appendString(string)
        }
        else if element.isEqualToString("CargoUF"){
            CargoUF.appendString(string)
        }
        else if element.isEqualToString("Direccion"){
            Direccion.appendString(string)
        }
        else if element.isEqualToString("TelefonoUF"){
            TelefonoUF.appendString(string)
        }
        else if element.isEqualToString("EmailUF1"){
            EmailUF1.appendString(string)
        }
        else if element.isEqualToString("CelularUF"){
            CelularUF.appendString(string)
        }
        else if element.isEqualToString("NombreEstadoEstudio"){
            NombreEstadoEstudio.appendString(string)
        }
        else if element.isEqualToString("NombreUE"){
            NombreUE.appendString(string)
        }
        else if element.isEqualToString("ResponsableUE"){
            ResponsableUE.appendString(string)
        }
        else if element.isEqualToString("CargoUE"){
            CargoUE.appendString(string)
        }
        else if element.isEqualToString("TelefonoUE"){
            TelefonoUE.appendString(string)
        }
        else if element.isEqualToString("EmailUE1"){
            EmailUE1.appendString(string)
        }
        else if element.isEqualToString("CelularUE"){
            CelularUE.appendString(string)
        }
        else if element.isEqualToString("estado"){
            estadoP.appendString(string)
        }
        else if element.isEqualToString("NombreNivelEstudio"){
            NombreNivelEstudio.appendString(string)
        }
        else if element.isEqualToString("PlazoEvaluacion"){
            PlazoEvaluacion.appendString(string)
        }
        else if element.isEqualToString("NombreFuncion"){
            NombreFuncion.appendString(string)
        }
        else if element.isEqualToString("NombresEvaluador"){
            NombresEvaluador.appendString(string)
        }
        else if element.isEqualToString("ApellidosEvaluador"){
            ApellidosEvaluador.appendString(string)
        }
        else if element.isEqualToString("Profesion"){
            Profesion.appendString(string)
        }
        else if element.isEqualToString("Telefono1"){
            Telefono1.appendString(string)
        }
        else if element.isEqualToString("Celular"){
            Celular.appendString(string)
        }
        else if element.isEqualToString("CorreoElectronico1"){
            CorreoElectronico1.appendString(string)
        }
        else if element.isEqualToString("CorreoElectronico2"){
            CorreoElectronico2.appendString(string)
        }
        else if element.isEqualToString("DNI"){
            DNI.appendString(string)
        }
        else if element.isEqualToString("RUC"){
            RUC.appendString(string)
        }
        else if element.isEqualToString("FechaNacimiento"){
            FechaNacimiento.appendString(string)
        }
        else if element.isEqualToString("Usuario"){
            Usuario.appendString(string)
        }
        else if element.isEqualToString("EstadoEvaluador"){
            EstadoEvaluador.appendString(string)
        }
        else if element.isEqualToString("NombreEvaluacion"){
            NombreEvaluacion.appendString(string)
        }
        else if element.isEqualToString("JefeEvaluadora"){
            JefeEvaluadora.appendString(string)
        }
        else if element.isEqualToString("nombreImagenEstado"){
            nombreImagenEstado.appendString(string)
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
