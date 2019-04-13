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
        let folders = self.tagManager.fetchFolders()
        print(folders)
    }
    
}
