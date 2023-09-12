//
//  SearchResultsViewController.swift
//  Spotify App
//
//  Created by Tristan Nguyen on 19/5/2022.
//

import UIKit
struct SearchSection {
    let title: String
    let results: [SearchResult]
}

protocol SearchResultsViewControllerDelegate: AnyObject {
    func didTapResults(_ results: SearchResult)
}
// ALL SEARCH VIEW CELLS ARE IN SearchResultsCells
class SearchResultsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    private var sections: [SearchSection] = []
    weak var delegate: SearchResultsViewControllerDelegate?
    
    
    private let tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.register(SearchResultsDefaultTableViewCell.self, forCellReuseIdentifier: SearchResultsDefaultTableViewCell.identifer)
        // Register Each Cell in the tableView as a SearchResultsDefaultTableViewCell
        tableView.register(SearchResultsSubtitleTableViewCell.self, forCellReuseIdentifier: SearchResultsSubtitleTableViewCell.identifer)
        tableView.isHidden = true // make it hidden
        return tableView // tableView
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .clear
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
    
        
    }
    func update(with results: [SearchResult]) {
        //SearchResults is either a artist, album, track or playlists
        // filters Artists, Albums, Tracks and Playlists in the [SearchResult] Array
        
        let artists = results.filter({
            switch $0 {
            case .artist: return true
            default: return false
            }
        })
        let albums = results.filter({
            switch $0 {
            case .album: return true
            default: return false
            }
        })
        let tracks = results.filter({
            switch $0 {
            case .track: return true
            default: return false
            }
        })
        let playlists = results.filter({
            switch $0 {
            case .playlist: return true
            default: return false
            }
        })
        
        self.sections = [
            SearchSection(title: "Songs", results: tracks),
            SearchSection(title: "Artists", results: artists), // Line 15, Array of SearchSection [SearchSection], initally was empty
            SearchSection(title: "Playlists", results: playlists),
            SearchSection(title: "Albums", results: albums)
                       ]
        tableView.reloadData()
        if !results.isEmpty{
            tableView.isHidden = false // if there is a result make it no hidden
        }
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        sections.count // 4
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        sections[section].results.count
        // checks which sections it is in, and the amount of results in that specific section // total 20 in each section
        // Number of Results per section is in API.caller.search for create Request
        // EDIT: Changed to limit 5 of per section
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let result = sections[indexPath.section].results[indexPath.row]
        // sections is an array which contains title and [SearchSection],
        // we want SearchSection array which is .results and we want its index therefore indexRow
        // results is one of artists,albums,tracks,playlists
        switch result{
            
            // Artists is the only case where a subtitle is not needed as there is no into
        case .artist(let artist):
            guard let cell = tableView.dequeueReusableCell(
                withIdentifier: SearchResultsDefaultTableViewCell.identifer,
                for: indexPath
            ) as? SearchResultsDefaultTableViewCell else{
                return UITableViewCell()
            }
            let viewModel = SearchResultsDefaultTableViewCellViewModel(
                title: artist.name,
                imageURL: URL(string: artist.images?.first?.url ?? ""))
            cell.configure(with: viewModel)
            return cell
            
          // All 3 of these ViewCells need a subtitle for additional info
        case .track(let track):
            guard let cell = tableView.dequeueReusableCell(
                withIdentifier: SearchResultsSubtitleTableViewCell.identifer,
                for: indexPath
            ) as? SearchResultsSubtitleTableViewCell else{
                return UITableViewCell()
            }
            let viewModel = SearchResultsSubtitleTableViewCellViewModel(
                title: track.name,
                subtitle: track.artists.first?.name ?? "",
                imageURL: URL(string: track.album?.images.first?.url ?? ""))
            cell.configure(with: viewModel)
            return cell
            
            
        case .album(let album):
            guard let cell = tableView.dequeueReusableCell(
                withIdentifier: SearchResultsSubtitleTableViewCell.identifer,
                for: indexPath
            ) as? SearchResultsSubtitleTableViewCell else{
                return UITableViewCell()
            }
            let viewModel = SearchResultsSubtitleTableViewCellViewModel(
                title: album.name,
                subtitle: album.artists.first?.name ?? "",
                imageURL: URL(string: album.images.first?.url ?? ""))
            cell.configure(with: viewModel)
            return cell
            
            
        case .playlist(let playlist):
            guard let cell = tableView.dequeueReusableCell(
                withIdentifier: SearchResultsSubtitleTableViewCell.identifer,
                for: indexPath
            ) as? SearchResultsSubtitleTableViewCell else{
                return UITableViewCell()
            }
            let viewModel = SearchResultsSubtitleTableViewCellViewModel(
                title: playlist.name,
                subtitle: playlist.owner.display_name,
                imageURL: URL(string: playlist.images.first?.url ?? ""))
            cell.configure(with: viewModel)
            return cell
        }
        
    }
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sections[section].title
        // title is equal to the specific section and its title
        // sections is an array of [SearchSection] - SearchSection has title: and [SearchResult]
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let result = sections[indexPath.section].results[indexPath.row]
        // sections is an array which contains title and [SearchSection],
        // we want SearchSection array which is .results and we want its index therefore indexRow
        // results is one of artists,albums,tracks,playlists
        delegate?.didTapResults(result)
        // We do this because we can't actually push a viewcontroller onto the SearchResultsController, because
        // techinically we are stil on the SearchViewController
    }

}
