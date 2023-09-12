//
//  AudioTrack.swift
//  Spotify App
//
//  Created by Tristan Nguyen on 4/5/2022.
//

import Foundation

struct AudioTrack: Codable{
    var album: Album?
    var artists: [Artist]
    let available_markets: [String]
    let disc_number: Int
    let duration_ms: Int
    let explicit: Bool
    let external_urls: [String: String]
    let id: String
    var name: String
    var preview_url: String?
//    let popularity: Int?
}

