//
//  File.swift
//  Scanner
//
//  Created by Zaizen Kaegyoshi on 4/8/19.
//  Copyright © 2019 zzzz. All rights reserved.
//

import Foundation
import UIKit

class File {
    var identifier: String = ""
    var name: String
    var pages: [Page]
    var tags: [Tag]
    
    init() {
        self.name = ""
        self.pages = []
        self.tags = [] 
    }
    
    
    
}
extension File {
    
    convenience init(realmFile: RealmFile) {
        self.init()
        self.name = realmFile.name
        self.identifier = realmFile.identifier
        for realmPage in realmFile.pages {
            let page = Page(realmPage: realmPage, file: self)
            self.pages.append(page)
        }
    }
    
}
