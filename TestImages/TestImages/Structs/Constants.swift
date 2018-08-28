//
//  Struct.swift
//  TestImages
//
//  Created by Irina Smokvarska on 8/28/18.
//  Copyright © 2018 Irina Smokvarska. All rights reserved.
//

import Foundation

static let baseUrl = "https://jsonplaceholder.typicode.com/"

struct ApiRoutes {
    static func usersPath() -> String { return "users" }
    static func userPhotos(id: String, startIndex: Int, limit: Int) -> { return "users/\(id)/photos?_start=\(startIndex)&_limit=\(limit)" }
}


