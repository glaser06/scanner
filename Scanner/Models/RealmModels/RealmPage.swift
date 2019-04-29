//
//  RealmPage.swift
//  Scanner
//
//  Created by Zaizen Kaegyoshi on 4/9/19.
//  Copyright © 2019 zzzz. All rights reserved.
//

import Foundation
import RealmSwift

class RealmPage: Object {
    
    @objc dynamic var identifier: String = UUID().uuidString
    @objc dynamic var path: String = ""
    @objc dynamic var pageName: String = ""
    @objc dynamic var pageNumber: Int = 0
//    @objc dynamic var file: RealmFile?
    let file = LinkingObjects(fromType: RealmFile.self, property: "pages")
    
    override static func primaryKey() -> String {
        return "identifier"
    }
}

