//
//  Page.swift
//  Scanner
//
//  Created by Zaizen Kaegyoshi on 4/8/19.
//  Copyright © 2019 zzzz. All rights reserved.
//

import Foundation
import UIKit
import RealmSwift

class Page {
    var identifier: String = ""
    var file: File
    var pageName: String = ""
    var image: UIImage?
    var pageNumber: Int = 0
    
    init(file: File) {
        self.file = file
    }
    
}
extension Page {
    
    convenience init(realmPage: RealmPage, file: File) {
        self.init(file: file)
        self.identifier = realmPage.identifier
        self.pageName = realmPage.pageName
        self.pageNumber = realmPage.pageNumber
        
//        let index = indexPath.item
//        let files = r.objects(File.self)
        
        
        
        //        https://stackoverflow.com/questions/29005381/get-image-from-documents-directory-swift
        
        self.image = self.loadImage(imageName: self.pageName)
    }
    func loadImage(imageName: String) -> UIImage? {
        let imageName = self.pageName
        let imagePath: String = "\(NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0])/\(imageName)"
        let imageUrl: URL = URL(fileURLWithPath: imagePath)
        print(imageUrl)
        guard FileManager.default.fileExists(atPath: imagePath),
            let imageData: Data = try? Data(contentsOf: imageUrl),
            let image: UIImage = UIImage(data: imageData) else {
                print("no image found")
                // No image found!
                return nil
        }
        return image
    }
    
}
extension Page: Writable {
    func write(dataStore: DataStore) {
        dataStore.store(object: self)
    }
    func delete(dataStore: DataStore) {
        dataStore.delete(object: self)
    }
}
