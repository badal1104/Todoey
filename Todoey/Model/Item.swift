//
//  Item.swift
//  Todoey
//
//  Created by Badal Yadav on 04/03/18.
//  Copyright © 2018 badal. All rights reserved.
//

import Foundation
import RealmSwift

class Item: Object {
    
    @objc dynamic var title: String = ""
    @objc dynamic var done: Bool = false
    @objc dynamic var dateCreated: Date = Date()
    var parentCategory = LinkingObjects.init(fromType: Category.self, property: "items")
    
}

