//
//  RealmTag.swift
//  Scanner
//
//  Created by Zaizen Kaegyoshi on 4/9/19.
//  Copyright © 2019 zzzz. All rights reserved.
//

import Foundation
import RealmSwift

class RealmTag: Object {
    
    @objc dynamic var identifier: String = UUID().uuidString
    @objc dynamic var name: String = ""
    @objc dynamic var colorID: Int = 0 
    var tags = List<RealmTag>()
    
    override static func primaryKey() -> String {
        return "identifier"
    }
}

extension RealmTag {
    
    convenience init(tag: Tag) {
        self.init()
        self.name = tag.name
        
    }
    
    var tag: Tag {
        return Tag(realmTag: self)
    }
}
