//
//  FourthTabViewController.swift
//  AppGRC
//
//  Created by Crisoper on 8/07/16.
//  Copyright © 2016 Crisoper. All rights reserved.
//

import UIKit

class FourthTabViewController: UIViewController, NSXMLParserDelegate, UITableViewDataSource, UITableViewDelegate {
    
    //Variables globales de color
    let myConstants = MyClassConstants()
    
    //Outlets
    @IBOutlet weak var myTableAdjunto: UITableView!
    
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
        self.myTableAdjunto.backgroundColor = myConstants.colorFondo2
        self.myTableAdjunto.delegate = self
        
        self.myTableAdjunto.estimatedRowHeight = 82.0
        self.myTableAdjunto.rowHeight = UITableViewAutomaticDimension

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        //print(ClassDatosMAD.sharedDatosMAD.relacionado)
        self.beginParsing(ClassDatosMAD.sharedDatosMAD.adjunto.dataUsingEncoding(NSUTF8StringEncoding)!)
        
    }
    
    
    
    //Implementando métodos de tablas
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell:AdjuntoUTVCell = tableView.dequeueReusableCellWithIdentifier("cellA", forIndexPath: indexPath) as! AdjuntoUTVCell
        
        cell.backgroundColor = myConstants.colorFondo2
        
        
        //cell.lblExpediente.text = "\(posts.count - indexPath.row) - \(self.posts.objectAtIndex(indexPath.row).valueForKey("tipooperacion") as! NSString as String)"
        //cell.lblFecha.text = self.posts.objectAtIndex(indexPath.row).valueForKey("fecha") as! NSString as String
        
        //cell.btnInformacion.tintColor = myConstants.colorIconos
        cell.lblExpediente.text = self.posts.objectAtIndex(indexPath.row).valueForKey("ExpedienteId") as! NSString as String
        cell.lblDocumento.text = self.posts.objectAtIndex(indexPath.row).valueForKey("Documento") as! NSString as String
        
        //Desabilitar seleccion de la fila
        cell.selectionStyle = UITableViewCellSelectionStyle.None
        
        cell.btnInformacion.tintColor = myConstants.colorIconos
        
        
        cell.tapAction = { (cell) in
            
            //self.showAlertForRow(tableView.indexPathForCell(cell)!.row)
            
            let celda = self.myTableAdjunto.cellForRowAtIndexPath(indexPath) as! AdjuntoUTVCell
            ClassDatosMAD.sharedDatosMAD.idMadReferencia = celda.lblExpediente.text!
            
            //self.showAlertForRow(celda.lblExpediente.text!)
            //let numero = self.myTableRelacionado.cellForRowAtIndexPath(indexPath);
            //fields.setObject(cell.txtIpValue.text, forKey: cell.lblstr.text)
            
            
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
        
        //print(posts)
        self.myTableAdjunto.reloadData()
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
        }
        else if element.isEqualToString("Documento") {
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
