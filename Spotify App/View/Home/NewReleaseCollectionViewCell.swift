//
//  NewReleaseCollectionViewCell.swift
//  Spotify App
//
//  Created by Tristan Nguyen on 12/5/2022.
//

import UIKit

class NewReleaseCollectionViewCell: UICollectionViewCell {
    static let identifier = "NewReleasesCollectionViewCell"
    
    private let albumCoverImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "photo")
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    private let albumNameLabel: UILabel = {
        let label =  UILabel()
        label.font =  .systemFont(ofSize: 22, weight: .semibold)
        return label
    }()
    private let numberofTracksLabel: UILabel = {
        let label =  UILabel()
        label.font =  .systemFont(ofSize: 18, weight: .light)
        return label
    }()
    private let artistsNameLabel: UILabel = {
        let label =  UILabel()
        label.font =  .systemFont(ofSize: 18, weight: .regular)
        return label
    }()

    
    override init(frame: CGRect){
        super.init(frame: frame)
        contentView.backgroundColor = .secondarySystemBackground
        contentView.addSubview(albumCoverImageView)
        contentView.addSubview(albumNameLabel)
        contentView.addSubview(artistsNameLabel)
        contentView.clipsToBounds = true
        contentView.addSubview(numberofTracksLabel)
        
    }
    required init?(coder: NSCoder){
        fatalError()
    }
    override func  layoutSubviews() {
        super.layoutSubviews()

        
        let imageSize: CGFloat = contentView.height-10
        let albumLabelSize = albumNameLabel.sizeThatFits(CGSize(width: contentView.width-imageSize-10, height: contentView.height-10))
        
        albumNameLabel.sizeToFit()
        artistsNameLabel.sizeToFit()
        numberofTracksLabel.sizeToFit()
        
        
        albumCoverImageView.frame = CGRect(x: 5, y: 5, width: imageSize, height: imageSize)
        
        numberofTracksLabel.frame = CGRect(x: albumCoverImageView.right+10, y: contentView.bottom-44, width: numberofTracksLabel.width, height: 44)
        artistsNameLabel.frame = CGRect(x: albumCoverImageView.right+10, y: albumNameLabel.bottom+5, width: contentView.width - albumCoverImageView.right-5, height: albumLabelSize.height)
        albumNameLabel.frame = CGRect(x: albumCoverImageView.right+10, y: 5, width: albumLabelSize.width, height: min(80,albumLabelSize.height))
    }
    override  func prepareForReuse() {
        super.prepareForReuse()
        albumNameLabel.text =  nil
        artistsNameLabel.text = nil
        numberofTracksLabel.text = nil
        albumCoverImageView.image = nil
    }
    func configure(with viewModel: NewReleasesCellViewModel){
        albumNameLabel.text =  viewModel.name
        artistsNameLabel.text = viewModel.artistName
        numberofTracksLabel.text = "Tracks: \(viewModel.numberOfTracks)"
        let data = try? Data(contentsOf: viewModel.artworkURL!)
        albumCoverImageView.image = UIImage(data: data!)
        
    }
}
//let data = try? Data(contentsOf: url)
//imageView.image = UIImage(data: data!)
