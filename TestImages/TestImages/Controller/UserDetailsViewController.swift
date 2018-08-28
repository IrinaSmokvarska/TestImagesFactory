//
//  UserDetailsViewController.swift
//  TestImages
//
//  Created by Irina Smokvarska on 8/28/18.
//  Copyright © 2018 Irina Smokvarska. All rights reserved.
//

import UIKit
import IGListKit

class UserDetailsViewController: UIViewController {

    @IBOutlet weak var userCollectionView: UICollectionView!
    
    var user = User()
    var data = [ListDiffable]()
    var start = 0
    var limit = 50
    var allCount = ""
    var loading = false
    
    lazy var adapter: ListAdapter = {
        return ListAdapter(updater: ListAdapterUpdater(), viewController: self)
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        adapter.collectionView = userCollectionView
        adapter.dataSource = self
        adapter.scrollViewDelegate = self
        getImagesOfUser(id: user.id)
        data.append(user)
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func getImagesOfUser(id: Int) {
        ApiClient.shared.getImagesOfUserWithId(id: user.id, start: start, limit: limit) { (images, count, error) in
            self.loading = false
            if let error = error {
                print(error.localizedDescription)
                return
            }
            print("start: \(self.start)")
            print("limit: \(self.limit)")
            self.start = self.limit + self.start
            self.allCount = count!
            self.user.userImages = images!
            self.data.append(contentsOf: images! as [ListDiffable])
            self.adapter.performUpdates(animated: true, completion:nil)
            
            
        }
    }
    
    func updateTotalCount(cell: UserDetailCollectionViewCell) {
       cell.countOfImgs.text = String(self.start+self.limit) + "/" + self.allCount
        
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

extension UserDetailsViewController: ListAdapterDataSource {
    
    func objects(for listAdapter: ListAdapter) -> [ListDiffable] {
        return data as [ListDiffable]
    }
    
    func listAdapter(_ listAdapter: ListAdapter, sectionControllerFor object: Any) -> ListSectionController {
        if object is User {
             return UserSectionController()
        } else {
            return ImageSectionController()
        }
       
    }
    
    func emptyView(for listAdapter: ListAdapter) -> UIView? {
        return nil
    }
    
}

extension UserDetailsViewController: UIScrollViewDelegate {
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        let distance = scrollView.contentSize.height - (targetContentOffset.pointee.y + scrollView.bounds.height)
        if !loading && distance < 200 {
            loading = true
            getImagesOfUser(id: user.id)
            
        }
    }
}

