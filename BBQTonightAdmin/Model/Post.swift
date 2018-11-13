//
//  Post.swift
//  bbqtonight
//
//  Created by Nasim on 4/6/18.
//  Copyright © 2018 Nasim. All rights reserved.
//

import Foundation

struct Post{
    let postId: String
    
    let foodName: String
    let foodPrice: Int
    let imageUrl: String
    
    init(postId: String, dictionary: [String: Any]) {
        self.postId = postId
        self.foodName = dictionary["name"] as? String ?? ""
        self.foodPrice = dictionary["price"] as? Int ?? 0
        self.imageUrl = dictionary["url"] as? String ?? ""
    }
}
