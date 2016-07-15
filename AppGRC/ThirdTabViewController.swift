//
//  ThirdTabViewController.swift
//  AppGRC
//
//  Created by Crisoper on 8/07/16.
//  Copyright © 2016 Crisoper. All rights reserved.
//

import UIKit

class ThirdTabViewController: UIViewController, NSXMLParserDelegate, UITableViewDataSource, UITableViewDelegate {

    //Colores globales
    let myConstants = MyClassConstants()
    
    //Outlets
    @IBOutlet weak var myTableRelacionado: UITableView!
    
    
    
    //Variables para parsear XML
    var parser = NSXMLParser()
    var posts = NSMutableArray()
    var elements = NSMutableDictionary()
    var element = NSString()
    
    //Variables del expediente
    var ExpedienteId = NSMutableString()
    var Documento = NSMutableString()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = myConstants.colorFondo2
        self.myTableRelacionado.backgroundColor = myConstants.colorFondo2
        
        // Do any additional setup after loading the view.
        self.myTableRelacionado.delegate = self
        
        self.myTableRelacionado.estimatedRowHeight = 82.0
        self.myTableRelacionado.rowHeight = UITableViewAutomaticDimension
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        
        //print(ClassDatosMAD.sharedDatosMAD.relacionado)
        
        
    }
    
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        //print(ClassDatosMAD.sharedDatosMAD.relacionado)
        self.beginParsing(ClassDatosMAD.sharedDatosMAD.relacionado.dataUsingEncoding(NSUTF8StringEncoding)!)
        
    }
    
    //ClassDatosMAD.sharedDatosMAD.relacionado
    
    
    //Implementando métodos de tablas
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell:SeguimientoUTVCell = tableView.dequeueReusableCellWithIdentifier("cell1", forIndexPath: indexPath) as! SeguimientoUTVCell

        cell.backgroundColor = myConstants.colorFondo2
        //cell.textLabel?.font = UIFont(name: "Arial", size: 15)
        
        cell.btnInformacion.tintColor = myConstants.colorIconos
        cell.lblExpediente.text = self.posts.objectAtIndex(indexPath.row).valueForKey("ExpedienteId") as! NSString as String
        cell.lblDocumento.text = self.posts.objectAtIndex(indexPath.row).valueForKey("Documento") as! NSString as String
        
        //Desabilitar seleccion de la fila
        cell.selectionStyle = UITableViewCellSelectionStyle.None
        
        cell.tapAction = { (cell) in
            
            let celda = self.myTableRelacionado.cellForRowAtIndexPath(indexPath) as! SeguimientoUTVCell
            ClassDatosMAD.sharedDatosMAD.idMadReferencia = celda.lblExpediente.text!
            
            let storyboard:UIStoryboard = UIStoryboard(name: "Mad", bundle: nil)
            let popoverContent:EmerrgenteMadVC = (storyboard.instantiateViewControllerWithIdentifier("EmerrgenteMadVCID")) as! EmerrgenteMadVC
            let nav = UINavigationController(rootViewController: popoverContent)
            nav.modalPresentationStyle = UIModalPresentationStyle.Popover
            self.presentViewController(nav, animated: false, completion: nil)
            
            
        }
        
        return cell
    }
    
    //Mostrar mesajes
    func showAlertForRow(string: String) {
        let alert = UIAlertController(
            title: "GRCMóvil",
            message: string,
            preferredStyle: .Alert)
        alert.addAction(UIAlertAction(title: "Aceptar", style: UIAlertActionStyle.Default, handler: { (test) -> Void in
            self.dismissViewControllerAnimated(true, completion: nil)
        }))
        
        self.presentViewController(
            alert,
            animated: true,
            completion: nil)
    }
    
    
    
    
    //Empezamos a parsear XML
    func beginParsing(contentString:NSData)
    {
        posts = []
        self.parser = NSXMLParser(data: contentString)
        self.parser.delegate = self
        self.parser.parse()
        
//        if posts.count <= 1 {
//            self.myTableRelacionado.separatorStyle = UITableViewCellSeparatorStyle.None
//        }
//        else{
//            self.myTableRelacionado.separatorStyle = UITableViewCellSeparatorStyle.SingleLine
//        }
        
        //print(posts.count)
        self.myTableRelacionado.reloadData()
    }
    
    
    
    //XMLParser Methods
    
    func parser(parser: NSXMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String])
    {
        element = elementName
        if (elementName as NSString).isEqualToString("InfoExpediente")
        {
            elements = NSMutableDictionary()
            elements = [:]
            
            ExpedienteId = NSMutableString()
            ExpedienteId = ""
            
            Documento = NSMutableString()
            Documento = ""
            
        }
    }
    
    func parser(parser: NSXMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?)
    {
        if (elementName as NSString).isEqualToString("InfoExpediente") {
            
            if !ExpedienteId.isEqual(nil) {
                elements.setObject(ExpedienteId, forKey: "ExpedienteId")
            }
            if !Documento.isEqual(nil) {
                elements.setObject(Documento, forKey: "Documento")
            }
            
            posts.addObject(elements)
        }
    }
    
    
    func parser(parser: NSXMLParser, foundCharacters string: String)
    {
        if element.isEqualToString("ExpedienteId") {
            ExpedienteId.appendString(string)
            
        } else if element.isEqualToString("Documento") {
            Documento.appendString(string)
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
