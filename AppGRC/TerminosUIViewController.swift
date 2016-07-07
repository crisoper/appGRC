//
//  TerminosUIViewController.swift
//  AppGRC
//
//  Created by Crisoper on 11/06/16.
//  Copyright © 2016 Crisoper. All rights reserved.
//

import UIKit
import Foundation

class TerminosUIViewController: UIViewController {
    
    let myConstants = MyClassConstants()
    
    @IBOutlet weak var viewFondo: UIScrollView!
    @IBOutlet weak var viewContent: UIView!
    //@IBOutlet weak var myTextView: UITextView!
    @IBOutlet weak var myLabel: UILabel!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = myConstants.colorFondo2
        self.viewFondo.backgroundColor = myConstants.colorFondo2
        self.viewContent.backgroundColor = myConstants.colorFondo2
        //self.myTextView.backgroundColor = myConstants.colorFondo2
        
        self.myLabel.numberOfLines = 0

        self.title = "Términos y Privacidad"
        // Do any additional setup after loading the view.
        
        //Leemos data
        guard let asset = NSDataAsset(name: "terminos") else {
            print("No se encuentra el documento")
            return
        }
        
        
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = NSTextAlignment.Justified
        
        
        let option = [
            NSDocumentTypeDocumentAttribute: NSRTFTextDocumentType,
            NSCharacterEncodingDocumentAttribute: NSUTF8StringEncoding,
            //NSTextAlignment:NSTextAlignment.Justified,
            NSParagraphStyleAttributeName:paragraphStyle
        ] as [String:AnyObject]
        
        do {
            let str = try NSAttributedString(data: asset.data, options: option, documentAttributes: nil)
            self.myLabel.attributedText = str
            //self.myTextView.editable = false
        }
        catch let err {
            print(err)
        }
        
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
