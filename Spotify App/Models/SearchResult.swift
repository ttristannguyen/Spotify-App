//
//  SearchResult.swift
//  Spotify App
//
//  Created by Tristan Nguyen on 25/5/2022.
//

import Foundation

enum SearchResult {
    case artist(model: Artist)
    case album(model: Album)
    case track(model: AudioTrack)
    case playlist(model: Playlist)
}
