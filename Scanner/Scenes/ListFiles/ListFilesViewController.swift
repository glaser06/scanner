//
//  ListFilesViewController.swift
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

protocol ListFilesDisplayLogic: class
{
    
}

class ListFilesViewController: UIViewController, ListFilesDisplayLogic
{
    var interactor: ListFilesBusinessLogic?
    var router: (NSObjectProtocol & ListFilesRoutingLogic & ListFilesDataPassing)?
    
    // MARK: Object lifecycle
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?)
    {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder)
    {
        super.init(coder: aDecoder)
        setup()
    }
    
    // MARK: Setup
    
    private func setup()
    {
        let viewController = self
        let interactor = ListFilesInteractor()
        let presenter = ListFilesPresenter()
        let router = ListFilesRouter()
        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        presenter.viewController = viewController
        router.viewController = viewController
        router.dataStore = interactor
    }
    
    // MARK: Routing
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        if let scene = segue.identifier {
            let selector = NSSelectorFromString("routeTo\(scene)WithSegue:")
            if let router = router, router.responds(to: selector) {
                router.perform(selector, with: segue)
            }
        }
    }
    
    // MARK: View lifecycle
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        let cellsToRegister: Array<DisplayableCell.Type> = [
            TagCollectionTableViewCell.self,
            FolderCollectionTableViewCell.self
        ]
        
        self.setupTableView(tableView: self.allTableView, cellsToRegister: cellsToRegister, estimatedHeight: 120)
        
        self.fetchTags()
        
        
    }

    func setupTableView(tableView: UITableView, cellsToRegister: Array<DisplayableCell.Type>, estimatedHeight: CGFloat?) {
        if let h = estimatedHeight {
            tableView.rowHeight = UITableView.automaticDimension
            tableView.estimatedRowHeight = h
        }
        for cellType in cellsToRegister {
            tableView.register(UINib(nibName: cellType.nibName, bundle: nil), forCellReuseIdentifier: cellType.identifier)
        }
    }
    
    func fetchTags() {
        self.interactor?.fetchTags()
    }
    
    
    // MARK: Do something
    
    // MARK: Outlets
    
    @IBOutlet weak var allTableView: UITableView!
    
    
    //@IBOutlet weak var nameTextField: UITextField!
    
    
}

extension ListFilesViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let row = indexPath.row
        switch row {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: TagCollectionTableViewCell.identifier) as! TagCollectionTableViewCell
//            cell.setCell(collectionHandler: )
            return cell
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: FolderCollectionTableViewCell.identifier) as! FolderCollectionTableViewCell
            return cell
        default:
            return UITableViewCell()
        }
    }
}
extension ListFilesViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
    }
    
}

