//
//  SecondTabViewController.swift
//  AppGRC
//
//  Created by Crisoper on 7/07/16.
//  Copyright © 2016 Crisoper. All rights reserved.
//

import UIKit

class SecondTabViewController: UIViewController, NSXMLParserDelegate, UITableViewDataSource, UITableViewDelegate {
    
    
    //Colores globales
    let myConstants = MyClassConstants()
    
    //Outlets
    @IBOutlet weak var tableSEguimiento: UITableView!
    

    //Variables para parsear XML
    var parser = NSXMLParser()
    var posts = NSMutableArray()
    var elements = NSMutableDictionary()
    var element = NSString()
    
    //Variables del expediente
    var tipoexpe = NSMutableString()
    var expedienteid = NSMutableString()
    var estado = NSMutableString()
    var fecha = NSMutableString()
    var forma = NSMutableString()
    var dependencia = NSMutableString()
    var dependenciafull = NSMutableString()
    var oficinaorigen = NSMutableString()
    var oficinaorigensiglas = NSMutableString()
    var usuarioorigen = NSMutableString()
    var usuarioorigenfull = NSMutableString()
    var operacion = NSMutableString()
    var dependenciadestino = NSMutableString()
    var dependenciadestinosiglas = NSMutableString()
    var oficinadestino = NSMutableString()
    var oficinadestinosiglas = NSMutableString()
    var usuariodestino = NSMutableString()
    var usuariodestinofull = NSMutableString()
    var destinoproveido =  NSMutableString()
    var tipooperacion = NSMutableString()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = myConstants.colorFondo2
        self.tableSEguimiento.backgroundColor = myConstants.colorFondo2
        
        self.tableSEguimiento.estimatedRowHeight = 220.0
        self.tableSEguimiento.rowHeight = UITableViewAutomaticDimension
        
        self.tableSEguimiento.delegate = self
        self.beginParsing(ClassDatosMAD.sharedDatosMAD.seguimiento.dataUsingEncoding(NSUTF8StringEncoding)!)

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        //print("Second VC will appear")
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        //print("Second VC will disappear")
    }
    
    
    //Implementando métodos de tablas
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell:ExpandableUTVCell = tableView.dequeueReusableCellWithIdentifier("celdaSeg", forIndexPath: indexPath) as! ExpandableUTVCell
        
        //cell.textLabel?.text = sections[indexPath.section].items[indexPath.row]
        cell.backgroundColor = myConstants.colorFondo2
        
        //Desabilitar seleccion de la fila
        cell.selectionStyle = UITableViewCellSelectionStyle.None
        
        cell.lblFecha.text = self.posts.objectAtIndex(indexPath.row).valueForKey("fecha") as! NSString as String
        cell.lblFecha.backgroundColor = myConstants.colorFondo2
        cell.lblExpediente.backgroundColor = myConstants.colorFondo2
        
        
        switch self.posts.objectAtIndex(indexPath.row).valueForKey("tipooperacion") as! NSString as String {
        case "1":
            cell.lblExpediente.text = "\(self.posts.count - indexPath.row) - RECEPCIONADO"

        case "2":
            cell.lblExpediente.text = "\(self.posts.count - indexPath.row) - DERIVADO"
            
        case "3":
            cell.lblExpediente.text = "\(self.posts.count - indexPath.row) - ARCHIVADO"
            
        case "4":
            cell.lblExpediente.text = "\(self.posts.count - indexPath.row) - ADJUNTO"
            
        default:
            cell.lblExpediente.text = ""
        }
        
        cell.btnInformacion.tintColor = myConstants.colorIconos
        
        
        cell.tapActionA = { (cell) in
            
            var text1 = "{\"tipoexpe\":\"\(self.posts.objectAtIndex(indexPath.row).valueForKey("tipoexpe") as! NSString as String)\""
            text1 = text1 + ",\"nrofila\":\"\(self.posts.count - indexPath.row)\""
            text1 = text1 + ",\"expedienteid\":\"\(self.posts.objectAtIndex(indexPath.row).valueForKey("expedienteid") as! NSString as String)\""
            text1 = text1 + ",\"estado\":\"\(self.posts.objectAtIndex(indexPath.row).valueForKey("estado") as! NSString as String)\""
            text1 = text1 + ",\"fecha\":\"\(self.posts.objectAtIndex(indexPath.row).valueForKey("fecha") as! NSString as String)\""
            text1 = text1 + ",\"forma\":\"\(self.posts.objectAtIndex(indexPath.row).valueForKey("forma") as! NSString as String)\""
            text1 = text1 + ",\"dependencia\":\"\(self.posts.objectAtIndex(indexPath.row).valueForKey("dependencia") as! NSString as String)\""
            text1 = text1 + ",\"dependenciafull\":\"\(self.posts.objectAtIndex(indexPath.row).valueForKey("dependenciafull") as! NSString as String)\""
            text1 = text1 + ",\"oficinaorigen\":\"\(self.posts.objectAtIndex(indexPath.row).valueForKey("oficinaorigen") as! NSString as String)\""
            text1 = text1 + ",\"oficinaorigensiglas\":\"\(self.posts.objectAtIndex(indexPath.row).valueForKey("oficinaorigensiglas") as! NSString as String)\""
            text1 = text1 + ",\"usuarioorigen\":\"\(self.posts.objectAtIndex(indexPath.row).valueForKey("usuarioorigen") as! NSString as String)\""
            text1 = text1 + ",\"usuarioorigenfull\":\"\(self.posts.objectAtIndex(indexPath.row).valueForKey("usuarioorigenfull") as! NSString as String)\""
            text1 = text1 + ",\"operacion\":\"\(self.posts.objectAtIndex(indexPath.row).valueForKey("operacion") as! NSString as String)\""
            text1 = text1 + ",\"dependenciadestino\":\"\(self.posts.objectAtIndex(indexPath.row).valueForKey("dependenciadestino") as! NSString as String)\""
            text1 = text1 + ",\"dependenciadestinosiglas\":\"\(self.posts.objectAtIndex(indexPath.row).valueForKey("dependenciadestinosiglas") as! NSString as String)\""
            text1 = text1 + ",\"oficinadestino\":\"\(self.posts.objectAtIndex(indexPath.row).valueForKey("oficinadestino") as! NSString as String)\""
            text1 = text1 + ",\"oficinadestinosiglas\":\"\(self.posts.objectAtIndex(indexPath.row).valueForKey("oficinadestinosiglas") as! NSString as String)\""
            text1 = text1 + ",\"usuariodestino\":\"\(self.posts.objectAtIndex(indexPath.row).valueForKey("usuariodestino") as! NSString as String)\""
            text1 = text1 + ",\"usuariodestinofull\":\"\(self.posts.objectAtIndex(indexPath.row).valueForKey("usuariodestinofull") as! NSString as String)\""
            text1 = text1 + ",\"destinoproveido\":\"\(self.posts.objectAtIndex(indexPath.row).valueForKey("destinoproveido") as! NSString as String)\""
            text1 = text1 + ",\"tipooperacion\":\"\(self.posts.objectAtIndex(indexPath.row).valueForKey("tipooperacion") as! NSString as String)\"}"
            
            ClassDatosMAD.sharedDatosMAD.seguimiento = text1
            
            //Llamamos a la función que va mostrar el emergente
            self.mostrarDetalleMovimientoSef(self.posts.objectAtIndex(indexPath.row).valueForKey("tipooperacion") as! NSString as String)
            
            
        }
        
        
        return cell
    }
    
    //Abrir Emergente con el detalle del movimiento en el seguimiento
    func mostrarDetalleMovimientoSef(numero:String) -> Void {
        
        switch numero {
        case "1":   //Recepcionado
            let storyboard:UIStoryboard = UIStoryboard(name: "Mad", bundle: nil)
            let popoverContent:SegArchivadoVC = (storyboard.instantiateViewControllerWithIdentifier("SegArchivadoVCID")) as! SegArchivadoVC
            let nav = UINavigationController(rootViewController: popoverContent)
            nav.modalPresentationStyle = UIModalPresentationStyle.Popover
            self.presentViewController(nav, animated: false, completion: nil)
            
        case "2":   //Derivado
            print("2")
            
        case "3":   //Archivado
            print("3")
            
        case "4":   //Adjunto
            print("4")
            
        default:    //Ninguno --- Mostrar alert
            print("default")
        }
        
        
        
        
        
    }
    
    
    
    
    //Empezamos a parsear el XML obtenido
    func beginParsing(contentString:NSData)
    {
        posts = []
        self.parser = NSXMLParser(data: contentString)
        self.parser.delegate = self
        self.parser.parse()
        self.tableSEguimiento.reloadData()
        
    }
    
    //XMLParser Methods
    
    func parser(parser: NSXMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String])
    {
        element = elementName
        if (elementName as NSString).isEqualToString("Func_TraSeguimientoDetResult")
        {
            elements = NSMutableDictionary()
            elements = [:]
            
            tipoexpe = NSMutableString()
            tipoexpe = ""
            expedienteid = NSMutableString()
            expedienteid = ""
            estado = NSMutableString()
            estado = ""
            fecha = NSMutableString()
            fecha = ""
            forma = NSMutableString()
            forma = ""
            dependencia = NSMutableString()
            dependencia = ""
            dependenciafull = NSMutableString()
            dependenciafull = ""
            oficinaorigen = NSMutableString()
            oficinaorigen = ""
            oficinaorigensiglas = NSMutableString()
            oficinaorigensiglas = ""
            usuarioorigen = NSMutableString()
            usuarioorigen = ""
            usuarioorigenfull = NSMutableString()
            usuarioorigenfull = ""
            operacion = NSMutableString()
            operacion = ""
            dependenciadestino = NSMutableString()
            dependenciadestino = ""
            dependenciadestinosiglas = NSMutableString()
            dependenciadestinosiglas = ""
            oficinadestino = NSMutableString()
            oficinadestino = ""
            oficinadestinosiglas = NSMutableString()
            oficinadestinosiglas = ""
            usuariodestino = NSMutableString()
            usuariodestino = ""
            usuariodestinofull = NSMutableString()
            usuariodestinofull = ""
            destinoproveido = NSMutableString()
            destinoproveido = ""
            tipooperacion = NSMutableString()
            tipooperacion = ""
            
        }
    }
    
    func parser(parser: NSXMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?)
    {
        if (elementName as NSString).isEqualToString("Func_TraSeguimientoDetResult") {
            
            if !tipoexpe.isEqual(nil) {
                elements.setObject(tipoexpe, forKey: "tipoexpe")
            }
            if !expedienteid.isEqual(nil) {
                elements.setObject(expedienteid, forKey: "expedienteid")
            }
            if !estado.isEqual(nil) {
                elements.setObject(estado, forKey: "estado")
            }
            if !fecha.isEqual(nil) {
                elements.setObject(fecha, forKey: "fecha")
            }
            if !forma.isEqual(nil) {
                elements.setObject(forma, forKey: "forma")
            }
            if !dependencia.isEqual(nil) {
                elements.setObject(dependencia, forKey: "dependencia")
            }
            if !dependenciafull.isEqual(nil) {
                elements.setObject(dependenciafull, forKey: "dependenciafull")
            }
            if !oficinaorigen.isEqual(nil) {
                elements.setObject(oficinaorigen, forKey: "oficinaorigen")
            }
            if !oficinaorigensiglas.isEqual(nil) {
                elements.setObject(oficinaorigensiglas, forKey: "oficinaorigensiglas")
            }
            if !usuarioorigen.isEqual(nil) {
                elements.setObject(usuarioorigen, forKey: "usuarioorigen")
            }
            if !usuarioorigenfull.isEqual(nil) {
                elements.setObject(usuarioorigenfull, forKey: "usuarioorigenfull")
            }
            if !operacion.isEqual(nil) {
                elements.setObject(operacion, forKey: "operacion")
            }
            if !dependenciadestino.isEqual(nil) {
                elements.setObject(dependenciadestino, forKey: "dependenciadestino")
            }
            if !dependenciadestinosiglas.isEqual(nil) {
                elements.setObject(dependenciadestinosiglas, forKey: "dependenciadestinosiglas")
            }
            if !oficinadestino.isEqual(nil) {
                elements.setObject(oficinadestino, forKey: "oficinadestino")
            }
            if !oficinadestinosiglas.isEqual(nil) {
                elements.setObject(oficinadestinosiglas, forKey: "oficinadestinosiglas")
            }
            if !usuariodestino.isEqual(nil) {
                elements.setObject(usuariodestino, forKey: "usuariodestino")
            }
            if !usuariodestinofull.isEqual(nil) {
                elements.setObject(usuariodestinofull, forKey: "usuariodestinofull")
            }
            if !destinoproveido.isEqual(nil) {
                elements.setObject(destinoproveido, forKey: "destinoproveido")
            }
            if !tipooperacion.isEqual(nil) {
                elements.setObject(tipooperacion, forKey: "tipooperacion")
            }
            
            posts.addObject(elements)
        }
    }
    
    
    func parser(parser: NSXMLParser, foundCharacters string: String)
    {
        if element.isEqualToString("tipoexpe") {
            tipoexpe.appendString(string)
        }
        else if element.isEqualToString("expedienteid"){
            expedienteid.appendString(string)
        }
        else if element.isEqualToString("estado"){
            estado.appendString(string)
        }
        else if element.isEqualToString("fecha"){
            fecha.appendString(string)
        }
        else if element.isEqualToString("forma"){
            forma.appendString(string)
        }
        else if element.isEqualToString("dependencia"){
            dependencia.appendString(string)
        }
        else if element.isEqualToString("dependenciafull"){
            dependenciafull.appendString(string)
        }
        else if element.isEqualToString("oficinaorigen"){
            oficinaorigen.appendString(string)
        }
        else if element.isEqualToString("oficinaorigensiglas"){
            oficinaorigensiglas.appendString(string)
        }
        else if element.isEqualToString("usuarioorigen"){
            usuarioorigen.appendString(string)
        }
        else if element.isEqualToString("usuarioorigenfull"){
            usuarioorigenfull.appendString(string)
        }
        else if element.isEqualToString("operacion"){
            operacion.appendString(string)
        }
        else if element.isEqualToString("dependenciadestino"){
            dependenciadestino.appendString(string)
        }
        else if element.isEqualToString("dependenciadestinosiglas"){
            dependenciadestinosiglas.appendString(string)
        }
        else if element.isEqualToString("oficinadestino"){
            oficinadestino.appendString(string)
        }
        else if element.isEqualToString("oficinadestinosiglas"){
            oficinadestinosiglas.appendString(string)
        }
        else if element.isEqualToString("usuariodestino"){
            usuariodestino.appendString(string)
        }
        else if element.isEqualToString("usuariodestinofull"){
            usuariodestinofull.appendString(string)
        }
        else if element.isEqualToString("destinoproveido"){
            destinoproveido.appendString(string)
        }
        else if element.isEqualToString("tipooperacion"){
            tipooperacion.appendString(string)
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
