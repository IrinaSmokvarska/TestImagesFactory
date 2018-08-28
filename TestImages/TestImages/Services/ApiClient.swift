//
//  ApiClient.swift
//  TestImages
//
//  Created by Irina Smokvarska on 8/28/18.
//  Copyright © 2018 Irina Smokvarska. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

typealias UsersCompletionHandler = (_ users: Array<User>?, _ error: Error?) -> ()

class ApiClient{
    
    static let shared = ApiClient()
    
    func getAllUsers(completion: @escaping UsersCompletionHandler) {
        
        Alamofire.request(baseUrl + ApiRoutes.usersPath()).responseJSON { (response) in

            if response.result.isFailure {
                print("error")
                completion(nil, response.result.error)
            } else {
                var users = Array<User>()
                if let arrayJson = response.result.value as? [[String:Any]] {
                    for json in arrayJson {
                        users.append(User(json: JSON(json)))
                    }
                }
                completion(users, nil)
            }
            
        }
        
    }
}
