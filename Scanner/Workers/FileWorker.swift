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
    
//    func firstImageForFile(file: File) -> UIImage {
//        return file.pages.first!.image!
//    }
//    func imagesForFiles(files: [File]) -> [UIImage] {
//        return files.map({ $0.pages.first!.image! })
//    }
    
    func addPagesTo(file: File, pageImages: [UIImage]) -> File {
        var pages: [Page] = []
        for img in pageImages {
            let page = Page(file: file)
            page.image = img
            page.pageName = "\(file.identifier)page\(page.pageNumber)"
            pages.append(page)
        }
        file.pages = pages
        return file
    }
    
    func saveFile(file: File) {
        
    }
    
    
    
}
