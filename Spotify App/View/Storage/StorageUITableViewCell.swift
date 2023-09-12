//
//  StorageUITableViewCell.swift
//  Spotify App
//
//  Created by Tristan Nguyen on 9/6/2022.
//

import UIKit

class StorageUITableViewCell: UITableViewCell {

    static let identifier = "StorageUITableViewCell"
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    private let songLabel: UILabel = {
        let label = UILabel()
        label.font =  .systemFont(ofSize:  18, weight: .semibold)
        label.numberOfLines = 1
        return label
    }()
    private let artistLabel: UILabel = {
        let label = UILabel()
        label.textColor = .secondaryLabel
        label.font =  .systemFont(ofSize:  12, weight: .regular)
        label.numberOfLines = 1
        return label
    }()
    private let iconImageView: UIImageView = {
       let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(songLabel)
        contentView.addSubview(artistLabel)
        contentView.addSubview(iconImageView)
        contentView.clipsToBounds = true
        
        
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        let imageSize: CGFloat = contentView.height-10
        iconImageView.frame = CGRect(x: 10, y: 5, width: imageSize, height: imageSize)
//        iconImageView.layer.cornerRadius = imageSize/2 // CIRCLE
//        iconImageView.layer.masksToBounds = true
        songLabel.frame = CGRect(x: iconImageView.right+8, y: -8, width: contentView.width-iconImageView.right-15, height: contentView.height)
        artistLabel.frame = CGRect(x: iconImageView.right+10, y: 10, width: contentView.width-iconImageView.right-15, height: contentView.height)
    }
    override func prepareForReuse() {
        super.prepareForReuse()
        iconImageView.image = nil
        songLabel.text = nil
        artistLabel.text = nil
    }
    func configure(with viewModel: StorageTableViewModel ) {
        songLabel.text = viewModel.songName
        artistLabel.text = viewModel.artistName
        let data = try? Data(contentsOf: viewModel.imageURL!)
        iconImageView.image = UIImage(data: data!)
    }
    
}
