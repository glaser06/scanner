//
//  ShowFileViewController.swift
//  Scanner
//
//  Created by Zaizen Kaegyoshi on 4/11/19.
//  Copyright (c) 2019 zzzz. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit
import DeviceKit

protocol ShowFileDisplayLogic: class
{
    func displayNewFile()
    func displayFile(vm: ShowFile.FetchFile.ViewModel)
}

class ShowFileViewController: UIViewController, ShowFileDisplayLogic
{
    var interactor: ShowFileBusinessLogic?
    var router: (NSObjectProtocol & ShowFileRoutingLogic & ShowFileDataPassing)?
    
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
        let interactor = ShowFileInteractor()
        let presenter = ShowFilePresenter()
        let router = ShowFileRouter()
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
//        self.addSwipeGesture()
        self.setupPageCollectionView()
        
        self.fetchFile()
    }
    
    func setupPageCollectionView() {
        
        let device = Device.init()
        let width = self.view.bounds.width - 48
        var height = self.pageCollectionView.frame.height - 48
        if device.isOneOf([.iPhoneX,.iPhoneXsMax,.iPhoneXs,.iPhoneXr]) {
            let constant: CGFloat = 40 + 80 + 108 + 48
            let insets = (self.pageCollectionView.contentInset.top + self.pageCollectionView.contentInset.bottom)
            let viewHeight = self.view.frame.height
            let bottomHeight = self.bottomView.frame.height
            height = viewHeight - bottomHeight - constant - insets
            
        }
        
        
        
        print(self.view.bounds.height, self.bottomView.frame.height)
        print(height)
        
        (self.pageCollectionView.collectionViewLayout as! UICollectionViewFlowLayout).itemSize = CGSize(width: width, height: height)

        let cellsToRegister: Array<DisplayableCell.Type> = [
            NewPageCollectionViewCell.self,
        ]
        for cellType in cellsToRegister {
            self.pageCollectionView.register(UINib(nibName: cellType.nibName, bundle: nil), forCellWithReuseIdentifier: cellType.identifier)
            
        }
        
        //        let searchBar = UISearchBar()
        //        searchBar.searchBarStyle = .minimal
        //
        //        self.allTableView.tableHeaderView = searchBar
    }
    func addSwipeGesture() {
        let downGesture = UISwipeGestureRecognizer()
        downGesture.cancelsTouchesInView = false
        downGesture.direction = .down
        downGesture.addTarget(self, action: #selector(animateFormExpansion))
        let upGesture = UISwipeGestureRecognizer()
        upGesture.cancelsTouchesInView = false
        upGesture.direction = .up
        upGesture.addTarget(self, action: #selector(animateFormContraction))
        self.view.addGestureRecognizer(downGesture)
        self.view.addGestureRecognizer(upGesture)
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(animateFormContraction))
        tapGesture.cancelsTouchesInView = false
        
        self.pageCollectionView.addGestureRecognizer(tapGesture)
    }
    
    @objc func animateFormExpansion() {
        let expansionHeight = self.view.frame.height - self.bottomView.frame.height - 120
        self.formHeightConstraint.constant = expansionHeight
        UIView.animate(withDuration: 0.2) {
            self.view.setNeedsLayout()
            self.view.layoutIfNeeded()
        }
    }
    @objc func animateFormContraction() {
        self.formHeightConstraint.constant = 130
        UIView.animate(withDuration: 0.2) {
            self.view.setNeedsLayout()
            self.view.layoutIfNeeded()
        }
    }
    
    // MARK: Do something
    
    //@IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var formHeightConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var bottomView: UIView!
    
    @IBOutlet weak var pageCollectionView: UICollectionView!
//    @IBOutlet weak var
    
    @IBAction func save () {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func cancel() {
        self.dismiss(animated: true, completion: nil)
    }
    
    func fetchFile() {
        self.interactor?.fetchFile()
    }
    func displayNewFile() {
        
    }
    func displayFile(vm: ShowFile.FetchFile.ViewModel) {
        
    }
}
extension ShowFileViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: NewPageCollectionViewCell.identifier, for: indexPath) as! NewPageCollectionViewCell
        
        return cell
    }
    
}
extension ShowFileViewController: UICollectionViewDelegate {
    
}

extension ShowFileViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
}
