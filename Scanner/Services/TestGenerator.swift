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
        let realm = try! Realm()
        try! realm.write {
            realm.delete(realm.objects(RealmTag.self))
        }
        
        let folderTag = Tag(name: "Folder")
        let workTag = Tag(name: "Work")
        let housesTag = Tag(name: "Houses")
        let another = Tag(name: "Another Tag")
        let receipts = Tag(name: "Receipts")
        var tags: [Tag] = []
        for i in 0...10 {
            let tag = Tag(name: "another \(i)")
            tags.append(tag)
        }
        tags.append(contentsOf: [folderTag, workTag, housesTag, another, receipts])
        
        
        let store = TagManager.sharedInstance
        for each in  tags {
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
            
            if parentTag.name == "Folder" {
                for i in 0...4 {
                    let tag = Tag(name: "Another Tag \(i)")
                    tag.parentTag = parentTag
                    tag.write(dataStore: TagManager.sharedInstance)
                }
            }
        }
    }
    
    
}

