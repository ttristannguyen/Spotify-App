//
//  SearchResultsResponse.swift
//  Spotify App
//
//  Created by Tristan Nguyen on 25/5/2022.
//

import Foundation

struct SearchResultsResponse: Codable{
    let albums: SearchAlbumResponse
    let artists: SearchArtistsResponse
    let playlists: SearchPlaylistsResponse
    let tracks: SearchTracksResponse
}
struct SearchAlbumResponse: Codable{
    let items: [Album]
}
struct SearchArtistsResponse: Codable{
    let items: [Artist]
}
struct SearchPlaylistsResponse: Codable{
    let items: [Playlist]
}
struct SearchTracksResponse: Codable{
    let items: [AudioTrack]
}
