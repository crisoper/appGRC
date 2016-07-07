//
//  RedesViewController.swift
//  AppGRC
//
//  Created by Crisoper on 11/06/16.
//  Copyright © 2016 Crisoper. All rights reserved.
//

import UIKit

class RedesViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    
    //Iniciamos variables globales
    let myConstants = MyClassConstants()
    
    var imageButton:[String] = ["youtube", "facebook", "twitter", "paginaweb"]
    var textButtons:[String] = ["YouTube", "Facebook", "Twitter", "Pagina Web"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Redes sociales"

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    //Iniciamos construccion de la pantalla de Inicio
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        //Seteamos color de fondo
        collectionView.backgroundColor = myConstants.colorFondo2
        
        return self.textButtons.count 
        
    }
    
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("cellRedes", forIndexPath: indexPath) as! RedesCollectionViewCell
        
        //cell.backgroundColor = UIColor.yellowColor()
        
        // Use the outlet in our custom class to get a reference to the UILabel in the cell
        cell.myLabel.text = self.textButtons[indexPath.item]
        cell.myLabel.textColor = myConstants.colorTextoBotones
        cell.myLabel.backgroundColor = UIColor.clearColor()
        cell.myLabel.lineBreakMode = .ByWordWrapping
        cell.myLabel.numberOfLines = 0
        
        
        cell.myImage.image = UIImage(named: "\(self.imageButton[indexPath.item])")?.imageWithRenderingMode(UIImageRenderingMode.AlwaysTemplate)
        
        if imageButton[indexPath.row] == "twitter" {
            cell.myImage.tintColor = myConstants.colorTwitter
        }
        else if imageButton[indexPath.row] == "facebook" {
            cell.myImage.tintColor = myConstants.colorFacebook
        }
        else if imageButton[indexPath.row] == "youtube" {
            cell.myImage.tintColor = myConstants.colorYoutube
        } else {
            cell.myImage.tintColor = myConstants.colorIconos
        }
        
        
        
        
        /*
        if self.imageButton[indexPath.item] == "asistencias" || self.imageButton[indexPath.item] == "boletas" {
            cell.myImage.tintColor = myConstants.colorIconosLogueados
        } else {
            cell.myImage.tintColor = myConstants.colorIconos
        }
         */
        
        return cell
    
    }
    
    
    
    //Al seleccionar una imagen
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        
        ShowWindowCustomSegue(self.imageButton[indexPath.item] as String)
        
    }
    
    
    
    
    //Navengando a Vista Respectiva
    func ShowWindowCustomSegue (imagen:String ) {
        
        switch imagen {
            
        case "youtube":
            
            UIApplication.tryURL([
                "youtube://oHg5SJYRHA0", // App
                "https://youtube/oHg5SJYRHA0" // Website if app fails
                ])
            
            print(imagen)
            
        case "facebook":
            
            UIApplication.tryURL([
                "fb://profile/116374146706", // App
                "https://www.facebook.com/116374146706" // Website if app fails
                ])
            
        case "twitter":
            
            UIApplication.tryURL([
                "twitter://user?screen_name=@crisoper", // App
                "https://twitter.com/@crisoper" // Website if app fails
                ])
            
        case "paginaweb":
            
            UIApplication.tryURL([
                //"instagram://user?username=johndoe", // App
                "http://www.regioncajamarca.gob.pe/" // Website if app fails
                ])

        default:
            print(imagen)
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



extension UIApplication {
    class func tryURL(urls: [String]) {
        let application = UIApplication.sharedApplication()
        for url in urls {
            if application.openURL(NSURL(string: url)!) {
                
                //print("Abrimos" + url)
                
                application.openURL(NSURL(string: url)!)
                return
            }
        }
    }
}
