//
//  FileWorker.swift
//  Scanner
//
//  Created by Zaizen Kaegyoshi on 4/13/19.
//  Copyright © 2019 zzzz. All rights reserved.
//

import Foundation
import RealmSwift

class FileWorker {
    
    let realm: Realm
    
    init() {
        self.realm = try! Realm()
        
    }
    
//    func createFile() -> File{
//        
//    }
    static func newFile() -> File {
        let realmFile = RealmFile()
        let dateString = DatePresenter.fullDateString(date: realmFile.createdOn)
        realmFile.name = "Scan \(dateString)"
        print(realmFile.identifier)
        return realmFile.file
    }
    func fetchPagesFor(file: File) -> File? {
        
        if let realmFile = realm.object(ofType: RealmFile.self, forPrimaryKey: file.identifier) {
            var pages: [Page] = []
            for realmPage in realmFile.pages {
                print(realmPage.identifier)
                let page = Page(realmPage: realmPage, file: file)
                pages.append(page)
                print(page.identifier)
            }
            file.pages = pages
            return file
        }
        return nil
        
        
    }
    func fetchFolderFor(file: File) -> File? {
        if let realmFile = realm.object(ofType: RealmFile.self, forPrimaryKey: file.identifier) {
            let tagManager = TagManager.sharedInstance
            
            //            print("file tags",realmFile.tags.count)
            for realmTag in realmFile.tags {
                if tagManager.folders[realmTag.identifier] != nil {
                    file.folder = tagManager.tagDict[realmTag.identifier]
                }
            }
            
            return file
        }
        return nil
    }
    
//    clean up this function to not use private caches and dicts
    func fetchTagsFor(file: File) -> File? {
        
        if let realmFile = realm.object(ofType: RealmFile.self, forPrimaryKey: file.identifier) {
            let tagManager = TagManager.sharedInstance
            var tags: [Tag] = []
//            print("file tags",realmFile.tags.count)
            for realmTag in realmFile.tags {
                let tag = tagManager.tagDict[realmTag.identifier]!
                tags.append(tag)
                if tagManager.folders[realmTag.identifier] != nil {
                    file.folder = tagManager.tagDict[realmTag.identifier]
                }
            }
            file.tags = tags
            return file
        }
        return nil
    }
    
//    func firstImageForFile(file: File) -> UIImage {
//        return file.pages.first!.image!
//    }
//    func imagesForFiles(files: [File]) -> [UIImage] {
//        return files.map({ $0.pages.first!.image! })
//    }
    
    func addNewPagesTo(file: File, pageImages: [UIImage]) -> File {
        var pages: [Page] = []
        for (i,img) in pageImages.enumerated() {
            if i >= file.pages.count {
                let page = Page(file: file)
                page.image = img
                page.pageNumber = i
                page.pageName = "\(file.identifier)page\(page.pageNumber)"
                pages.append(page)
            }
        }
        file.pages.append(contentsOf: pages)
        return file
    }
    
    
    
    
    func saveFile(file: File) {
        
    }
    
    
    
}
