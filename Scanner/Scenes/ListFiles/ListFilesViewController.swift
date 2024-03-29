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
    func displayTags(vm: ListFiles.FetchTags.ViewModel)
    func displayFiles(vm: [File])
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
        self.tagSources = TagCollectionSource(cellID: MainTagCollectionViewCell.identifier, emptyData: ListFiles.TagModel.empty())
        self.folderSources = TagCollectionSource(cellID: FolderCollectionViewCell.identifier, emptyData: ListFiles.FolderModel.empty())
        let cellsToRegister: Array<DisplayableCell.Type> = [
            TagCollectionTableViewCell.self,
            FolderCollectionTableViewCell.self,
            FileTableViewCell.self
        ]
        
        self.setupTableView(tableView: self.allTableView, cellsToRegister: cellsToRegister, estimatedHeight: nil)
        self.allTableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 140, right: 0)
        
        self.fetchTags()
        self.fetchFiles()
        
        self.setupExpandingMenu()
        
        
        NotificationCenter.default.addObserver(self, selector: #selector(fetchTags), name: .tagDataChanged, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(fetchFiles), name: .fileDataChanged, object: nil)
        
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
    
    @objc func fetchTags() {
        self.interactor?.fetchTags()
    }
    @objc func fetchFiles() {
        self.interactor?.fetchTags()
        self.interactor?.fetchFiles()
    }
    
    
    // MARK: Do something
    var files: [File] = []
    
    var tagSources: TagCollectionSource?
    var folderSources: TagCollectionSource?
    
    var folderHeight: CGFloat = 180
    
    var longPressMenuGesture: UILongPressGestureRecognizer?
    var cancelTapGesture: UITapGestureRecognizer?
    var isMenuExpanded: Bool = false
    
    // MARK: Outlets
    
    @IBOutlet weak var allTableView: UITableView!
    
    //add button sizing
    @IBOutlet weak var menuButton: UIButton!
    @IBOutlet weak var menuButtonHeight: NSLayoutConstraint!
    @IBOutlet weak var menuButtonVerticalPosition: NSLayoutConstraint!
    @IBOutlet weak var menuViewHeight: NSLayoutConstraint!
    @IBOutlet weak var menuViewVerticalPosition: NSLayoutConstraint!
    @IBOutlet weak var menuView: UIView!
    
    
    
    @IBAction func addFile () {
        if self.isMenuExpanded {
            self.hideMenu(sender: nil)
        } else {
            UIView.setAnimationsEnabled(false)
            self.performSegue(withIdentifier: "ShowFile", sender: nil)
            UIView.setAnimationsEnabled(true)
        }
        
    }
    func setupExpandingMenu() {
//        let pressGesture = UILongPressGestureRecognizer(target: self, action: #selector(showMenu))
//        pressGesture.minimumPressDuration = 0.4
//        self.menuButton.addGestureRecognizer(pressGesture)
//        self.longPressMenuGesture = pressGesture
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(addFile))
        self.menuButton.addGestureRecognizer(tapGesture)
//        self.cancelTapGesture = UITapGestureRecognizer(target: self, action: #selector(hideMenu))
//        cancelTapGesture!.cancelsTouchesInView = false
//        self.allTableView.addGestureRecognizer(cancelTapGesture!)
        
    }
    @IBAction func showMenu() {
//        self.menuButtonVerticalPosition.constant = -8
//        self.menuButtonHeight.constant = 40
//        self.menuButton.cornerRadius = 20
        self.menuButton.isHidden = true
        self.menuViewHeight.constant = self.view.bounds.width - 64
        self.menuViewVerticalPosition.constant = -64
        self.menuView.cornerRadius = 7
        self.isMenuExpanded = true
        self.cancelTapGesture!.cancelsTouchesInView = true
        UIView.animate(withDuration: 0.2, animations: {
            self.view.setNeedsLayout()
            self.view.layoutIfNeeded()
        }) { (finished) in
            
//            self.longPressMenuGesture?.isEnabled = !(self.menuButtonHeight.constant == 40)
//            self.isMenuExpanded = !self.isMenuExpanded
        }
        if self.isMenuExpanded {
            
            
        } else {
            
            
            
        }
        
        
    }
    @objc func hideMenu(sender: UITapGestureRecognizer?) {
        
        if self.isMenuExpanded {
//            self.menuButtonVerticalPosition.constant = -14
//            self.menuButtonHeight.constant = 80
//            self.menuButton.cornerRadius = 40
            
            self.menuViewHeight.constant = 80
            self.menuViewVerticalPosition.constant = -14
            self.menuView.cornerRadius = 40
            self.isMenuExpanded = false
            UIView.animate(withDuration: 0.2, animations: {
                self.view.setNeedsLayout()
                self.view.layoutIfNeeded()
            }) { (finished) in
                self.menuButton.isHidden = false
                self.cancelTapGesture!.cancelsTouchesInView = false
                //            self.longPressMenuGesture?.isEnabled = !(self.menuButtonHeight.constant == 40)
                //            self.isMenuExpanded = !self.isMenuExpanded
            }
        }
        
    }
    
    
    //@IBOutlet weak var nameTextField: UITextField!
    
    func displayTags(vm: ListFiles.FetchTags.ViewModel) {
        
        self.tagSources?.tags = vm.tags
        self.folderSources?.tags = vm.folders
        self.allTableView.reloadData()
    }
    func displayFiles(vm: [File]) {
        self.files = vm
        self.allTableView.reloadData()
    }
    
    func expandFolders() {
//        https://stackoverflow.com/questions/460014/can-you-animate-a-height-change-on-a-uitableviewcell-when-selected
        if self.folderHeight < 240 {
            self.folderHeight = CGFloat((self.folderSources!.tags.count/3 + 1) * 143 + 52)
            self.allTableView.beginUpdates()
            self.allTableView.endUpdates()
            
        } else {
            self.folderHeight = 180
            self.allTableView.beginUpdates()
            self.allTableView.endUpdates()
        }
        
    }
    
    func showTags() {
        self.router?.routeToShowTags()
    }
    
    
}
extension ListFilesViewController {
//
}

extension ListFilesViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2 + self.files.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let row = indexPath.row
        switch row {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: TagCollectionTableViewCell.identifier) as! TagCollectionTableViewCell
            cell.setCell(collectionHandler: self.tagSources!, routeToShowTags: self.showTags)
            cell.selectionStyle = .none
            return cell
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: FolderCollectionTableViewCell.identifier) as! FolderCollectionTableViewCell
            cell.setCell(collectionHandler: self.folderSources!, expandCell: self.expandFolders)
            cell.selectionStyle = .none
            return cell
        default:
            let cell = tableView.dequeueReusableCell(withIdentifier: FileTableViewCell.identifier) as! FileTableViewCell
            cell.setCell(file: self.files[row - 2])
//            cell.setCell(collectionHandler: self.folderSources!, expandCell: self.expandFolders)
            return cell
            
        }
    }
}
extension ListFilesViewController: UITableViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        self.hideMenu(sender: nil)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.router?.routeToShowFile(segue: nil)
        tableView.deselectRow(at: indexPath, animated: false)
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.row {
        case 0:
            return 120
        case 1:
            return self.folderHeight
            
            
        
        default:
            return 72
        }
    }
    
}
extension ListFilesViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
}

