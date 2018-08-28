//
//  Image.swift
//  TestImages
//
//  Created by Irina Smokvarska on 8/28/18.
//  Copyright © 2018 Irina Smokvarska. All rights reserved.
//

import Foundation
import SwiftyJSON
import IGListKit

class Image {
    var albumId: Int = 0
    var id: Int = 0
    var thumbnailUrl: String = ""
    var title: String = ""
    var url: String = ""
    
    init(json: JSON) {
        self.albumId = json["albumId"].int ?? 0
        self.id = json["id"].int ?? 0
        self.thumbnailUrl = json["thumbnailUrl"].string ?? ""
        self.title = json["title"].string ?? ""
        self.url = json["url"].string ?? ""
    }
}

extension Image: ListDiffable {
    func diffIdentifier() -> NSObjectProtocol {
        return "image\(id)" as NSObjectProtocol
    }
    
    func isEqual(toDiffableObject object: ListDiffable?) -> Bool {
        guard let img = object as? Image else{
            return false
        }
        return id == img.id && thumbnailUrl == img.thumbnailUrl
    }
    
    
}
