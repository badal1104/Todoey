//
//  ItemModel.swift
//  Todoey
//
//  Created by Badal Yadav on 18/02/18.
//  Copyright © 2018 badal. All rights reserved.
//

import UIKit

class ItemModel: NSObject,Codable {

    var title = ""
    var done = false
    
    init(titleString : String, doneFlag : Bool) {
        
        title = titleString
        done = doneFlag
        
    }
    
    
}
