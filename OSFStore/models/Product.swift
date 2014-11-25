//
//  Product.swift
//  OSFStore
//
//  Created by Ryan Chang on 14/11/25.
//  Copyright (c) 2014年 CandZen Co., Ltd. All rights reserved.
//

import Foundation

class Product
{
    let productId: Int
    let name: String
    let desc: String
    let price: Float
    
    init(id: Int, name: String, desc: String, price: Float) {
        self.productId = id
        self.name = name
        self.desc = desc
        self.price = price
    }
}