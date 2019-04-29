//
//  RealmFile.swift
//  Scanner
//
//  Created by Zaizen Kaegyoshi on 4/9/19.
//  Copyright © 2019 zzzz. All rights reserved.
//

import Foundation
import RealmSwift

class RealmFile: Object {
    
    @objc dynamic var identifier: String = UUID().uuidString
    @objc dynamic var name: String = ""
    @objc dynamic var createdOn: Date = Date()
    @objc dynamic var lastUpdated: Date = Date()
    @objc dynamic var notes: String = ""
    
    @objc dynamic var cacheImageName: String = ""
    @objc dynamic var cacheImagePath: String = ""
    var pages = List<RealmPage>()
    var tags = List<RealmTag>()
    
    override static func primaryKey() -> String {
        return "identifier"
    }
    
}
extension RealmFile {
    var file: File {
        return File(realmFile: self)
    }
}
