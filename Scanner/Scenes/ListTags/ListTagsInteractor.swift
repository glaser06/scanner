//
//  ListTagsInteractor.swift
//  Scanner
//
//  Created by Zaizen Kaegyoshi on 4/17/19.
//  Copyright (c) 2019 zzzz. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit

protocol ListTagsBusinessLogic
{
    func fetchTags()
    func selectTags(request: ListTags.SelectTags.Request)
}

protocol ListTagsDataStore
{
    var tags: [Tag]! { get set }
    var file: File? { get set }
    var showingFolders: Bool { get set }
}

class ListTagsInteractor: ListTagsBusinessLogic, ListTagsDataStore
{
    var presenter: ListTagsPresentationLogic?
    var worker: ListTagsWorker?
    //var name: String = ""
    var tagManager: TagManager = TagManager.sharedInstance
    var tags: [Tag]!
    var file: File?
    var showingFolders: Bool = false
    
    // MARK: Do something
    
    func fetchTags() {
        if self.tags != nil {
            
        } else {
            self.tags = self.tagManager.fetchTags()
        }
        
        var tagWithSelected: [(Tag, Bool)] = []
        if let f = self.file {
            tagWithSelected = self.tags.map({ (tag) -> (Tag, Bool) in
                if f.tags.contains(tag) {
                    return (tag, true)
                } else {
                    return (tag, false)
                }
            })
        } else {
            tagWithSelected = self.tags.map({ (tag) -> (Tag, Bool) in
                return (tag, false)
            })
        }
        self.presenter?.presentTags(response: ListTags.FetchTags.Response.init(tags: tagWithSelected, showingFolders: self.showingFolders))
    }
    func selectTags(request: ListTags.SelectTags.Request) {
        
        if self.showingFolders {
            let (index, folder) = tagManager.getFolderFor(file: self.file!)
            if index == -1 {
                for (index, tags) in request.selectedTags.enumerated() {
                    if tags.selected {
                        self.file?.tags.append(self.tags[index])
                    }
                }
                
            } else {
                self.file?.tags.remove(at: index)
                for (index, tags) in request.selectedTags.enumerated() {
                    if tags.selected {
                        self.file?.tags.append(self.tags[index])
                    }
                }
            }
        } else {
            var selectedTags: [Tag] = []
            for (i,tagModel) in request.selectedTags.enumerated() {
                if tagModel.selected {
                    selectedTags.append(self.tags[i])
                }
            }
            
            if self.file != nil {
                let (index, folder) = tagManager.getFolderFor(file: self.file!)
                if let f = folder {
                    selectedTags.append(f)
                }
            }
            self.file?.tags = selectedTags
        }
        
        self.presenter?.dismiss()
    }
}