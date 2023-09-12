//
//  RecommendationsResponse.swift
//  Spotify App
//
//  Created by Tristan Nguyen on 12/5/2022.
//

import Foundation

struct RecommendationsResponse: Codable {
    let tracks: [AudioTrack]
}

