//
//  SavedSongPlayerViewController.swift
//  Spotify App
//
//  Created by Tristan Nguyen on 9/6/2022.
//

import UIKit
protocol SavedSongPlayerViewControllerDelegate: AnyObject{
    func didTapPlayPause()
    func didTapForward()
    func didTapBackward()
    func didSliderSlider(_ value: Float)
}

class SavedSongPlayerViewController: UIViewController, PlayerControlsViewDelegate {
    
    
    weak var delegate: SavedSongPlayerViewControllerDelegate?
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .systemRed
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    private let controlsView = PlayerControlsView()
    
    
    override func viewDidLoad() {
        
        
        super.viewDidLoad()
        
        var savedArtistName = UserDefaults.standard.string(forKey: "artistName")
        var savedImage_URL = UserDefaults.standard.string(forKey: "image_URL")
        var savedSongName = UserDefaults.standard.string(forKey: "songName")
//        print(savedImage_URL)
        
        view.backgroundColor = .systemBackground
        view.addSubview(imageView)
        view.addSubview(controlsView)
        controlsView.delegate = self
        
        view.isUserInteractionEnabled = true
        configureBarButtons()
        configure()
        

    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        imageView.frame = CGRect(
            x: 0,
            y: view.safeAreaInsets.top,
            width: view.width,
            height: view.width)
        controlsView.frame = CGRect(
            x: 10,
            y: imageView.bottom+10,
            width: view.width-20,
            height: view.height-imageView.height-view.safeAreaInsets.top-view.safeAreaInsets.bottom-15)
    }
    private func configure(){
        let url = URL(string: UserDefaults.standard.string(forKey: "image_URL") ?? "")
        let data = try? Data(contentsOf: (url!))
        imageView.image = UIImage(data: data!)
//        print(dataSource)
//        print(dataSource?.artistName)
//        print(dataSource?.songName)
//        print(dataSource?.imageURL)
        controlsView.configure(with: PlayerControlsViewModel(
            title: UserDefaults.standard.string(forKey: "songName"),
            subtitle: UserDefaults.standard.string(forKey: "artistName")
))
    }
    private func configureBarButtons(){
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .close, target: self, action: #selector(didTapClose))
    }
    @objc private func didTapClose(){
        dismiss(animated: true, completion: nil)
    }
    

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
extension SavedSongPlayerViewController{
    func playControlsViewDidTapPlayPauseButton(_ playerControlsView: PlayerControlsView) {
        delegate?.didTapPlayPause()
    }
    
    func playControlsViewDidTapForwardsButton(_ playerControlsView: PlayerControlsView) {
        delegate?.didTapForward()
    }
    
    func playControlsViewDidTapBackwardsButton(_ playerControlsView: PlayerControlsView) {
        delegate?.didTapBackward()
    }
    func playControlsView(_ playerControlsView: PlayerControlsView, didSlideSlider value: Float) {
        delegate?.didSliderSlider(value)
    }
}


