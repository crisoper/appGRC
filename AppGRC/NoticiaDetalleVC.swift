//
//  NoticiaDetalleVC.swift
//  AppGRC
//
//  Created by Crisoper on 19/06/16.
//  Copyright © 2016 Crisoper. All rights reserved.
//

import UIKit

class NoticiaDetalleVC: UIViewController {

    var detalleNoticia = [String:String]()
    
    @IBOutlet weak var myWebView: UIWebView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        let localFilePath = NSBundle.mainBundle().pathForResource("Noticias", ofType: "css")
        
        let htmlString = try? String(contentsOfFile: localFilePath!, encoding: NSUTF8StringEncoding)
        
        var html = "<!DOCTYPE html><html lang=\"es\"><head><meta charset=\"UTF-8\">"
        html = html + "<title>" + self.detalleNoticia["titulo"]! + "</title>"
        html = html + "<style>" + htmlString! + "</style></head>"
        html = html + "<body><h3 class='title'>" + self.detalleNoticia["titulo"]! + "</h3>"
        html = html + "<p class=\"fecha\">" + self.detalleNoticia["fecha"]! + "</p>"
        //html = html + "<hr style=\"border-top: dotted 1px;\" />"
        //html = html + self.detalleNoticia["subtitulo"]!
        //html = html + "<hr style=\"border-top: dotted 1px;\" />"
        html = html + self.detalleNoticia["imagen"]!
        html = html + "<div class=\"descripcion\">" + self.detalleNoticia["descripcion"]! + "</div>"
        html = html + "</body></html>"
        
        
        //print(self.blogName["fecha"])
        
        
        myWebView.loadHTMLString(html as String, baseURL: nil)

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
