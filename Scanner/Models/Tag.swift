//
//  Tag.swift
//  Scanner
//
//  Created by Zaizen Kaegyoshi on 4/8/19.
//  Copyright © 2019 zzzz. All rights reserved.
//

import Foundation

class Tag {
    
    var identifier: String = ""
    var name: String
    
    var childTags: [Tag] = []
    var parentTag: Tag?
    
    init() {
        self.name = ""
        
    }
    init(name: String) {
        self.name = name
    }
    
}
extension Tag {
    convenience init (realmTag: RealmTag ){
        self.init(name: realmTag.name)
        self.identifier = realmTag.identifier
    }
    var realmTag: RealmTag {
        return RealmTag(tag: self)
    }
    
}
extension Tag: Equatable {
    static func == (lhs: Tag, rhs: Tag) -> Bool {
        return lhs.identifier == rhs.identifier
    }
    
    
}
extension Tag: Writable {
    func write(dataStore: DataStore) {
        dataStore.store(object: self)
    }
    func delete(dataStore: DataStore) {
        dataStore.delete(object: self)
    }
}
extension Tag: CustomStringConvertible {
    var description: String {
        return self.name
    }
}
