//
//  TabySegmentedControl.swift
//  AppGRC
//
//  Created by Crisoper on 7/07/16.
//  Copyright © 2016 Crisoper. All rights reserved.
//

import UIKit

class TabySegmentedControl: UISegmentedControl {

    func initUI(){
        //setupBackground()
        setupFonts()
    }
    
    /*
    func setupBackground(){
        let backgroundImage = UIImage(named: "segmented_unselected_bg")
        let dividerImage = UIImage(named: "segmented_separator_bg")
        let backgroundImageSelected = UIImage(named: "segmented_selected_bg")
        
        self.setBackgroundImage(backgroundImage, forState: .Normal, barMetrics: .Default)
        self.setBackgroundImage(backgroundImageSelected, forState: .Highlighted, barMetrics: .Default)
        self.setBackgroundImage(backgroundImageSelected, forState: .Selected, barMetrics: .Default)
        
        self.setDividerImage(dividerImage, forLeftSegmentState: .Normal, rightSegmentState: .Selected, barMetrics: .Default)
        self.setDividerImage(dividerImage, forLeftSegmentState: .Selected, rightSegmentState: .Normal, barMetrics: .Default)
        self.setDividerImage(dividerImage, forLeftSegmentState: .Normal, rightSegmentState: .Normal, barMetrics: .Default)
    }
     */
    
    func setupFonts(){
        let font = UIFont.systemFontOfSize(12.0)
        
        
        let normalTextAttributes = [
            NSForegroundColorAttributeName: UIColor.blackColor(),
            NSFontAttributeName: font
        ]
        
        self.setTitleTextAttributes(normalTextAttributes, forState: .Normal)
        self.setTitleTextAttributes(normalTextAttributes, forState: .Highlighted)
        self.setTitleTextAttributes(normalTextAttributes, forState: .Selected)
    }
    
    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */

}
