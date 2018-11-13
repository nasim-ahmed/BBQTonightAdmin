//
//  Category.swift
//  bbqtonight
//
//  Created by Nasim on 4/6/18.
//  Copyright © 2018 Nasim. All rights reserved.
//

import Foundation

struct Category {
    let catId: String
    let categoryName: String
    let imageUrl: String

    init(catId: String, dictionary: [String: Any]){
        self.catId = catId
        self.categoryName = dictionary["name"] as? String ?? ""
        self.imageUrl = dictionary["image"] as? String ?? ""
    }
    
}
