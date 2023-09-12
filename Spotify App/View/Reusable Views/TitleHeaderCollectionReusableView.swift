//
//  TitleHeaderCollectionReusableView.swift
//  Spotify App
//
//  Created by Tristan Nguyen on 19/5/2022.
//

import UIKit
// Titles for New Releases, Featured Playlists, Recomended Tracks
class TitleHeaderCollectionReusableView: UICollectionReusableView {
        static let identifier = "TitleHeaderCollectionReusableView"
    
    private let label: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.numberOfLines = 1     // Sizing
        label.font = .systemFont(ofSize: 22, weight: .light)
        return label
    }()
    
    override init(frame: CGRect){
        super.init(frame: frame)
        backgroundColor = .systemBackground
        addSubview(label) // add label
    }
    required init?(coder: NSCoder) {
        fatalError()
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        label.frame = CGRect(x: 15, y: 0, width: width-30, height: height) // Position
    }
    
    func configure(with title: String){
        label.text = title
    }
    
}
