//
//  TabsProyectosVC.swift
//  AppGRC
//
//  Created by Crisoper on 23/07/16.
//  Copyright © 2016 Crisoper. All rights reserved.
//

import UIKit

class TabsProyectosVC: UIViewController {
    
    //Colores globales
    let myConstants = MyClassConstants()
    
    //Outlets
    @IBOutlet weak var tabs: UISegmentedControl!
    @IBOutlet weak var separador: UIView!
    @IBOutlet weak var viewContent: UIView!
    
    
    
    //Para ver que tab se ha presionado
    enum TabIndex : Int {
        case FirstChildTab = 0
        case SecondChildTab = 1
    }
    
    var currentViewController: UIViewController?
    
    lazy var firstChildTabVC: UIViewController? = {
        let firstChildTabVC = self.storyboard?.instantiateViewControllerWithIdentifier("tabDatosProyectosVCID")
        return firstChildTabVC
    }()
    
    lazy var secondChildTabVC : UIViewController? = {
        let secondChildTabVC = self.storyboard?.instantiateViewControllerWithIdentifier("tabDocumentosProyectosVCID")
        return secondChildTabVC
    }()
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.title = "Datos Proyecto"
        
        self.view.backgroundColor = myConstants.colorFondo2
        self.separador.backgroundColor = myConstants.colorIconos
        self.viewContent.backgroundColor = myConstants.colorFondo2
        
        //Cambiando la fuente de los tabs
        let font = UIFont.systemFontOfSize(13.0)
        let normalTextAttributes = [
            //NSForegroundColorAttributeName: UIColor.whiteColor(),
            NSFontAttributeName: font
        ]
        self.tabs.setTitleTextAttributes(normalTextAttributes, forState: .Normal)
        self.tabs.setTitleTextAttributes(normalTextAttributes, forState: .Highlighted)
        self.tabs.setTitleTextAttributes(normalTextAttributes, forState: .Selected)
        //Cambiamos el color
        self.tabs.tintColor = myConstants.colorIconos
        self.tabs.selectedSegmentIndex = TabIndex.FirstChildTab.rawValue
        
        displayCurrentTab(TabIndex.FirstChildTab.rawValue)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //Switch tabs
    @IBAction func tabsSwitch(sender: AnyObject) {
        self.currentViewController!.view.removeFromSuperview()
        self.currentViewController!.removeFromParentViewController()
        
        displayCurrentTab(sender.selectedSegmentIndex)
    }
    
    
    
    //Mostrar tab actual
    func displayCurrentTab(tabIndex: Int){
        if let vc = viewControllerForSelectedSegmentIndex(tabIndex) {
            
            self.addChildViewController(vc)
            vc.didMoveToParentViewController(self)
            
            vc.view.frame = self.viewContent.bounds
            self.viewContent.addSubview(vc.view)
            self.currentViewController = vc
       }
    }
    
    //Establecer el UIViewController según tab seleccionado
    func viewControllerForSelectedSegmentIndex(index: Int) -> UIViewController? {
        var vc: UIViewController?
        switch index {
        case TabIndex.FirstChildTab.rawValue :
            vc = firstChildTabVC
        case TabIndex.SecondChildTab.rawValue :
            vc = secondChildTabVC
        default:
            return nil
        }
        
        return vc
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
