//
//  File.swift
//  Scanner
//
//  Created by Zaizen Kaegyoshi on 4/8/19.
//  Copyright © 2019 zzzz. All rights reserved.
//

import Foundation
import UIKit

class File {
    var identifier: String = ""
    var name: String
    var notes: String = ""
    var pages: [Page]
    var date: Date
    var tags: [Tag]
    var folder: Tag?
    var cacheImage: UIImage?
    
    init() {
        self.name = ""
        self.pages = []
        self.tags = []
        self.date = Date()
    }
    
    
    
}
extension File {
    
    convenience init(realmFile: RealmFile) {
        self.init()
        self.name = realmFile.name
        self.identifier = realmFile.identifier
        self.date = realmFile.createdOn
        self.notes = realmFile.notes
//        for realmPage in realmFile.pages {
//            let page = Page(realmPage: realmPage, file: self)
//            self.pages.append(page)
//        }
        self.cacheImage = self.loadImage(imageName: realmFile.cacheImageName)
    }
    func loadImage(imageName: String) -> UIImage? {
        
        let imagePath: String = "\(NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0])/\(imageName)"
        let imageUrl: URL = URL(fileURLWithPath: imagePath)
//        print(imageUrl)
        guard FileManager.default.fileExists(atPath: imagePath),
            let imageData: Data = try? Data(contentsOf: imageUrl),
            let image: UIImage = UIImage(data: imageData) else {
                print("no image found")
                // No image found!
                return nil
        }
        print(self.name, imageData.count/1024)
        return image
    }
    
    
    
    
}
extension File: Writable {
    func write(dataStore: DataStore) {
        dataStore.store(object: self)
    }
    func delete(dataStore: DataStore) {
        dataStore.delete(object: self)
    }
}
extension File: CustomStringConvertible {
    var description: String {
        return "File \(self.name) \(self.pages.count) pages"
    }
}


