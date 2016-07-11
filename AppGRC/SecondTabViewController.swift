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
    var destinoproveido = NSMutableString()
    var tipooperacion = NSMutableString()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableSEguimiento.delegate = self
        
        //print(ClassDatosMAD.sharedDatosMAD.seguimiento)
        
        self.beginParsing(ClassDatosMAD.sharedDatosMAD.seguimiento.dataUsingEncoding(NSUTF8StringEncoding)!)

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        print("Second VC will appear")
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        print("Second VC will disappear")
    }
    
    
    //Implementando métodos de tablas
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath)
        
        //cell.textLabel?.text = sections[indexPath.section].items[indexPath.row]
        cell.backgroundColor = myConstants.colorFondo2
        
        //cell.textLabel?.font = UIFont(name: "Arial", size: 15)
        
        cell.textLabel?.text = posts.objectAtIndex(indexPath.row).valueForKey("fecha") as! NSString as String
        
        return cell
    }
    
    
    
    func beginParsing(contentString:NSData)
    {
        posts = []
        self.parser = NSXMLParser(data: contentString)
        self.parser.delegate = self
        self.parser.parse()
        
        print(posts.count)
        
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
