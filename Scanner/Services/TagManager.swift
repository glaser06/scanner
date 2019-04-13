//
//  TagManager.swift
//  Scanner
//
//  Created by Zaizen Kaegyoshi on 4/9/19.
//  Copyright © 2019 zzzz. All rights reserved.
//

import Foundation
import UIKit
import RealmSwift

class TagManager {
    static let sharedInstance = TagManager()
    
    let realm: Realm
    
    var tags: [Tag] = []
    
    var tagDict: [String: Tag] = [:]
    
    init() {
        self.realm = try! Realm()
        self.fetchAllTags()
        NotificationCenter.default.addObserver(self, selector: #selector(fetchAllTags), name: .tagDataChanged, object: nil)
    }
    
    func printChildTags() {
        print("new print")
        for (id, tag) in self.tagDict {
            print(tag.childTags.map({ $0.name }))
        }
    }
    
    @objc func fetchAllTags() {
        let realmTags = realm.objects(RealmTag.self)
        for realmTag in realmTags {
            self.buildTagTree(parentTag: realmTag)
        }
//        printChildTags()
    }
    private func buildTagTree(parentTag: RealmTag) {
        if self.tagDict[parentTag.identifier] == nil {
            self.tagDict[parentTag.identifier] = parentTag.tag
        }
        for childTag in parentTag.tags {
            self.buildTagTree(parentTag: childTag)
            if let _ = self.tagDict[childTag.identifier] {
                self.tagDict[childTag.identifier]?.parentTag = self.tagDict[parentTag.identifier]
            } else {
                self.tagDict[childTag.identifier] = childTag.tag
                self.tagDict[childTag.identifier]!.parentTag = self.tagDict[parentTag.identifier]
            }
            
            if !self.tagDict[parentTag.identifier]!.childTags.contains(self.tagDict[childTag.identifier]!) {
                self.tagDict[parentTag.identifier]!.childTags.append(self.tagDict[childTag.identifier]!)
            }
        }
        
        
    }
    
    func realmTagFor(tag: Tag) -> RealmTag? {
        return realm.object(ofType: RealmTag.self, forPrimaryKey: tag.identifier)
    }
    func fetchFolders() -> [Tag] {
        return Array(self.tagDict.values).filter({ $0.name == "Folder" }).first!.childTags
    }
    func getFolderFor(file: File) {
        
    }
    
}
extension TagManager: DataStore {
    func store<T>(object: T) {
        guard let tag = object as? Tag else {
            return
        }
        if let existingTag = realmTagFor(tag: tag) {
//          update
            existingTag.name = tag.name
            try! realm.write {
                realm.add(existingTag, update: true)
            }
            
        } else {
            let realmTag = tag.realmTag
            if let parentTag = tag.parentTag {
                let parentRealmTag = self.realmTagFor(tag: parentTag)!
                
                
                try! realm.write {
                    parentRealmTag.tags.append(realmTag)
                    realm.add(realmTag)
                    realm.add(parentRealmTag, update: true)
                }
            } else {
                try! realm.write {
                    realm.add(realmTag)
                }
            }
            
        }
        NotificationCenter.default.post(name: .tagDataChanged, object: nil)
        
//        update
        
        
    }
    func delete<T>(object: T) {
        
    }
}

extension Notification.Name {
    static let tagDataChanged = Notification.Name(rawValue: "tagDataChanged")
}
