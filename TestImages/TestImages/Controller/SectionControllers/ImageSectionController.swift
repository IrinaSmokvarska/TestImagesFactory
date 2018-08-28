//
//  ImageSectionController.swift
//  TestImages
//
//  Created by Irina Smokvarska on 8/28/18.
//  Copyright © 2018 Irina Smokvarska. All rights reserved.
//

import UIKit
import IGListKit
import Kingfisher

class ImageSectionController: ListSectionController {
    private var image: Image?
    var imgCellHeight: CGFloat = 105.0
    
    override func sizeForItem(at index: Int) -> CGSize {
        return CGSize(width: self.collectionContext!.containerSize.width, height: imgCellHeight)
       
    }
    
    override func cellForItem(at index: Int) -> UICollectionViewCell {
        guard let cell = collectionContext?.dequeueReusableCell(withNibName: "ImageCollectionViewCell", bundle: nil, for: self, at: index) as? ImageCollectionViewCell else {
            fatalError()
        }
        
        cell.imgView.kf.setImage(with: URL(string: (image?.url)!), options: [.cacheMemoryOnly])
        cell.lblImgTitle.text = image?.title
        
        return cell
        
    }
    
    override func didSelectItem(at index: Int) {
        if let vController = self.viewController as? UserDetailsViewController {
            vController.openImage(image: image!)
        }
    }
    
    override func didUpdate(to object: Any) {
        if let img = object as? Image {
            self.image = img
        }
    }

}
