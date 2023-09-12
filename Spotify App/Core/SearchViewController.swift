//
//  SearchViewController.swift
//  Spotify App
//
//  Created by Tristan Nguyen on 4/5/2022.
//
import SafariServices
import UIKit

class SearchViewController: UIViewController, UISearchResultsUpdating, UISearchBarDelegate{

    let searchController: UISearchController = {
        let vc = UISearchController(searchResultsController: SearchResultsViewController())
        vc.searchBar.placeholder = "Songs, Artists, Albums"
        vc.searchBar.searchBarStyle = .minimal
        vc.definesPresentationContext = true
        return vc
    }()
    private let collectionView: UICollectionView = UICollectionView(
        frame:. zero,
        collectionViewLayout: UICollectionViewCompositionalLayout(sectionProvider: {_,_ -> NSCollectionLayoutSection? in
            let item = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1)))
            item.contentInsets = NSDirectionalEdgeInsets(top: 2, leading: 7, bottom: 2, trailing: 7)
            let group = NSCollectionLayoutGroup.horizontal(
                layoutSize: NSCollectionLayoutSize(
                    widthDimension: .fractionalWidth(1),
                    heightDimension: .absolute(150)),
                subitem: item,
                count: 2
            )
            group.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 0, bottom: 10, trailing: 0)
            return NSCollectionLayoutSection(group: group)
        
    }))
    private var categories = [Category]()
    // MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.searchController = searchController
        searchController.searchResultsUpdater = self
        searchController.searchBar.delegate = self
    
        view.backgroundColor = .systemBackground
        view.addSubview(collectionView)
        collectionView.register(CategoryCollectionViewCell.self,
                                forCellWithReuseIdentifier: CategoryCollectionViewCell.identifier)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = .systemBackground
        
        APICaller.shared.getCategories { [weak self] result in // On ViewLoad run getCategories
            DispatchQueue.main.async {
                switch result { // If Successful with getCategories
                case .success(let categories): // let categories = result
                    self?.categories = categories // set categories variable made at top of this view controller to the result categories
                    self?.collectionView.reloadData() // reload data (Which will change all the data in the collection view)
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
        }
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        collectionView.frame = view.bounds
    }
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let resultsController = searchController.searchResultsController as? SearchResultsViewController,
                let query = searchBar.text,
              !query.trimmingCharacters(in: .whitespaces).isEmpty else {
            return
        }
        resultsController.delegate = self
        print(query)
        APICaller.shared.search(with: query) { result in // returns [SearchResult]
            DispatchQueue.main.async {
                switch result {
                case .success(let results):
                    resultsController.update(with: results) // with our result run Update in the SearchResultsViewController
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
        }
    }
    
    
    func updateSearchResults(for searchController: UISearchController) {
        // resultsController.update(with: results)
    }
    
    

}
extension SearchViewController: UICollectionViewDelegate, UICollectionViewDataSource{
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return categories.count // Limited to 20 rn, number of categories genearted from getCategories 
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CategoryCollectionViewCell.identifier, for: indexPath) as? CategoryCollectionViewCell else{
            return UICollectionViewCell() // Default ViewCell when view loads
            // Becomes CategoryCollectionViewCell if data is loaded
        }
        let category = categories[indexPath.row] // When getCategories Finishes and the async is done, data will reload
        // With what is below
        
        cell.configure(with: CategoryCollectionViewCellViewModel( // Configure the cell(which is a CategoryCollectionViewCell)
            //using the CategoryCollectionViewCellViewModel
            // similar to a protocol, it uses the configure function from the ViewCell
            title: category.name, // Set the title to the category name
            artworkURL: URL(string: category.icons.first?.url ?? "") // artwork url to the icon
        ))
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true) // deselect
        let category = categories[indexPath.row] // get the category selected
        let vc = CategoryViewController(category: category) // new vc with the category selected
        vc.navigationItem.largeTitleDisplayMode = .never
        navigationController?.pushViewController(vc, animated: true)
    }
}
extension SearchViewController: SearchResultsViewControllerDelegate{
    func didTapResults(_ result: SearchResult) {
        switch result{
        case .artist(let model):
            guard let url = URL(string: model.external_urls["spotify"] ?? "") else{
                return
            }
            let vc = SFSafariViewController(url: url)
            present(vc, animated: true)
            
        case .track(let model):
            PlaybackPresenter.shared.startPlayback(from: self, track: model)
        case .album(let model):
            let vc = AlbumViewController(album: model)
            vc.navigationItem.largeTitleDisplayMode = .never
            navigationController?.pushViewController(vc, animated: true)
            
        case .playlist(let model):
            let vc = PlaylistViewController(playlist: model)
            vc.navigationItem.largeTitleDisplayMode = .never
            navigationController?.pushViewController(vc, animated: true)
        }
    

    }
}
