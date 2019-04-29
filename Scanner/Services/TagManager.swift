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
    
    var folders: [String: Tag] = [:]
    
    
    
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
//        self.fetchAllFolders()
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
    func fetchAllFolders() {
        let topFolder = self.fetchTopFolderTag()
        var children = topFolder.childTags
        while !children.isEmpty {
            var nextVisit: [Tag] = []
            for folder in children {
                self.folders[folder.identifier] = folder
                nextVisit = nextVisit + folder.childTags
            }
            children = nextVisit
        }
    }
    func fetchTopFolders() -> [Tag] {
        
        return Array(self.tagDict.values).filter({ $0.name == "Folder" }).first!.childTags
    }
    func fetchTopFolderTag() -> Tag {
        return self.tagDict.values.filter({$0.name == "Folder"}).first!
    }
    func fetchTags() -> [Tag] {
        var folders = self.fetchTopFolders().map { (t) -> String in
            return t.identifier
        }
        folders.append(self.fetchTopFolderTag().identifier)
        let folderSet = Set(folders)
        let allTags = Set(self.tagDict.keys)
        let tags = allTags.subtracting(folderSet)
        
        return Array(self.tagDict.filter({tags.contains($0.key)}).values)
    }
//    returns index, tag of the folder tag
    func getFolderFor(file: File) -> (index: Int, tag: Tag?) {
        for (index, tag) in file.tags.enumerated() {
            if self.folders[tag.identifier] != nil {
                return (index, tag)
            }
        }
        return (-1, nil)
    }
    func isFolder(tag: Tag) -> Bool {
        return self.folders[tag.identifier] != nil
    }
    
    func filesForTag(tag: Tag) -> [File] {
        let realmFiles = realm.object(ofType: RealmTag.self, forPrimaryKey: tag.identifier)?.files
        
        let files = realmFiles?.map({ (r) -> File in
            return r.file
        })
        return Array(files!)
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
