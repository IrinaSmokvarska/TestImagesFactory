//
//  UsersViewController.swift
//  TestImages
//
//  Created by Irina Smokvarska on 8/28/18.
//  Copyright © 2018 Irina Smokvarska. All rights reserved.
//

import UIKit
import IGListKit

class UsersViewController: UIViewController {
    
    @IBOutlet weak var usersCollectionView: UICollectionView!
    
    var allUsers = [User]() {
        didSet{
            self.adapter.performUpdates(animated: true, completion: nil)
        }
    }
    
    lazy var adapter: ListAdapter = {
        return ListAdapter(updater: ListAdapterUpdater(), viewController: self)
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        adapter.collectionView = usersCollectionView
        adapter.dataSource = self
        getUsers()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func getUsers() {
        ApiClient.shared.getAllUsers { (users, error) in
            if let error = error {
                print(error.localizedDescription)
                return
            }
            self.allUsers = users!
        }
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

extension UsersViewController: ListAdapterDataSource {
    
    func objects(for listAdapter: ListAdapter) -> [ListDiffable] {
        return allUsers as [ListDiffable]
    }
    
    func listAdapter(_ listAdapter: ListAdapter, sectionControllerFor object: Any) -> ListSectionController {
        return UserSectionController()
    }
    
    func emptyView(for listAdapter: ListAdapter) -> UIView? {
        return nil
    }
    
    
}
