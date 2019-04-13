//
//  CellDataProtocol.swift
//  Scanner
//
//  Created by Zaizen Kaegyoshi on 4/9/19.
//  Copyright © 2019 zzzz. All rights reserved.
//

import Foundation
import UIKit

protocol DisplayableCell {
    static var identifier: String { get }
    static var nibName: String { get }
}

