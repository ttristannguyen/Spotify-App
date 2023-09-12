//
//  APICaller.swift
//  Spotify App
//
//  Created by Tristan Nguyen on 4/5/2022.
//

import Foundation

final class APICaller {
    static let shared = APICaller()
    
    private init() {}
    
    enum APIError: Error{
        case failedtoGetData
    }
    
    struct Constants {
        static let baseAPIURl = "https://api.spotify.com/v1"
    }
    //MARK: -  ALBUMS
    public func getAlbumDetails(for album: Album, completion: @escaping (Result<AlbumDetailsResponse, Error>) -> Void){
        createRequest(with: URL(string: Constants.baseAPIURl + "/albums/" + album.id),
                      type: .GET
        ){ request in
            let task = URLSession.shared.dataTask(with: request) {data, _, error in
                guard let data = data, error  == nil else{
                    completion(.failure(APIError.failedtoGetData))
                    return
                }
                do {
                    let result = try JSONDecoder().decode(AlbumDetailsResponse.self, from: data)
//                    print(result)
                    completion(.success(result))
                }
                catch{
                    completion(.failure(error))
                }
            }
            task.resume()
        }
    }
    //MARK: - PLAYLISTS
    public func getPlaylistDetails(for playlist: Playlist, completion: @escaping (Result<PlaylistDetailsResponse, Error>) -> Void){
        createRequest(with: URL(string: Constants.baseAPIURl + "/playlists/" + playlist.id),
                      type: .GET
        ){ request in
            let task = URLSession.shared.dataTask(with: request) {data, _, error in
                guard let data = data, error  == nil else{
                    completion(.failure(APIError.failedtoGetData))
                    return
                }
                do {
                    let result = try JSONDecoder().decode(PlaylistDetailsResponse.self, from: data)
//                    print(result)
                    completion(.success(result))
                }
                catch{
//                    print(error)
                    completion(.failure(error))
                }
            }
            task.resume()
        }
    }
    
    // MARK: - PROFILE
    public func getCurrentUserProfile(completion: @escaping (Result< UserProfile, Error>) -> Void) {
        createRequest(with: URL(string: Constants.baseAPIURl + "/me"), type: .GET) { baseRequest in
            let task = URLSession.shared.dataTask(with: baseRequest) {data, _, error in
                guard let data = data, error == nil else{
                    completion(.failure(APIError.failedtoGetData))
                    return
                }
                do{
//                    let result = try JSONSerialization.jsonObject(with: data, options: .allowFragments)
                    let result = try JSONDecoder().decode(UserProfile.self, from: data)
//                    print(result)
                    completion(.success(result))
                }
                catch{
                    print(error.localizedDescription)
                    completion(.failure(error))
                }
            }
            task.resume()
        }
    }
    enum HTTPMethod:String{
        case GET
        case POST
    }
    
    
    private func createRequest(with url: URL?, type: HTTPMethod, completion: @escaping (URLRequest) -> Void) {
        AuthManager.shared.withValidToken{ token in
            guard let APIUrl = url else{
                return
            }
            var request = URLRequest(url: APIUrl)
            request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
            request.httpMethod = type.rawValue
            request.timeoutInterval = 30
            completion(request)
        }

    }
    // MARK: - HOME
    public func getNewRelease(completion: @escaping ((Result<NewReleasesResponse,Error>)) -> Void ){
        
        createRequest(with: URL(string: Constants.baseAPIURl + "/browse/new-releases?limit=50"), type: .GET) { request in
            let task = URLSession.shared.dataTask(with: request) {data, _, error in
                guard let data = data, error == nil else{
                    completion(.failure(APIError.failedtoGetData))
                    
                    return
                }
                do {
                    let result = try JSONDecoder().decode(NewReleasesResponse.self, from: data)
//                    print(result)
                    completion(.success(result))
                }
                catch{
                    completion(.failure(error))
                }
            }
            task.resume()
        }
    }
    public func getFeaturedPlaylist(completion: @escaping ((Result<FeaturedPlaylistsResponse, Error>) -> Void)){
        createRequest(with: URL(string: Constants.baseAPIURl + "/browse/featured-playlists?limit=20"), type: .GET) {
            request in
            let task = URLSession.shared.dataTask(with: request) {data, _, error in
                guard let data = data, error == nil else{
                    completion(.failure(APIError.failedtoGetData))
                    
                    return
                }
                do {
//                    print("Decoding")
//                    let  json = try  JSONSerialization.jsonObject(with: data, options: .allowFragments)
                    let result = try JSONDecoder().decode(FeaturedPlaylistsResponse.self, from: data)
//                    print(result)
//                    print(json)
                    completion(.success(result))
                }
                catch{
                    completion(.failure(error))
                }
            }
            task.resume()
            
        }
        
    }
    public func getRecommendations(genres: Set<String>,completion: @escaping ((Result<RecommendationsResponse,Error>) -> Void)){
        let seeds = genres.joined(separator: ",")
        createRequest(with: URL(string: Constants.baseAPIURl + "/recommendations?seed_genres=\(seeds)"), type: .GET) { request  in
            let task = URLSession.shared.dataTask(with: request) {data, _, error in
                guard let data = data, error == nil else{
                    completion(.failure(APIError.failedtoGetData))

                    return
                }
                do {
//                    let  json = try  JSONSerialization.jsonObject(with: data, options: .allowFragments)
//                    print(json)
                    let result = try JSONDecoder().decode(RecommendationsResponse.self, from: data)
//                    print(result)
                    completion(.success(result))
                }
                catch{
                    completion(.failure(error))
                }
            }
            task.resume()
        }
    }
    public func getReccomendedGenres(completion: @escaping ((Result<RecommendedGenresResponse,Error>) -> Void)){
        createRequest(with: URL(string: Constants.baseAPIURl + "/recommendations/available-genre-seeds"), type: .GET) { request  in
            let task = URLSession.shared.dataTask(with: request) {data, _, error in
                guard let data = data, error == nil else{
                    completion(.failure(APIError.failedtoGetData))
                    
                    return
                }
                do {
//                    let  json = try  JSONSerialization.jsonObject(with: data, options: .allowFragments)
                    let result = try JSONDecoder().decode(RecommendedGenresResponse.self, from: data)
//                    print(json)
//                    print(result)
                    completion(.success(result))
                }
                catch{
                    completion(.failure(error))
                }
            }
            task.resume()
        }
    }
    // MARK: - CATEGORY
    public func getCategories(completion: @escaping (Result<[Category], Error>) -> Void) {
        createRequest(with: URL(string: Constants.baseAPIURl + "/browse/categories?limit=20"), type: .GET)
        { request in
            let task = URLSession.shared.dataTask(with: request ) {data, _, error in
                guard let data = data, error == nil else{
                    completion(.failure(APIError.failedtoGetData))
                    return
                }
                do {
                    let result = try JSONDecoder().decode(AllCategoriesResponse.self,from: data) //Decode Into AllCategoriesResponse(Codable Model) from data
                    
                    completion(.success(result.categories.items)) //Return the Categories Item (id, name, icon) Codable Object
                    
                    
                }
                catch{
                    completion(.failure(error))
                    
                }
            }
            task.resume()
        }
        
    }
    public func getCategoryPlaylists(category: Category,completion: @escaping (Result<[Playlist], Error>) -> Void) {
        createRequest(with: URL(string: Constants.baseAPIURl + "/browse/categories/\(category.id)/playlists/"), type: .GET)
        { request in
            let task = URLSession.shared.dataTask(with: request ) {data, _, error in
                guard let data = data, error == nil else{
                    completion(.failure(APIError.failedtoGetData))
                    return
                }
                do {
                    let result = try JSONDecoder().decode(CategoryPlaylistsResponse.self, from: data) // in FeaturedPlaylistsResponse
                    let playlists = result.playlists.items
//                    print(playlists)
                    //let json = try JSONSerialization.jsonObject(with: data, options: .allowFragments)
                    completion(.success(playlists))
                    
                }
                catch{
                    print(error)
                    completion(.failure(error))
                    
                }
            }
            task.resume()
        }
        
    }
    // MARK: - Search
    public func search(with query: String, completion: @escaping (Result<[SearchResult], Error>) -> Void) {
        createRequest(with: URL(string: Constants.baseAPIURl + "/search?limit=5&type=album,artist,playlist,track&q=\(query.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? "")"),
                      type: .GET)
        // the limit=5 limits it to 5 for each type (album,artit,playlist,track)
        { request in
            print(request.url?.absoluteString ?? "none")
            let task = URLSession.shared.dataTask(with: request) {data, _,error in
                guard let data = data, error == nil else{
                    completion(.failure(APIError.failedtoGetData))
                    return
                }
                do{
                    let results = try JSONDecoder().decode(SearchResultsResponse.self, from: data) // decodes into SearchResultsReponse
                    var searchResults: [SearchResult] = []
                    searchResults.append(contentsOf: results.tracks.items.compactMap({SearchResult.track(model: $0) }))
                    searchResults.append(contentsOf: results.albums.items.compactMap({SearchResult.album(model: $0) }))
                    searchResults.append(contentsOf: results.artists.items.compactMap({SearchResult.artist(model: $0) }))
                    searchResults.append(contentsOf: results.playlists.items.compactMap({SearchResult.playlist(model: $0) }))
                    
                    completion(.success(searchResults))
                    // SearchResultsResponse is just a bunch of different Codable Sets
                    // SearchResult is a array which will contain all the Codable sets into one array
                    // SearchResult becomes the return value
                    // SearchResult is then used for the tableView
                    
                    
                    
//                    let json = try JSONSerialization.jsonObject(with: data, options: .allowFragments)
                    print(results)
                }
                catch{
                    completion(.failure(error))
                    print(error)
                }
            }
            task.resume()
            
        }
    }
}
