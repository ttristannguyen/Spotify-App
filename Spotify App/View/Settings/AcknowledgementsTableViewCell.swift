//
//  AcknowledgementsTableViewCell.swift
//  Spotify App
//
//  Created by Tristan Nguyen on 10/6/2022.
//

import UIKit

class AcknowledgementsTableViewCell: UITableViewCell {
    
    static let identifier = "AcknowledgementsTableViewCell"
        
    let urlLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 14, weight: .thin)
        label.textColor = .systemBlue
        return label
    }()
    let locationLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 16, weight: .semibold)
        return label
    }()
    let useLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 16, weight: .regular)
        return label
    }()
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(urlLabel)
        contentView.addSubview(locationLabel)
        contentView.addSubview(useLabel)
        contentView.clipsToBounds = true
    }
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        locationLabel.frame = CGRect(x: 5, y: -50, width: contentView.width, height: contentView.height)
        useLabel.frame = CGRect(x: 5, y: 0, width: contentView.width, height: contentView.height)
        urlLabel.frame = CGRect(x: 5, y: 50, width: contentView.width, height: contentView.height)
        
    }
    override func prepareForReuse() {
        super.prepareForReuse()
        locationLabel.text = nil
        urlLabel.text = nil
        useLabel.text = nil
    }
    func configure(with viewModel: AcknowledgementsTableViewCellViewModel ){
        locationLabel.text = viewModel.locationLabel
        urlLabel.text = viewModel.urlLabel
        useLabel.text = viewModel.useLabel
    }
}
