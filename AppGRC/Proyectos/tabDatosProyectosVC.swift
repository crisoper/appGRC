//
//  tabDatosProyectosVC.swift
//  AppGRC
//
//  Created by Crisoper on 23/07/16.
//  Copyright © 2016 Crisoper. All rights reserved.
//

import UIKit

class tabDatosProyectosVC: UIViewController {

    //Colores globales
    let myConstants = MyClassConstants()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.view.backgroundColor = myConstants.colorFondo2
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
