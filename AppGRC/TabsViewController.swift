//
//  TabsViewController.swift
//  AppGRC
//
//  Created by Crisoper on 7/07/16.
//  Copyright © 2016 Crisoper. All rights reserved.
//

import UIKit

class TabsViewController: UIViewController {
    
    //Para colores de fondo
    let myConstants = MyClassConstants()
    
    @IBOutlet weak var tabs: UISegmentedControl!
    @IBOutlet weak var viewContent: UIView!
    
    //Para ver que tab se ha presionado
    enum TabIndex : Int {
        case FirstChildTab = 0
        case SecondChildTab = 1
        case ThirdChildTab = 2
        case FourthChildTab = 3
    }
    
    
    var currentViewController: UIViewController?
    lazy var firstChildTabVC: UIViewController? = {
        let firstChildTabVC = self.storyboard?.instantiateViewControllerWithIdentifier("FirstViewControllerId")
        return firstChildTabVC
    }()
    
    lazy var secondChildTabVC : UIViewController? = {
        let secondChildTabVC = self.storyboard?.instantiateViewControllerWithIdentifier("SecondViewControllerId")
        return secondChildTabVC
    }()
    
    lazy var thirdChildTabVC : UIViewController? = {
        let thirdChildTabVC = self.storyboard?.instantiateViewControllerWithIdentifier("ThirdTabViewControllerId")
        return thirdChildTabVC
    }()
    
    lazy var fourthChildTabVC : UIViewController? = {
        let fourthChildTabVC = self.storyboard?.instantiateViewControllerWithIdentifier("FourthTabViewControllerID")
        return fourthChildTabVC
    }()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Set title
        self.title = " Expediente 9000"
        
        //Cambiando el botón de regreso
        //self.navigationItem.hidesBackButton = true
        //let imageButtonBack =  UIImage(named: "izquierda")
        //let customBackItem = UIBarButtonItem(image: imageButtonBack, style: UIBarButtonItemStyle.Plain, target: self, action: #selector(TabsViewController.botonRegresar(_:)))
        //self.navigationItem.leftBarButtonItem = customBackItem
        
        
        //Cambiando la fuente de los tabs
        let font = UIFont.systemFontOfSize(12.0)
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
    
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        if let currentViewController = currentViewController {
            currentViewController.viewWillDisappear(animated)
        }
    }
    
    
    @IBAction func switchTabs(sender: AnyObject) {
        
        self.currentViewController!.view.removeFromSuperview()
        self.currentViewController!.removeFromParentViewController()
        
        displayCurrentTab(sender.selectedSegmentIndex)
        
    }
    
    
    
    func displayCurrentTab(tabIndex: Int){
        if let vc = viewControllerForSelectedSegmentIndex(tabIndex) {
            
            self.addChildViewController(vc)
            vc.didMoveToParentViewController(self)
            
            vc.view.frame = self.viewContent.bounds
            self.viewContent.addSubview(vc.view)
            self.currentViewController = vc
        }
    }
    
    
    func viewControllerForSelectedSegmentIndex(index: Int) -> UIViewController? {
        var vc: UIViewController?
        switch index {
        case TabIndex.FirstChildTab.rawValue :
            vc = firstChildTabVC
        case TabIndex.SecondChildTab.rawValue :
            vc = secondChildTabVC
        case TabIndex.ThirdChildTab.rawValue:
            vc = thirdChildTabVC
        case TabIndex.FourthChildTab.rawValue:
            vc = fourthChildTabVC
        default:
            return nil
        }
        
        return vc
    }
    
    
    
    
    
    
    
    
    //Cambiar tamaño imagen
    func ResizeImage(image: UIImage, targetSize: CGSize) -> UIImage {
        let size = image.size
        
        let widthRatio  = targetSize.width  / image.size.width
        let heightRatio = targetSize.height / image.size.height
        
        // Figure out what our orientation is, and use that to form the rectangle
        var newSize: CGSize
        if(widthRatio > heightRatio) {
            newSize = CGSizeMake(size.width * heightRatio, size.height * heightRatio)
        } else {
            newSize = CGSizeMake(size.width * widthRatio,  size.height * widthRatio)
        }
        
        // This is the rect that we've calculated out and this is what is actually used below
        let rect = CGRectMake(0, 0, newSize.width, newSize.height)
        
        // Actually do the resizing to the rect using the ImageContext stuff
        UIGraphicsBeginImageContextWithOptions(newSize, false, 1.0)
        image.drawInRect(rect)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return newImage
    }
    
    
    
    
    func botonRegresar (barButtonItem: UIBarButtonItem) {
        //print("Cerrando ventana")
        navigationController?.popViewControllerAnimated(true)
        //self.dismissViewControllerAnimated(true, completion: nil)
    }

    
}
