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
typealias UserCompletionHandler = (_ images: Array<Image>?, _ totalCount: String?, _ error: Error?) -> ()

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
    
    func getImagesOfUserWithId(id: Int, start: Int, limit: Int, completion: @escaping UserCompletionHandler) {
        Alamofire.request(baseUrl+ApiRoutes.userPhotos(id: String(id), startIndex: start, limit: limit)).responseJSON { (response) in
            if response.result.isFailure {
                print("error")
                completion(nil, nil, response.result.error)
            } else {
                var imagesOfUser = Array<Image>()
                var count: String?
                if let header = response.response?.allHeaderFields{
                    count = header["x-total-count"] as? String
                }
               
                if let arrayJson = response.result.value as? [[String:Any]] {
                    for json in arrayJson {
                        imagesOfUser.append(Image(json: JSON(json)))
                    }
                }
                completion(imagesOfUser,count, nil)
            }
        }
        
    }
}
