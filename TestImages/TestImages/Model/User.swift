//
//  User.swift
//  TestImages
//
//  Created by Irina Smokvarska on 8/28/18.
//  Copyright © 2018 Irina Smokvarska. All rights reserved.
//

import Foundation
import SwiftyJSON
import IGListKit

class User {
    
    var name: String = ""
    var userAddress: Address?
    var company: Company?
    var email: String = ""
    var id: Int = 0
    var phone: String = ""
    var userName: String = ""
    var website: String = ""
    var userImages: Array<Image>?
    
    init(json: JSON) {
        self.name = json["name"].string ?? ""
        self.userAddress = Address(json: json["address"])
        self.company = Company(bs: json["company"]["bs"].string ?? "", catchPhrase: json["company"]["catchPhrase"].string ?? "", name: json["company"]["name"].string ?? "")
        self.email = json["email"].string ?? ""
        self.id = json["id"].int ?? 0
        self.phone = json["phone"].string ?? ""
        self.userName = json["username"].string ?? ""
        self.website = json["website"].string ?? ""
    }
}

class Address {
    var city: String = ""
    var geoLocation: Geo?
    var street: String = ""
    var suite: String = ""
    var zipcode: String = ""
    
    init(json: JSON) {
        if let city = json["city"].string {
            self.city = city
        }
        
        let geoLoc = json["geo"]
        self.geoLocation = Geo(lat: geoLoc["lat"].string ?? "", lng: geoLoc["lng"].string ?? "")
        self.street = json["street"].string ?? ""
        self.suite = json["suite"].string ?? ""
        self.zipcode = json["zipcode"].string ?? ""
    }
    
}

struct Company {
    var bs: String = ""
    var catchPhrase: String = ""
    var name: String = ""
}

struct Geo {
    var lat: String = ""
    var lng: String = ""
}


extension User: ListDiffable {
    func diffIdentifier() -> NSObjectProtocol {
        return id as NSObjectProtocol
    }
    
    func isEqual(toDiffableObject object: ListDiffable?) -> Bool {
        guard let user = object as? User else{
            return false
        }
        return id == user.id && userName == user.userName
    }
    
    
}
