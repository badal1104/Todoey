//
//  Category.swift
//  Todoey
//
//  Created by Badal Yadav on 04/03/18.
//  Copyright © 2018 badal. All rights reserved.
//

import Foundation
import RealmSwift

class Category: Object {
    
  @objc dynamic var name: String = ""
    let items = List<Item>()
    
    
}
