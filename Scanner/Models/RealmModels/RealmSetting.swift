//
//  RealmSetting.swift
//  Scanner
//
//  Created by Zaizen Kaegyoshi on 4/14/19.
//  Copyright © 2019 zzzz. All rights reserved.
//

import Foundation

import RealmSwift

class RealmSetting: Object {
    
    @objc dynamic var identifier: String = UUID().uuidString
    
    @objc dynamic var defaultNameTemplate: RealmNameTemplate?
    
    
    
    override static func primaryKey() -> String {
        return "identifier"
    }
}
