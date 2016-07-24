//
//  MainUIViewController.swift
//  AppGRC
//
//  Created by Crisoper on 8/06/16.
//  Copyright © 2016 Crisoper. All rights reserved.
//

import UIKit
import CoreData


class MainUIViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    
    //Iniciamos variables globales
    let myConstants = MyClassConstants()
    
    
    @IBOutlet var myCollectionView: UICollectionView!
    
    
    
    
    var sesionUsuario:String = "no"
    
    var imageButton:[String] = []
    var textButtons:[String] = []
    
    //var items = [ "mad", "agenda", "asistencias", "boletas", "convocatorias", "correo", "directorio", "normatividad", "noticias", "proyectos", "redes"]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //print("Bienvendio a GRCmóvil")
        
        
        self.title = "GRCmóvil"
        self.view.backgroundColor = myConstants.colorFondo2
        // Do any additional setup after loading the view.
        
        CrearBotonesInicio()
        
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(MainUIViewController.loadList(_:)), name:"load", object: nil)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    //Navegamos a Acercade
    @IBAction func mostrarAcercade(sender: AnyObject) {
        
        let storyboard:UIStoryboard = UIStoryboard(name: "Acercade", bundle: nil)
        let controller:AcercadeTableViewController  = storyboard.instantiateViewControllerWithIdentifier("AcercadeTVCID") as! AcercadeTableViewController
        self.showViewController(controller, sender: self)
        
    }
    
    //Leemos información de ButtonHome.plist
    func loadList(notification: NSNotification){
        
        print(textButtons)
        
        CrearBotonesInicio()
        
        print(textButtons)
        
        
        self.myCollectionView.reloadData()
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
    
    func CrearBotonesInicio() {
        
        imageButton.removeAll()
        textButtons.removeAll()
        
        
        //Guardando datos en Core Data
        
        let appDel:AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        //Contexto (interfaz) desde el cual accedemos a CoreData
        let context:NSManagedObjectContext = appDel.managedObjectContext
        
        let request = NSFetchRequest(entityName: "User") //Consultando datos de coredata
        //request.predicate = NSPredicate(format: "usuario = %@", "crisoper")  //Un predicado es como un where en SQL
        
        var token:String = ""
        
        if let results = try? context.executeFetchRequest(request) where results.count > 0 {
            
            self.sesionUsuario = "si"
            
            for item in results {
                //let _dni = item.valueForKey("dni")!
                let _token = item.valueForKey("token")!
                //let _logueado = item.valueForKey("logueado")!
                //print("Eliminando DNI: \(dni) + Token: \(token)" + " Logueado: \(logueado)" )
                
                token = _token as! String
                
                //Borrar luego
                print(token)
                
            }
            
            
            //Debemos enviar el token encontrado en la base de datos para validarlo
            //
            //
            //
            
            /*
            if tokenValid == true {
                self.sesionUsuario = "si"
            }
            else {
                self.sesionUsuario = "no"
                
                //Debemos eliminar la data de la base de datos
                context.deleteObject(item as! NSManagedObject)
                
                _ = try? context.save()
                
                
            
            }
            */
            
            
        }
        else {
            self.sesionUsuario = "no"
        }
        //Fin CoreData
        
        
        
        
        
        //print("Iniciamos la creacion de botones", sesionUsuario)
        
        var format = NSPropertyListFormat.XMLFormat_v1_0 //format of the property list
        var plistData:[String:AnyObject] = [:]  //our data
        let plistPath:String? = NSBundle.mainBundle().pathForResource("HomeButtons", ofType: "plist")! //the path of the data
        let plistXML = NSFileManager.defaultManager().contentsAtPath(plistPath!)! //the data in XML format
        do{ //convert the data to a dictionary and handle errors.
            plistData = try NSPropertyListSerialization.propertyListWithData(plistXML,options: .MutableContainersAndLeaves,format: &format)as! [String:AnyObject]
            
            for index in 0...(plistData.count - 1) {
                
                let indice:String? = String(index)
                let item = plistData[indice!]

                
                
                if self.sesionUsuario == "si" {
                    
                    imageButton.append(item!.valueForKey("imagen") as! String)
                    textButtons.append(item!.valueForKey("texto") as! String)
                
                } else {
                    
                    let login = item!.valueForKey("login") as! String
                    
                    if login == "no" {
                        
                        imageButton.append(item!.valueForKey("imagen") as! String)
                        textButtons.append(item!.valueForKey("texto") as! String)
                        
                    }
                
                }
                
                
            }
            
            
        }
        catch{ // error condition
            print("Error reading plist: \(error), format: \(format)")
            exit(1)
            
        }
    
    }
    
    
    
    //Mostramos Login o Perfil de Usuario
    @IBAction func ShowViewLogin(sender: AnyObject) {
        
        //Consultamos datos
        let appDel:AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let context:NSManagedObjectContext = appDel.managedObjectContext
        let request = NSFetchRequest(entityName: "User") //Consultando datos de coredata
        
        if let results = try? context.executeFetchRequest(request) where results.count > 0 {
            
            //Navegamos a Perfil de Usuario
            let storyboard:UIStoryboard = UIStoryboard(name: "Login", bundle: nil)
            let controller:PerfilUsuarioViewController  = storyboard.instantiateViewControllerWithIdentifier("VCPerfilUsuarioID") as! PerfilUsuarioViewController
            self.showViewController(controller, sender: self)
            
        }
        else {
            
            //Navegamos a Login
            let storyboard:UIStoryboard = UIStoryboard(name: "Login", bundle: nil)
            let controller:LoginViewController  = storyboard.instantiateViewControllerWithIdentifier("VCIniciarSesionID") as! LoginViewController
            self.showViewController(controller, sender: self)
            
        }
        
    }
    
    
    
    //Iniciamos construccion de la pantalla de Inicio
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        //Seteamos color de fondo
        collectionView.backgroundColor = myConstants.colorFondo2
        
        return self.textButtons.count
        
    }
    
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("cell", forIndexPath: indexPath) as! MainCollectionViewCell
        
        //cell.backgroundColor = UIColor.yellowColor()
        
        // Propiedades de Label
        cell.myLabel.text = self.textButtons[indexPath.item]
        cell.myLabel.textColor = myConstants.colorTextoBotones
        cell.myLabel.backgroundColor = UIColor.clearColor()
        cell.myLabel.lineBreakMode = .ByWordWrapping
        cell.myLabel.numberOfLines = 0
        
        
        // Propiedades de Imagen
        cell.myImage.image = UIImage(named: "\(self.imageButton[indexPath.item])")?.imageWithRenderingMode(UIImageRenderingMode.AlwaysTemplate)
        
        if self.imageButton[indexPath.item] == "asistencias" || self.imageButton[indexPath.item] == "boletas" {
            cell.myImage.tintColor = myConstants.colorIconosLogueados
        } else {
            cell.myImage.tintColor = myConstants.colorIconos
        }
        
        
        
        
        //cell.MyButon.addTarget(self, action: #selector(CollectionView.AbrirVentana(_:)), forControlEvents: UIControlEvents.TouchDown)
        //cell.MyButon.setTitle(self.items[indexPath.item], forState: UIControlState.Normal)
        
        return cell
    }
    
    //Al seleccionar una imagen
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        
        ShowWindowCustomSegue(self.imageButton[indexPath.item] as String)

    }
    
    
    
    //Navengando a Vista Respectiva
    func ShowWindowCustomSegue (imagen:String ) {
        
        switch imagen {
            
            case "agenda":
                //Efecto transicion a la derecha
                let storyboard:UIStoryboard = UIStoryboard(name: "Agenda", bundle: nil)
                let controller:AgendaViewController  = storyboard.instantiateViewControllerWithIdentifier("AgendaVCID") as! AgendaViewController
                self.showViewController(controller, sender: self)
                
            case "asistencias":
                //Efecto de aparición como emergente
                //let storyboard:UIStoryboard = UIStoryboard(name: "Login", bundle: nil)
                //let controller:ViewControllerLogin  = storyboard.instantiateViewControllerWithIdentifier("LoginStoryBoardID") as! ViewControllerLogin
                //self.showViewController(controller, sender: self)
                //let navigationController = UINavigationController(rootViewController: controller)
                //self.showViewController(navigationController, sender: self)
                
                print(imagen)
                
            case "boletas":
                print(imagen)
                
            case "convocatorias":
                
                let storyboard:UIStoryboard = UIStoryboard(name: "Convocatorias", bundle: nil)
                let controller:ConvocatoriasViewController  = storyboard.instantiateViewControllerWithIdentifier("ConvocatoriasVCID") as! ConvocatoriasViewController
                self.showViewController(controller, sender: self)
                
            case "correo":
                //Efecto transicion a la derecha
                //let storyboard:UIStoryboard = UIStoryboard(name: "Correo", bundle: nil)
                //let controller:CorreoViewController  = storyboard.instantiateViewControllerWithIdentifier("VCCorreoID") as! CorreoViewController
                //self.showViewController(controller, sender: self)
                
                if let url = NSURL(string: "https://correo.regioncajamarca.gob.pe") {
                    UIApplication.sharedApplication().openURL(url)
                }
                
                //print(imagen)
            
            case "directorio":
                
                print(imagen)
            
            case "mad":
                
                let storyboard:UIStoryboard = UIStoryboard(name: "Mad", bundle: nil)
                let controller:MadViewController  = storyboard.instantiateViewControllerWithIdentifier("MadVCID") as! MadViewController
                self.showViewController(controller, sender: self)
                
            case "normatividad":
                let storyboard:UIStoryboard = UIStoryboard(name: "Normatividad", bundle: nil)
                let controller:NormatividadTVC  = storyboard.instantiateViewControllerWithIdentifier("NormatividadVCID") as! NormatividadTVC
                self.showViewController(controller, sender: self)
                
            case "noticias":
                let storyboard:UIStoryboard = UIStoryboard(name: "Noticias", bundle: nil)
                let controller:NoticiasTVC  = storyboard.instantiateViewControllerWithIdentifier("NoticiasVCID") as! NoticiasTVC
                self.showViewController(controller, sender: self)            
            
            case "proyectos":
            
                let storyboard:UIStoryboard = UIStoryboard(name: "Proyectos", bundle: nil)
                let controller:ProyectosTableVC  = storyboard.instantiateViewControllerWithIdentifier("ProyectosTableVCID") as! ProyectosTableVC
                self.showViewController(controller, sender: self)
            
            
            case "redes":
            
                let storyboard:UIStoryboard = UIStoryboard(name: "Redes", bundle: nil)
                let controller:RedesViewController  = storyboard.instantiateViewControllerWithIdentifier("RedesVCID") as! RedesViewController
                self.showViewController(controller, sender: self)
            
            
            default:
                print(imagen)
        }
        
    }
}
