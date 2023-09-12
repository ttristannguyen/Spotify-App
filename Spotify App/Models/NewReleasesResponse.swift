//
//  NewReleasesResponse.swift
//  Spotify App
//
//  Created by Tristan Nguyen on 11/5/2022.
//

import Foundation

struct NewReleasesResponse: Codable {
    let albums: AlbumsResponse
}
struct AlbumsResponse: Codable{
    let items: [Album]
}

