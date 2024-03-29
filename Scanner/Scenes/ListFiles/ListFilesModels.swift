//
//  ListFilesModels.swift
//  Scanner
//
//  Created by Zaizen Kaegyoshi on 4/8/19.
//  Copyright (c) 2019 zzzz. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit

protocol ItemModel {
    static func empty() -> ItemModel
//    static var empty: ItemModel { get set }
}
enum ListFiles
{
    // MARK: Use cases
    
    struct TagModel: ItemModel {
        
        
        var name: String
        var color: UIColor
        var count: String
        static func empty() -> ItemModel {
            return TagModel(name: "", color: UIColor.clear, count: "0")
        }
        
    }
    struct FolderModel: ItemModel {
        var name: String
        var images: [UIImage] = []
        static func empty() -> ItemModel {
            return FolderModel(name: "", images: [])
        }
    }
    struct FileModel {
        var name: String
        var date: String
        var image: UIImage
    }
    enum FetchTags {
        struct Request
        {
        }
        struct Response
        {
            var tags: [Tag]
            var folders: [Tag]
            
        }
        struct ViewModel
        {
            var tags: [TagModel]
            var folders: [FolderModel]
            
        }
    }
    enum FetchFiles {
        struct Request
        {
        }
        struct Response
        {
            var files: [File]
            
        }
        struct ViewModel
        {
            var files: [File]
            
        }
    }
    
    enum Something
    {
        struct Request
        {
        }
        struct Response
        {
        }
        struct ViewModel
        {
        }
    }
}
