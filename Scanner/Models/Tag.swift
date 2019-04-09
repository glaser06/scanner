//
//  Tag.swift
//  Scanner
//
//  Created by Zaizen Kaegyoshi on 4/8/19.
//  Copyright © 2019 zzzz. All rights reserved.
//

import Foundation

class Tag {
    
    var id: String = ""
    var name: String
    var childTags: [Tag] = []
    var parentTags: [Tag] = []
    
    init() {
        self.name = ""
        self.childTags = []
    }
    
}
