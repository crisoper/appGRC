//
//  LoadfilesViewController.swift
//  AppGRC
//
//  Created by Crisoper on 15/06/16.
//  Copyright © 2016 Crisoper. All rights reserved.
//

import UIKit

var url:String?
class LoadfilesViewController: UIViewController {
    
    @IBOutlet weak var myWebView: UIWebView!
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Documento"
        
        
        url = "http://www.regioncajamarca.gob.pe/sites/default/files/comunicados/documentos/APTOS-HOJAVIDA%20-%20TERCERACONVOCATORIACAS-2016.pdf"
        
        abrirDocumento(url!)
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func abrirDocumento(url:String) {
        
        //Traemos la data desde un Json
        let aurl = NSURL(string: url)
//        let task = NSURLSession.sharedSession().dataTaskWithURL(url!) { (data, response, error) in
//            if error != nil {
//                print(error)
//            }
//            else {
//                    dispatch_async(dispatch_get_main_queue(), {
//                        self.myWebView.load
//                    })
//                }
//            }
//        }
//        
//        task.resume()
    
        
//        var html = "<p>estamos en un webview... </p>"
//        html = html + "<p>estamos en un webview... </p>"
//        html = html + "<p>estamos en un webview... </p>"
//        html = html + "<p>estamos en un webview... </p>"
//        html = html + "<p>estamos en un webview... </p>"
//        html = html + "<p>estamos en un webview... </p>"
//        
//        
//        self.myWebView.loadHTMLString(html, baseURL: nil)
        
        
        self.myWebView.loadRequest(NSURLRequest(URL: aurl!))
        
        self.myWebView.frame.origin.y = 0
        // = CGRectMake(0 , 0, self.view.frame.width, self.view.frame.height)

        
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
