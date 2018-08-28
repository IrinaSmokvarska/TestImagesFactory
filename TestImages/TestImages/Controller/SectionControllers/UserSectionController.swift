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
        return CGSize(width: self.collectionContext!.containerSize.width, height: 60)
    }
    
    override func cellForItem(at index: Int) -> UICollectionViewCell {
        guard let cell = collectionContext?.dequeueReusableCell(withNibName: "UserCollectionViewCell", bundle: nil, for: self, at: index) as? UserCollectionViewCell else {
            fatalError()
        }
        cell.lblName.text = user?.name
        cell.lblUsername.text = user?.userName
        
        return cell
    }
    
    override func didUpdate(to object: Any) {
        if let usr = object as? User {
            self.user = usr
        }
    }

}
