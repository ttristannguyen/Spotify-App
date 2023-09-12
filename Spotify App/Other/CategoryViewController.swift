//
//  CategoryViewController.swift
//  Spotify App
//
//  Created by Tristan Nguyen on 25/5/2022.
//

import UIKit
// When a Category is Selected
class CategoryViewController: UIViewController {

    let category: Category
    
    private let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewCompositionalLayout(sectionProvider: { _, _ -> NSCollectionLayoutSection? in
        let item = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1),
            heightDimension: .fractionalHeight(1)))
        
        item.contentInsets = NSDirectionalEdgeInsets(top: 5, leading: 5, bottom: 5, trailing: 5) // Spacing between items
        
        let group = NSCollectionLayoutGroup.horizontal(
            layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                               heightDimension: .absolute(250)),
            subitem: item,
            count: 2 //Number of items per group (2 per row)
            )
            group.contentInsets = NSDirectionalEdgeInsets(top: 5, leading: 5, bottom: 5, trailing: 5) // spacing between groups
            return NSCollectionLayoutSection(group: group)
    }))
    
    //MARK: - INIT
    init(category: Category){
        self.category = category
        super.init(nibName: nil, bundle: nil)
    }
    required init?(coder: NSCoder) {
        fatalError()
    }
    var playlists = [Playlist]()
    // MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = category.name
        view.addSubview(collectionView)
        view.backgroundColor = .systemBackground
        collectionView.backgroundColor = .systemBackground
        collectionView.register(FeaturedPlaylistsCollectionViewCell.self, forCellWithReuseIdentifier: FeaturedPlaylistsCollectionViewCell.identifier) // Register cell as a FeaturedPlaylistCollectionViewCell
        collectionView.delegate = self
        collectionView.dataSource = self
        APICaller.shared.getCategoryPlaylists(category: category){ [weak self] result in // on viewLoad run getCategoryPlaylists
            DispatchQueue.main.async {
                switch result{
                    case .success(let playlists):
                        self?.playlists = playlists // on success let playlists(one created in this vc) equal result
                        self?.collectionView.reloadData()
                
                    case .failure(let error):
                        print(error.localizedDescription)
                }
            }
        }

        // Do any additional setup after loading the view.
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        collectionView.frame = view.bounds
        
    }
    

}
extension CategoryViewController: UICollectionViewDelegate, UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return playlists.count // Number of items will be the amount of Playlists that were generated from the getCategoryPlaylists function
    }
    

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: FeaturedPlaylistsCollectionViewCell.identifier, // set the cell as a FeaturedPlaylistsCollectionViewCell if not
            for: indexPath) as? FeaturedPlaylistsCollectionViewCell else{
                return UICollectionViewCell() // set as a normal collectionViewCell
            }
        // we can configure it as a FeaturedPlaylistCellViewModel because the ViewModel Contains the exact same codable
        // as the playlist we generate from the getCategoryPlaylists
        
        let playlist = playlists[indexPath.row]
        cell.configure(with: FeaturedPlaylistCellViewModel(name: playlist.name,
                                                           artworkURL: URL(string: playlist.images.first?.url ?? ""),
                                                           creatorName: playlist.owner.display_name))
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        let vc = PlaylistViewController(playlist: playlists[indexPath.row])
        navigationController?.pushViewController(vc, animated: true)
        vc.navigationItem.largeTitleDisplayMode = .never
    }
}
