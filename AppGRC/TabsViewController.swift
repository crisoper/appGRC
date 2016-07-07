//
//  TabsViewController.swift
//  AppGRC
//
//  Created by Crisoper on 7/07/16.
//  Copyright © 2016 Crisoper. All rights reserved.
//

import UIKit

class TabsViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Set title
        self.title = " Expediente 9000"
        //let backItem = UIBarButtonItem()
        //backItem.title = "Something Else"
        self.navigationItem.hidesBackButton = true
        //UIBarButtonItem(image: <#T##UIImage?#>, style: <#T##UIBarButtonItemStyle#>, target: <#T##AnyObject?#>, action: <#T##Selector#>)
        //let newBackButton = UIBarButtonItem(title: "<", style: UIBarButtonItemStyle.Borderd, target: self, action: Selector("back:"))
        //self.navigationItem.leftBarButtonItem = newBackButton;
        
        //self.navigationItem.hidesBackButton = true
        //self.navigationController?.navigationBar.backIndicatorImage = UIImage(named: "izquierda")
        //self.navigationController?.navigationBar.backIndicatorTransitionMaskImage = UIImage(named: "izquierda")
        //self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "izquierda", style: UIBarButtonItemStyle.Plain, target: nil, action: nil)
        //self.navigationItem.backBarButtonItem = backItem
        
//        self.navigationItem.backBarButtonItem = backItem
        
    }
    
    
    
    func back () {
    
    
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
