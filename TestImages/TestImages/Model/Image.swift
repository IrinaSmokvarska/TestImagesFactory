//
//  Image.swift
//  TestImages
//
//  Created by Irina Smokvarska on 8/28/18.
//  Copyright © 2018 Irina Smokvarska. All rights reserved.
//

import Foundation
import SwiftyJSON

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
