//
//  Category.swift
//  Todoey
//
//  Created by macbookpro on 18/9/18.
//  Copyright © 2018 macbookpro. All rights reserved.
//

import Foundation
import RealmSwift

class Category: Object {
    @objc dynamic var name = ""
    
    let items = List<Item>()
    
}
