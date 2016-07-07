//
//  ResolucionesTVC.swift
//  AppGRC
//
//  Created by Crisoper on 13/06/16.
//  Copyright © 2016 Crisoper. All rights reserved.
//

import UIKit

class ResolucionesTVC: UITableViewController {
    
    //Accedemos a constantes globales
    let myConstants = MyClassConstants()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //self.title = "Normatividad"
        
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

}
