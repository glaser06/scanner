//
//  ListFilesInteractor.swift
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

protocol ListFilesBusinessLogic
{
    func fetchTags()
    func fetchFiles()
}

protocol ListFilesDataStore
{
    //var name: String { get set }
}

class ListFilesInteractor: ListFilesBusinessLogic, ListFilesDataStore
{
    var presenter: ListFilesPresentationLogic?
    var worker: ListFilesWorker?
    var tagManager: TagManager = TagManager.sharedInstance
    
    //var name: String = ""
    
    // MARK: Do something
    func fetchTags() {
        let tags = self.tagManager.fetchTags()
        let folders = self.tagManager.fetchTopFolders()
        
        
        self.presenter?.presentTags(response: ListFiles.FetchTags.Response.init(tags: tags, folders: folders ))
    }
    func fetchFiles() {
        let fileManager: FilePageManager = FilePageManager.sharedInstance
        var files = fileManager.fetchFiles()
        files = files.filter({ (file) -> Bool in
            return file.folder == nil
        })
        self.presenter?.presentFiles(response: files)
    }
    
}
