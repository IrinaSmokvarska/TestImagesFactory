//
//  FavoriteImagesViewController.swift
//  TestImages
//
//  Created by Irina Smokvarska on 8/28/18.
//  Copyright © 2018 Irina Smokvarska. All rights reserved.
//

import UIKit
import IGListKit

class FavoriteImagesViewController: UIViewController {
    
    @IBOutlet weak var favCollectionView: UICollectionView!
    var favoriteImages = [Image](){
        didSet{
            self.adapter.performUpdates(animated: true, completion: nil)
        }
    }
    
    lazy var adapter: ListAdapter = {
        return ListAdapter(updater: ListAdapterUpdater(), viewController: self)
    }()
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        getSavedImages()

    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        adapter.collectionView = favCollectionView
        adapter.dataSource = self
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func getSavedImages() {
        if UserDefaults.standard.object(forKey: "favImages") != nil {
            let decoded = UserDefaults.standard.object(forKey: "favImages") as! Data
            favoriteImages = NSKeyedUnarchiver.unarchiveObject(with: decoded) as! [Image]
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

extension FavoriteImagesViewController: ListAdapterDataSource {
    
    func objects(for listAdapter: ListAdapter) -> [ListDiffable] {
        return favoriteImages as [ListDiffable]
    }
    
    func listAdapter(_ listAdapter: ListAdapter, sectionControllerFor object: Any) -> ListSectionController {
        return ImageSectionController()
    }
    
    func emptyView(for listAdapter: ListAdapter) -> UIView? {
        return nil
    }
    
    
}
