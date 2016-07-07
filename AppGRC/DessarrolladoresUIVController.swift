//
//  DessarrolladoresUIVController.swift
//  AppGRC
//
//  Created by Crisoper on 11/06/16.
//  Copyright © 2016 Crisoper. All rights reserved.
//

import UIKit

class DessarrolladoresUIVController: UIViewController {
    
    
    let myConstants = MyClassConstants()
    
    @IBOutlet weak var viewFondo: UIView!
    
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Acerca de"
        
        self.view.backgroundColor = myConstants.colorFondo2
        self.viewFondo.backgroundColor = myConstants.colorFondo2
        

        // Do any additional setup after loading the view.
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
