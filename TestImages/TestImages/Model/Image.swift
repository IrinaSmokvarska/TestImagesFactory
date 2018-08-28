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

class Image:NSObject, NSCoding {
    var albumId: Int = 0
    var id: Int = 0
    var thumbnailUrl: String = ""
    var title: String = ""
    var url: String = ""
    
    init(albumId: Int, id: Int, thumbUrl: String, title: String, url: String) {
        super.init()
        self.albumId = albumId
        self.id = id
        self.thumbnailUrl = thumbUrl
        self.title = title
        self.url = url
    }
    
    init(json: JSON) {
        self.albumId = json["albumId"].int ?? 0
        self.id = json["id"].int ?? 0
        self.thumbnailUrl = json["thumbnailUrl"].string ?? ""
        self.title = json["title"].string ?? ""
        self.url = json["url"].string ?? ""
    }
    
    required init?(coder aDecoder: NSCoder) {
        albumId = (aDecoder.decodeObject(forKey: "albumId") as! NSNumber).intValue
        id = (aDecoder.decodeObject(forKey: "id") as! NSNumber).intValue
        thumbnailUrl = aDecoder.decodeObject(forKey: "thumbnailUrl") as! String
        title = aDecoder.decodeObject(forKey: "title") as! String
        url = aDecoder.decodeObject(forKey: "url") as! String
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(NSNumber(value: albumId), forKey: "albumId")
        aCoder.encode(NSNumber(value: id), forKey: "id")
        aCoder.encode(thumbnailUrl, forKey: "thumbnailUrl")
        aCoder.encode(title, forKey: "title")
        aCoder.encode(url, forKey: "url")
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
