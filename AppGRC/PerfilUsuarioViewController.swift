//
//  PerfilUsuarioViewController.swift
//  AppGRC
//
//  Created by Crisoper on 10/06/16.
//  Copyright © 2016 Crisoper. All rights reserved.
//

import UIKit
import CoreData

class PerfilUsuarioViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "Perfil usuario"
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    //Cerramos sesión
    @IBAction func CerrarSesion(sender: AnyObject) {
        
        //Eliminamos todos los datos de User
        let appDel:AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        //Contexto (interfaz) desde el cual accedemos a CoreData
        let context:NSManagedObjectContext = appDel.managedObjectContext
        
        let request = NSFetchRequest(entityName: "User") //Consultando datos de coredata

        if let results = try? context.executeFetchRequest(request) where results.count > 0 {
            
            for item in results {
                context.deleteObject(item as! NSManagedObject)
            }
            _ = try? context.save()
            
            
            //Recargamos la data de la Vista Principal
            NSNotificationCenter.defaultCenter().postNotificationName("load", object: nil)
            navigationController?.popViewControllerAnimated(true)

        } //Fin CoreData
        else {
            let alertController = UIAlertController(title: "GRCMóvil", message: "Error al cerrar sesión", preferredStyle: UIAlertControllerStyle.Alert)
            alertController.addAction(UIAlertAction(title: "Aceptar", style: UIAlertActionStyle.Default,handler: nil))
            self.presentViewController(alertController, animated: true, completion: nil)
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
