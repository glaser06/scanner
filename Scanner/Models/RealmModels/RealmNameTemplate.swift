//
//  RealmNameTemplate.swift
//  Scanner
//
//  Created by Zaizen Kaegyoshi on 4/9/19.
//  Copyright © 2019 zzzz. All rights reserved.
//

import Foundation
import RealmSwift

class RealmNameTemplate: Object {
    
    @objc dynamic var identifier: String = UUID().uuidString
    @objc dynamic var defaultName: String = ""
    
    override static func primaryKey() -> String {
        return "identifier"
    }
}
