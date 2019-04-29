//
//  ViewController.swift
//  Scanner
//
//  Created by Zaizen Kaegyoshi on 4/8/19.
//  Copyright © 2019 zzzz. All rights reserved.
//

import UIKit
import RealmSwift

class InitialViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
//        self.startOver()
//        TestGenerator.addTags()
//        TestGenerator.addChildTags()
        TagManager.sharedInstance.fetchAllFolders()
        
    }
    func startOver() {
        let realm = try! Realm()
        try! realm.write {
            realm.deleteAll()
        }
        
        TestGenerator.addTags()
        TestGenerator.addChildTags()
        

    }
    override func viewDidAppear(_ animated: Bool) {
        let storyboard = self.storyboard
        let nav = storyboard?.instantiateViewController(withIdentifier: "MainNavigationController") as! UINavigationController
        self.present(nav, animated: false, completion: nil)
    }
    


}

