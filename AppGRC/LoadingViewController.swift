//
//  LoadingViewController.swift
//  AppGRC
//
//  Created by Crisoper on 12/06/16.
//  Copyright © 2016 Crisoper. All rights reserved.
//

import UIKit

class LoadingViewController: UIViewController, PopupContentViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.layer.cornerRadius = 4

        // Do any additional setup after loading the view.
    }
    
    
//    override func viewDidAppear(animated: Bool) {
//        super.viewDidAppear(animated)
//        self.view.layer.cornerRadius = 4
//        self.view.backgroundColor = UIColor.redColor()
//    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    class func instance() -> LoadingViewController {
        let storyboard = UIStoryboard(name: "Loading", bundle: nil)
        print(storyboard)
        return storyboard.instantiateInitialViewController() as! LoadingViewController
    }
    
    func sizeForPopup(popupController: PopupController, size: CGSize, showingKeyboard: Bool) -> CGSize {
        return CGSizeMake(150,150)
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

//Extenion que permite mostrar este StoryBoard como Popup
//extension LoadingViewController: PopupContentViewController {
//    func sizeForPopup(popupController: PopupController, size: CGSize, showingKeyboard: Bool) -> CGSize {
//        return CGSizeMake(self.view.frame.width - 10, self.view.frame.height - 10)
//    }
//}
