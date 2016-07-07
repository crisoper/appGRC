//
//  NormatividadTVC.swift
//  AppGRC
//
//  Created by Crisoper on 12/06/16.
//  Copyright © 2016 Crisoper. All rights reserved.
//

import UIKit

class NormatividadTVC: UITableViewController {
    
    let myConstants = MyClassConstants()
    var sections: [SectionNormatividad] = SectionsNormatividadData().getSectionsFromData()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Normatividad"
        
        self.view.backgroundColor = myConstants.colorFondo2

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source
    
    //Numero de secciones
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return sections.count
    }
    
    //Numero de filas por seccion
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return sections[section].items.count
    }
    
    override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sections[section].heading
    }

    //Contruimos la tabla
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath)
        cell.textLabel?.text = sections[indexPath.section].items[indexPath.row]
        cell.backgroundColor = myConstants.colorFondo2
        cell.textLabel?.font = UIFont(name: "Arial", size: 15)
        return cell
    }

    //El empezar la seleccion de una fila
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        if sections[indexPath.section].segueID == "resoluciones" {
            
            let resoluciones = ResolucionesTVC()
            resoluciones.title = sections[indexPath.section].items[indexPath.row]
            
            self.performSegueWithIdentifier("resoluciones", sender: self)
        }
        else if sections[indexPath.section].segueID == "consejo" {
            print("Mostramos lista de Consejo")
        }
        
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

    /*
    // MARK: - Navigation
     */
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
        if  segue.identifier == "resoluciones" {
            print(segue.identifier)
//            let path = tableView.indexPathForSelectedRow
//            let cell = tableView.cellForRowAtIndexPath(path!)
//            titulo = (cell?.textLabel?.text)!
            
        }
        
        
    }
    
 
 

}
