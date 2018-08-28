//
//  UserSectionController.swift
//  TestImages
//
//  Created by Irina Smokvarska on 8/28/18.
//  Copyright © 2018 Irina Smokvarska. All rights reserved.
//

import UIKit
import IGListKit

class UserSectionController: ListSectionController {
    
    private var user: User?
    
    override func sizeForItem(at index: Int) -> CGSize {
        
        if self.viewController is UsersViewController {
            return CGSize(width: self.collectionContext!.containerSize.width, height: 60)
        } else if self.viewController is UserDetailsViewController {
            return CGSize(width: self.collectionContext!.containerSize.width, height: 150)
        }
        
        return .zero
        
    }
    
    override func cellForItem(at index: Int) -> UICollectionViewCell {
        
        if self.viewController is UsersViewController {
            guard let cell = collectionContext?.dequeueReusableCell(withNibName: "UserCollectionViewCell", bundle: nil, for: self, at: index) as? UserCollectionViewCell else {
                fatalError()
            }
            cell.lblName.text = user?.name
            cell.lblUsername.text = user?.userName
            
            return cell
        } else {
            guard let cell = collectionContext?.dequeueReusableCell(withNibName: "UserDetailCollectionViewCell", bundle: nil, for: self, at: index) as? UserDetailCollectionViewCell else {
                fatalError()
            }
            
            cell.lblName.text = user?.name
            cell.lblAddress.text = (user?.userAddress?.city)! + ", " + (user?.userAddress?.street)!  + ", " + (user?.userAddress?.zipcode)!
            cell.lblCompanyName.text = (user?.company?.bs)! + ", " + (user?.company?.catchPhrase)! + ", " + (user?.company?.name)!
            
            return cell
        }
       
    }
    
    override func didSelectItem(at index: Int) {
        if let vController = self.viewController as? UsersViewController {
            vController.openDetailsControllerForUser(user: self.user!)
        }
    }
    
    override func didUpdate(to object: Any) {
        if let usr = object as? User {
            self.user = usr
        }
    }

}
