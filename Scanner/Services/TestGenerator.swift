//
//  TestGenerator.swift
//  Scanner
//
//  Created by Zaizen Kaegyoshi on 4/9/19.
//  Copyright © 2019 zzzz. All rights reserved.
//

import Foundation
import UIKit
import RealmSwift

class TestGenerator {
    
    static func addTags () {
        let folderTag = Tag(name: "Folder")
        let workTag = Tag(name: "Work")
        let housesTag = Tag(name: "Houses")
        
        let store = TagManager.sharedInstance
        for each in [folderTag, workTag, housesTag] {
            each.write(dataStore: store)
        }
    }
    
    static func addChildTags() {
        let realm = try! Realm()
        let realmTags = realm.objects(RealmTag.self)
        let tags = realmTags.map { (rtag) -> Tag in
            return rtag.tag
        }
//        let tag = Tag(name: "Another Tag")
//        tag.parentTag = realmTags!.tag
//        tag.write(dataStore: TagManager.sharedInstance)
        for parentTag in tags {
            let tag = Tag(name: "Another Tag")
            tag.parentTag = parentTag
            tag.write(dataStore: TagManager.sharedInstance)
            if parentTag.name == "Folder" {
                for i in 0...3 {
                    let tag = Tag(name: "Another Tag \(i)")
                    tag.parentTag = parentTag
                    tag.write(dataStore: TagManager.sharedInstance)
                }
            }
        }
    }
    
}
