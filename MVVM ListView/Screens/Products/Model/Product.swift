//
//  Product.swift
//  MVVM ListView
//
//  Created by Aashish Ahlawat on 16/05/23.
//

import Foundation

struct Product: Codable {
    let id: Int
    let title: String
    let price: Double
    let description: String
    let category: String
    let image: String
    let rating: Rate
}

struct Rate: Codable {
    let rate: Double
    let count: Int
}
