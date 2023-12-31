//
//  RecommendedTrackCollectionViewCell.swift
//  Spotify App
//
//  Created by Tristan Nguyen on 12/5/2022.
//

import UIKit

class RecommendedTrackCollectionViewCell: UICollectionViewCell {
    static let identifier = "RecommendedTrackCollectionViewCell"
    
    private let albumCoverImageView: UIImageView = {
        let imageView = UIImageView()
//        imageView.layer.masksToBounds = true
//        imageView.layer.cornerRadius = 8
        imageView.image = UIImage(systemName: "photo")
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    private let trackNameLabel: UILabel = {
        let label =  UILabel()
//        label.textAlignment = .center
        label.font =  .systemFont(ofSize:  18, weight: .regular)
        return label
    }()
    private let artistNameLabel: UILabel = {
        let label =  UILabel()
//        label.textAlignment = .center
        label.font =  .systemFont(ofSize: 15, weight: .thin)
        return label
    }()

    
    override init(frame: CGRect){
        super.init(frame: frame)
        contentView.backgroundColor = .secondarySystemBackground
        contentView.addSubview(albumCoverImageView)
        contentView.addSubview(trackNameLabel)
        contentView.addSubview(artistNameLabel)
        contentView.clipsToBounds = true
        
    }
    required init?(coder: NSCoder){
        fatalError()
    }
    override func  layoutSubviews() {
        super.layoutSubviews()
        albumCoverImageView.frame = CGRect(
        x: 5,
        y: 2,
        width: contentView.height-4,
        height: contentView.height-4
        )
        trackNameLabel.frame = CGRect(
        x: albumCoverImageView.right+10,
        y: 0,
        width: contentView.width-albumCoverImageView.right-15,
        height: contentView.height/2
        )
        artistNameLabel.frame = CGRect(
        x: albumCoverImageView.right+10,
        y: contentView.height/2,
        width: contentView.width-albumCoverImageView.right-15,
        height: contentView.height/2
        )
        
    }
    override  func prepareForReuse() {
        super.prepareForReuse()
        trackNameLabel.text =  nil
        artistNameLabel.text = nil
        albumCoverImageView.image = nil
    }
    func configure(with viewModel: RecommendedTrackCellViewModel){
        trackNameLabel.text =  viewModel.name
        artistNameLabel.text = viewModel.artistName
        let data = try? Data(contentsOf: viewModel.artworkURL!)
        albumCoverImageView.image = UIImage(data: data!)
        
    }
}
