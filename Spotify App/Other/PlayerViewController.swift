//
//  PlayerViewController.swift
//  Spotify App
//
//  Created by Tristan Nguyen on 25/5/2022.
//

import UIKit
import CoreData
protocol PlayerViewControllerDelegate: AnyObject{
    func didTapPlayPause()
    func didTapForward()
    func didTapBackward()
    func didSliderSlider(_ value: Float)
}
//protocol StorageTableDelegate: AnyObject {
//    func didSaveSong()
//}

class PlayerViewController: UIViewController {

    weak var dataSource: PlayerDataSource?
    weak var delegate: PlayerViewControllerDelegate?
    var StorageController = StorageTableViewController()
//    weak var delegate2: StorageTableDelegate?
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .systemRed
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
//    private let screenView: UIView = {
//        let myView = UIView()
//        myView.frame = view.bounds
//        myView.backgroundColor = UIColor(white: 1, alpha: 0.5)
//        return myView
//    }()
    

    private let controlsView = PlayerControlsView()
    
    override func viewDidLoad() {
        
        let gestureRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(didSwipe(_:)))
        gestureRecognizer.direction = .right
        gestureRecognizer.numberOfTouchesRequired = 1
        view.addGestureRecognizer(gestureRecognizer)
        
        
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        view.addSubview(imageView)
        view.addSubview(controlsView)
        view.isUserInteractionEnabled = true
//        view.addSubview(screenView)
        configureBarButtons()
        controlsView.delegate = self // This View Controller (PlayerViewController) becomes PlayerControlsView's delegate
        // ie PlayerViewController is going to do the protocol functions of PlayerControlsView
        // Do any additional setup after loading the view.
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
        let data = try? Data(contentsOf: (dataSource?.imageURL!)!)
        imageView.image = UIImage(data: data!)
        controlsView.configure(with: PlayerControlsViewModel(
            title: dataSource?.songName,
            subtitle: dataSource?.subtitle))
    }
    @objc func didSwipe(_ gesture: UISwipeGestureRecognizer){
//        print(dataSource?.songName)
//        print(dataSource?.subtitle)
//        print(dataSource?.imageString)
//        print(dataSource?.previewString)
        print("Gesture Fired")
        
        
        let newSavedSong = SavedSongs(context: self.context)
        newSavedSong.songName = dataSource?.songName
        newSavedSong.artistName = dataSource?.subtitle
        newSavedSong.imageString = dataSource?.imageString
        newSavedSong.previewString = dataSource?.previewString
        
        do{
            print("Saving Song")
            try self.context.save()
            let alert = UIAlertController(title: "Saved", message: "Song has been Saved", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            print("Saved")
        }
        catch {
            let alert = UIAlertController(title: "Error", message: "Failed to Save Song", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
        StorageController.fetchSavedSongs()
        
        
        
        
        
    }
    
    private func configureBarButtons(){
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .close, target: self, action: #selector(didTapClose))
//        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(didTapAction))
    }
    @objc private func didTapClose(){
        dismiss(animated: true, completion: nil)
    }
    @objc private func didTapAction(){
        
    }
    func refreshUI() {
        configure()
    }
    
    
    

}
extension PlayerViewController: PlayerControlsViewDelegate{
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
