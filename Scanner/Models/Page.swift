//
//  Page.swift
//  Scanner
//
//  Created by Zaizen Kaegyoshi on 4/8/19.
//  Copyright © 2019 zzzz. All rights reserved.
//

import Foundation
import UIKit

class Page {
    
    var file: File
    var pageName: String = ""
    var path: String = ""
    var pageNumber: Int = 0
    
    init(file: File) {
        self.file = file
    }
    
}

