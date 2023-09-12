//
//  FeaturedPlaylistsCollectionViewCell.swift
//  Spotify App
//
//  Created by Tristan Nguyen on 12/5/2022.
//

import UIKit

class FeaturedPlaylistsCollectionViewCell: UICollectionViewCell {
    static let identifier = "FeaturedPlaylistCollectionViewCell"
    
    private let playlistCoverImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.masksToBounds = true
        imageView.layer.cornerRadius = 4
        imageView.image = UIImage(systemName: "photo")
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    private let playlistNameLabel: UILabel = {
        let label =  UILabel()
        label.textAlignment = .center
        label.font =  .systemFont(ofSize:  18, weight: .regular)
        return label
    }()
    private let creatorNameLabel: UILabel = {
        let label =  UILabel()
        label.textAlignment = .center
        label.font =  .systemFont(ofSize: 15, weight: .thin)
        return label
    }()

    
    override init(frame: CGRect){
        super.init(frame: frame)
        contentView.backgroundColor = .secondarySystemBackground
        contentView.addSubview(playlistCoverImageView)
        contentView.addSubview(playlistNameLabel)
        contentView.addSubview(creatorNameLabel)
        contentView.clipsToBounds = true
        
    }
    required init?(coder: NSCoder){
        fatalError()
    }
    override func  layoutSubviews() {
        super.layoutSubviews()
        creatorNameLabel.frame = CGRect(
        x: 3,
        y: contentView.height-30,
        width: contentView.width-6,
        height: 30
        )
        playlistNameLabel.frame = CGRect(
        x: 3,
        y: contentView.height-60,
        width: contentView.width-6,
        height: 30)
      
        let imageSize = contentView.height-70
        playlistCoverImageView.frame = CGRect(
        x: (contentView.width-imageSize)/2,
        y: 3,
        width: imageSize,
        height: imageSize)
    }
    override  func prepareForReuse() {
        super.prepareForReuse()
        playlistNameLabel.text =  nil
        creatorNameLabel.text = nil
        playlistCoverImageView.image = nil
    }
    func configure(with viewModel: FeaturedPlaylistCellViewModel){
        playlistNameLabel.text =  viewModel.name
        creatorNameLabel.text = viewModel.creatorName
        let data = try? Data(contentsOf: viewModel.artworkURL!)
        playlistCoverImageView.image = UIImage(data: data!)
        
    }
}