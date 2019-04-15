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

enum ListFiles
{
    // MARK: Use cases
    struct TagModel {
        var name: String
        var color: UIColor
        var count: String
    }
    struct FolderModel {
        var name: String
        var images: [UIImage] = [] 
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
            var folders: [TagModel]
            
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
