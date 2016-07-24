//
//  NoticiasTVC.swift
//  AppGRC
//
//  Created by Crisoper on 12/06/16.
//  Copyright © 2016 Crisoper. All rights reserved.
//

import UIKit

class NoticiasTVC: UITableViewController, UISearchBarDelegate {
    
    //Colores globales
    let myConstants = MyClassConstants()
    
    //Para guardar en caché
    var imageCache = [String:UIImage]()
    //var people: [Person] = []
    var resultNoticias: [NoticiasClass] = []
    
    
    //Para mostrar emergente
    let alert = UIAlertController(title: nil, message: "Espere por favor...", preferredStyle: .Alert)
    
    
    
    @IBOutlet var myTable: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var myViewTableCell: UITableViewCell!
    //var popup = PopupController()
    //let popup = PopupController.create(LoadingViewController)
    //let container = LoadingViewController.instance()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Noticias"
        self.searchBar.delegate = self
        
        self.view.backgroundColor = myConstants.colorFondo2
        
        //Para Ocultar el teclado automaticamente
//        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(NoticiasTVC.ocultarTeclado))
//        view.addGestureRecognizer(tap)
        
        
        
        self.myTable.separatorStyle = UITableViewCellSeparatorStyle.SingleLine
        self.tableView.estimatedRowHeight = 244.0
        self.tableView.rowHeight = UITableViewAutomaticDimension
        
        self.hacerBusqueda("")
        
        
        
        
        //_ = NSTimer.scheduledTimerWithTimeInterval(4, target: self, selector: #selector(NoticiasTVC.update), userInfo: nil, repeats: true)

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
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
    
    
    //Ocultar teclado
//    func ocultarTeclado(){
//        view.endEditing(true)
//    }
    
    
    func searchBarShouldBeginEditing(searchBar: UISearchBar) -> Bool {
        self.tableView.allowsSelection = false
        return true
    }
    
    
    func searchBarTextDidEndEditing(searchBar: UISearchBar) {
        self.tableView.allowsSelection = true
    }
    
    
    //Boton Buscar
    func searchBarSearchButtonClicked(searchBar: UISearchBar) {
        
        self.resultNoticias.removeAll()
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
        self.searchBar.text = ""
        self.tableView.allowsSelection = true
    }

    
    
    
    
    
    
    //funcion para traer datos
    func hacerBusqueda(descripcion:String){
        
        //Si no existe red, retornamos
        if !VerificaConexion.isConnectedToNetwork() {
            self.tableView.reloadData()
            self.showMessageAlert("No existe conexión de red")
            return
        }
        
        
        self.mostrarActivity()
        
        self.searchBar.resignFirstResponder()
        
        var urlBase = "http://www.regioncajamarca.gob.pe/serviciosweb/grc/noticias.json"
        
        if descripcion == "" {
            urlBase = urlBase + ""
        }
        else {
            urlBase = urlBase + "?titulo=" + descripcion
        }
        
        let url = NSURL(string: urlBase)
        
        let urlRequest = NSURLRequest(URL: url!)
        
        let task = NSURLSession.sharedSession().dataTaskWithRequest(urlRequest) { (datos, respuesta, error) in
            
            //Obteniendo el hilo principal de ejecución
            dispatch_async(dispatch_get_main_queue(), {
                if error != nil {
                    
                    self.ocultarActivity()
                    
                    //print("Error de conexión a internet")
                    //Mostramos error al traer data Json
                    self.showMessageAlert((error?.localizedDescription)!)
                }
                else {
                    
                    self.ocultarActivity()
                    
                    //Eliminamos todos los datos del array
                    self.resultNoticias.removeAll(keepCapacity: false)
                    self.myTable.reloadData()
                    
                    if let jsonResult = try? NSJSONSerialization.JSONObjectWithData(datos!, options: NSJSONReadingOptions.MutableContainers) {
                        
                        //print(jsonResult)
                        
                        if let items = jsonResult as? [AnyObject] {
                            
                            for item in items {
                                
                                self.resultNoticias.append(
                                    NoticiasClass(
                                        titulo: item.valueForKey("titulo") as! String,
                                        descripcion: item.valueForKey("descripcion") as! String,
                                        imagen: item.valueForKey("imagen") as! String,
                                        subtitulo: item.valueForKey("subtitulo") as! String,
                                        id: item.valueForKey("id") as! String,
                                        miniatura:item.valueForKey("miniatura") as! String,
                                        fecha: item.valueForKey("fecha") as! String,
                                        archivos: item.valueForKey("archivos") as! String,
                                        corto: item.valueForKey("corto") as! String
                                    )
                                )
                                //self.resultNoticias.titulo
                                
                                //self.resultNoticias.append(item.valueForKey("titulo") as! String)
                                //self.resultNoticias.append(item as! String)
                            }
                            
                            //Recargamos la tabla
                            //self.ocultarActivity()
                            self.myTable.reloadData()
                            
                        }
                        else {
                            
                            //El resultado no se ha podido convertir en obejto
                            self.ocultarActivity()
                            self.showMessageAlert("Error al convertir jsonResult a AnyObject")
                            
                        }
                        
                    }
                    else {
                        self.ocultarActivity()
                        self.showMessageAlert("Error al parsear datos a JSon")
                    }
                    
                }
            })
            //Fin dispatch_async
            
        }
        
        task.resume()
        
        //print(resultNoticias)
        
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
        return resultNoticias.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as! NoticiasTVCell
        
        cell.backgroundColor = myConstants.colorFondo2
        
        cell.myTitle.text = self.resultNoticias[indexPath.row].titulo
        cell.myTitle.numberOfLines = 0
        //cell.myTitle.lineBreakMode = NSLineBreakMode.ByWordWrapping
        
        cell.myDate.text = self.resultNoticias[indexPath.row].fecha.html2String
        cell.myDate.numberOfLines = 0
        
        
        cell.myImage.backgroundColor = UIColor.blackColor()
        //cellToUpdate.imageView?.contentMode = .ScaleAspectFit
        //cell.imagenCell.contentMode = .ScaleAspectFit
        
        cell.myImage.image = nil //UIImage(named: "circle-loading-gif.gif")
        
        cell.imageView!.contentMode = .Center
        //cell.imagenCell?.contentMode = .ScaleToFill
        
        cell.myDescripcion.text = self.resultNoticias[indexPath.row].corto.html2String
        cell.myDescripcion.numberOfLines = 0
        
        //let urlString = self.resultNoticias[indexPath.row].miniatura.html2String
        
        let urlString = "<img.*?src=\"([^\"]*)\"".firstMatchIn(self.resultNoticias[indexPath.row].miniatura, atRangeIndex: 1)
        //print(urlString)
        
        let imgURL = NSURL(string:urlString)
        
        
        if let img = imageCache[urlString] {
            //cell.setPostedImage(img)
            cell.myImage.image = img
            //cell.imagenCell.contentMode = .ScaleAspectFit
        }
        else {
            // The image isn't cached, download the img data
            // We should perform this in a background thread
            let request: NSURLRequest = NSURLRequest(URL: imgURL!)
            
            
            let task = NSURLSession.sharedSession().dataTaskWithRequest(request) { (datos, respuesta, error) in
                
                if error != nil {
                    //Mostramos error al traer data Json
                    self.showMessageAlert((error?.localizedDescription)!)
                }
                else {
                    
                    if let image = UIImage(data: datos!) {
                        // Store the image in to our cache
                        self.imageCache[urlString] = image
                        
                        dispatch_async(dispatch_get_main_queue(), {
                            
                            cell.myImage.image = image
                            //print("Nuevo")
                        })
                    }
                }
            }
            
            task.resume()
        }
        
        
        
        //print(resultNoticias[indexPath.row])
        
        return cell
    }
    
    
    //Seleccion de filas
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        //print(indexPath.row)
        
        
        self.performSegueWithIdentifier("detalleNoticia", sender: self)
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

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        //
        if segue.identifier == "detalleNoticia" {
            if let destination = segue.destinationViewController as? NoticiaDetalleVC {
                
                if let noticiaIndex = tableView.indexPathForSelectedRow?.row {
                    destination.detalleNoticia["titulo"] = self.resultNoticias[noticiaIndex].titulo
                    destination.detalleNoticia["descripcion"] = self.resultNoticias[noticiaIndex].descripcion
                    destination.detalleNoticia["subtitulo"] = self.resultNoticias[noticiaIndex].subtitulo
                    destination.detalleNoticia["fecha"] = self.resultNoticias[noticiaIndex].fecha
                    destination.detalleNoticia["miniatura"] = self.resultNoticias[noticiaIndex].miniatura
                    destination.detalleNoticia["imagen"] = self.resultNoticias[noticiaIndex].imagen
                    
                    //print(resultNoticias[noticiaIndex].archivos)
                    
                }
            }
        }
    }
    
    

}


//Leer html
extension String {
    
    var html2AttributedString: NSAttributedString? {
        guard
            let data = dataUsingEncoding(NSUTF8StringEncoding)
            else { return nil }
        do {
            return try NSAttributedString(data: data, options: [NSDocumentTypeDocumentAttribute:NSHTMLTextDocumentType,NSCharacterEncodingDocumentAttribute:NSUTF8StringEncoding], documentAttributes: nil)
        } catch let error as NSError {
            print(error.localizedDescription)
            return  nil
        }
    }
    var html2String: String {
        return html2AttributedString?.string ?? ""
    }
    
    func firstMatchIn(string: NSString!, atRangeIndex: Int!) -> String {
        
        //var error : NSError?
        
        let re = try?  NSRegularExpression(pattern: self, options: .CaseInsensitive)
        
        let match = re!.firstMatchInString(string as String, options: .WithoutAnchoringBounds, range: NSMakeRange(0, string.length))
        
        return string.substringWithRange(match!.rangeAtIndex(atRangeIndex))
    }
}
