//
//  Artists.swift
//  Spotify App
//
//  Created by Tristan Nguyen on 11/5/2022.
//

import Foundation

struct Artist: Codable{
    let id: String
    var name: String
    let type: String
    let images: [APIImage]?
    let external_urls: [String: String]
}
