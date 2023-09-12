//
//  Album.swift
//  Spotify App
//
//  Created by Tristan Nguyen on 25/5/2022.
//

import Foundation

struct Album: Codable {
    let album_type: String
    let available_markets: [String]
    let id: String
    var images: [APIImage]
    let name: String
    let release_date: String
    let total_tracks: Int
    let artists: [Artist]
}
