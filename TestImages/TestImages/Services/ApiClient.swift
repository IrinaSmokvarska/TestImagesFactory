//
//  ApiClient.swift
//  TestImages
//
//  Created by Irina Smokvarska on 8/28/18.
//  Copyright © 2018 Irina Smokvarska. All rights reserved.
//

import Foundation
import Alamofire

class ApiClient{
    
    static let shared = ApiClient()
    
    func getAllUsers() {
        
        Alamofire.request(baseUrl + ApiRoutes.usersPath()).responseJSON { (response) in

            if response.result.isFailure {
                print("error")
            } else {
                
            }
            
        }
        
    }
}
