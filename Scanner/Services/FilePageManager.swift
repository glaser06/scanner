//
//  FilePageManager.swift
//  Scanner
//
//  Created by Zaizen Kaegyoshi on 4/9/19.
//  Copyright © 2019 zzzz. All rights reserved.
//

import Foundation
import RealmSwift

class FilePageManager {
    
    let realm: Realm
    
    static let sharedInstance = FilePageManager()
    
    var realmFiles: Results<RealmFile>?
    
    init() {
        self.realm = try! Realm()
        realmFiles = realm.objects(RealmFile.self)
        for realmFile in self.realmFiles! {
            if let _ = fileCache[realmFile.identifier] {
                
            } else {
                
                let file = realmFile.file
                fileCache[realmFile.identifier] = " "
                fileArray.append(file)
                
            }
        }
    }
    
    var fileCache: [String: String] = [:]
    var fileArray: [File] = []
    
    func addToCache(id: String) {
        let file = realm.object(ofType: RealmFile.self, forPrimaryKey: id)
        self.fileArray.append(file!.file)
        self.fileCache[id] = " "
    }
    
    func fetchFiles () -> [File] {
        
        
//        let files = Array(fileCache.values)
        return self.fileArray
    }
    
    func realmPageFor(page: Page, parentFile: RealmFile) -> RealmPage {
        let realmPage = RealmPage()
        realmPage.file = parentFile
        realmPage.pageName = page.pageName
        realmPage.pageNumber = page.pageNumber
        realmPage.path = try! self.saveImage(name: page.pageName, img: page.image!)
        
        return realmPage

        
    }
    func saveImage(name: String, img: UIImage) throws -> String  {
        //        if let finalImg = results.enhancedImage {
        //        let scanImg = results.scannedImage
        //        let origImg = results.originalImage
        
        //        https://medium.com/@Dougly/persisting-image-data-locally-swift-3-8bae72673f8a
        let fileManager = FileManager.default
        let docUrl = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first!
        let rand = Int.random(in: 1...10000000)
        let fileName = name
        print(docUrl)
        let docPath = docUrl.path
        print(docPath)
        let filePath = docUrl.appendingPathComponent(fileName)
        print(filePath)
        
        do {
            let files = try fileManager.contentsOfDirectory(atPath: "\(docPath)")
//            for file in files {
//                print(file)
//            }
        } catch {
            print(error)
        }
        do {
            if let pngImgData = img.pngData() {
                
                try pngImgData.write(to: filePath)
                
                
                
                
                //                file.name = fileName
                //                file.path = filePath.absoluteString
                //                let realm = try Realm()
                //                try realm.write {
                //                    realm.add(file)
                //                }
                print("success save ")
                return filePath.absoluteString
            }
        }
        return ""
        //        }
    }
    func saveResizedImage(name: String, image: UIImage) -> String {
        let path = try! self.saveImage(name: name, img: image.resizeWithWidth(width: 100.0)!)
        return path
    }
    
    
}
extension FilePageManager: DataStore {
    func store<T>(object: T) {
        guard let file = object as? File else {
            return
        }
        guard !file.pages.isEmpty else {
            print("no pages")
            return
        }
        let results = realm.object(ofType: RealmFile.self, forPrimaryKey: file.identifier)
        if let realmFile = results {
//            file exists, update
        } else {
            let realmFile = RealmFile()
            if file.identifier != "" {
                realmFile.identifier = file.identifier
            }
            realmFile.name = file.name
            realmFile.cacheImageName = "\(realmFile.identifier)cacheImage"
            let firstPage = file.pages.first!
            realmFile.cacheImagePath = self.saveResizedImage(name: realmFile.cacheImageName, image: firstPage.image!)
            var realmPages: [RealmPage] = []
            for page in file.pages {
                let realmPage = self.realmPageFor(page: page, parentFile: realmFile)
                realmPages.append(realmPage)
            }
            try! realm.write {
                realm.add(realmFile)
                realm.add(realmPages)
                realmFile.pages.append(objectsIn: realmPages)
            }
            file.pages = []
            self.addToCache(id: file.identifier)
        }
        
        print("file saved")
        NotificationCenter.default.post(name: .fileDataChanged, object: nil)
    }
    
    func delete<T>(object: T) {
        
    }
}
extension Notification.Name {
    static let fileDataChanged = Notification.Name(rawValue: "fileDataChanged")
}
