//
//  AllCategoriesResponse.swift
//  Spotify App
//
//  Created by Tristan Nguyen on 25/5/2022.
//

import Foundation

struct AllCategoriesResponse: Codable{
    let categories: Categories
    
}
struct Categories: Codable{
    let items: [Category]
}
struct Category: Codable {
    let id: String
    let name: String
    let icons: [APIImage]
}
