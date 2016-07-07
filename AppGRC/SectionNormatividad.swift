//
//  SectionNoticias.swift
//  AppGRC
//
//  Created by Crisoper on 13/06/16.
//  Copyright © 2016 Crisoper. All rights reserved.
//

import Foundation

struct SectionNormatividad {
    
    var heading : String
    var segueID : String
    var items : [String]
    
    init(title: String, segue:String, objects : [String]) {
        
        heading = title
        segueID = segue
        items = objects
    }
}