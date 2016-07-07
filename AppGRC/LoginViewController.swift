//
//  LoginViewController.swift
//  AppGRC
//
//  Created by Crisoper on 8/06/16.
//  Copyright © 2016 Crisoper. All rights reserved.
//

import UIKit
import CoreData

class LoginViewController: UIViewController, UITextFieldDelegate {
    
    
    //Constantes
    let myConstants = MyClassConstants()
    
    //Almacenamos los datos
    //var usuarios = [NSManagedObject]()
    
    
    //var managedObjectContext: NSManagedObjectContext? = nil
    
    @IBOutlet weak var txtDNI: UITextField!
    @IBOutlet weak var txtContrasena: UITextField!
    @IBOutlet weak var IniciarSesion: UIButton!
    @IBOutlet weak var myimage: UIImageView!
    @IBOutlet weak var viewFondo: UIView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //Color de fondo
        self.viewFondo.backgroundColor = myConstants.colorFondo2
        
        self.myimage.backgroundColor = myConstants.colorIconos
        self.IniciarSesion.backgroundColor = myConstants.colorIconos
        self.IniciarSesion.layer.cornerRadius = 5
        
        //Ocultamos el teclado
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(LoginViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
        
        
        //Inicializamos tipos de teclado
        initializeTextFields()
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    @IBAction func IniciarSesionPressed(sender: AnyObject) {
        
        //Iniciamos sesión
        dismissKeyboard()
        
        print(txtDNI.text)
        
        //if txtDNI.text! == "44641743" {
            
            //Seteamos data de inicio de sesión
            //Guardando datos en Core Data
            let appDel:AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
            
            //Contexto (interfaz) desde el cual accedemos a CoreData
            let context:NSManagedObjectContext = appDel.managedObjectContext
        
            //Insertamos un usuario
            let nuevoUsuario = NSEntityDescription.insertNewObjectForEntityForName( "User", inManagedObjectContext: context)
            nuevoUsuario.setValue(txtDNI.text!, forKey: "dni")
            nuevoUsuario.setValue("si", forKey: "logueado")
            nuevoUsuario.setValue(txtContrasena.text!, forKey: "token")
        
            _ = try? context.save()     //Indicamos que si sucede un error lo ignore y los deje pasar por alto
            //Fin CoreData
        
            //print("Recargamos data")
        
            //mainVC.CrearBotonesInicio()
        
            //let indexPaths:NSIndexPath = NSIndexPath(forItem: 1, inSection: 0)
            
            //mainVC.myCollectionView.reloadItemsAtIndexPaths([indexPaths])
            
            //dispatch_async(dispatch_get_main_queue(), {
                //mainVC.myCollectionView.reloadItemsAtIndexPaths(indexPaths: [NSIndexPath])
            //})
        
            //Recargamos la data de Otra Vista
            NSNotificationCenter.defaultCenter().postNotificationName("load", object: nil)
            navigationController?.popViewControllerAnimated(true)
            
            
        //}
        //else {
        //    let alertController = UIAlertController(title: "GRCMóvil", message: "Datos incorrectos", preferredStyle: UIAlertControllerStyle.Alert)
        //    alertController.addAction(UIAlertAction(title: "Aceptar", style: UIAlertActionStyle.Default,handler: nil))
        //    self.presentViewController(alertController, animated: true, completion: nil)
        //}
        
    }
    
    
    //Inicializamos tipos de teclado
    func initializeTextFields(){
        txtDNI.delegate = self
        txtDNI.keyboardType = UIKeyboardType.NumberPad
        
        txtContrasena.delegate = self
        txtContrasena.keyboardType = UIKeyboardType.Default
        txtContrasena.secureTextEntry = true
    }
    
    //Ocultamos el teclado
    func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }
    
    
    //Limitando la cantidad de dígitos ingresados en DNI
    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
        
        if textField == txtDNI {
            guard let text = textField.text else { return true }
            
            let newLength = text.utf16.count + string.utf16.count - range.length
            return newLength <= 8 // Bool
        }
        else {
            return true
        }
        
    }
    
    
    //Ocultando el teclado con return/enter key
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        
        if textField == txtContrasena {
            IniciarSesionPressed(textField)
        }
        
        
        return true;
    }
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

    
    
    
    //    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
    //        // Return false if you do not want the specified item to be editable.
    //        return true
    //    }
    //
    //    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
    //        if editingStyle == .Delete {
    //            let context = self.fetchedResultsController.managedObjectContext
    //            context.deleteObject(self.fetchedResultsController.objectAtIndexPath(indexPath) as! NSManagedObject)
    //
    //            do {
    //                try context.save()
    //            } catch {
    //                // Replace this implementation with code to handle the error appropriately.
    //                // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
    //                //print("Unresolved error \(error), \(error.userInfo)")
    //                abort()
    //            }
    //        }
    //    }

}
