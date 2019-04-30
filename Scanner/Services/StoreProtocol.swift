//
//  StoreProtocol.swift
//  Scanner
//
//  Created by Zaizen Kaegyoshi on 3/29/19.
//  Copyright © 2019 zzzz. All rights reserved.
//

import Foundation

protocol DataStore {
    func store<T>(object: T)
    func delete<T>(object: T)
    
}
protocol Writable {
    func write(dataStore: DataStore)
    func delete(dataStore: DataStore)
}
