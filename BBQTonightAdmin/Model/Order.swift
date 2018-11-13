//
//  Order.swift
//  BBQTonightAdmin
//
//  Created by Nasim on 4/14/18.
//  Copyright © 2018 Nasim. All rights reserved.
//

import Foundation

struct Order {
    let id: String
    let name: String
    let quantity: Int
    let imageUrl: String
    
    init(dictionary: [String: Any]) {
        self.id = dictionary["id"] as? String ?? ""
        self.name = dictionary["name"] as? String ?? ""
        self.quantity = dictionary["quantity"] as? Int ?? 0
        self.imageUrl = dictionary["imageUrl"] as? String ?? ""
    }
}
