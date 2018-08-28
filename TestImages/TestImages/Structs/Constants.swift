//
//  Struct.swift
//  TestImages
//
//  Created by Irina Smokvarska on 8/28/18.
//  Copyright © 2018 Irina Smokvarska. All rights reserved.
//

import Foundation

let baseUrl = "https://jsonplaceholder.typicode.com/"

struct ApiRoutes {
    static func usersPath() -> String { return "users" }
    static func userPhotos(id: String, startIndex: Int, limit: Int) -> String { return "users/\(id)/photos?_start=\(startIndex)&_limit=\(limit)" }
}


