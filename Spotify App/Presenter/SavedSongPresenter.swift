//
//  SavedSongPresenter.swift
//  Spotify App
//
//  Created by Tristan Nguyen on 9/6/2022.
//

import AVFoundation
import Foundation
import UIKit
import CoreData

final class SavedSongPresenter{
    
    
    
    static let shared = SavedSongPresenter()
    
    
    var player: AVPlayer?

    var currentTrack = savedSong()
    
    
    
    func startSavedSongPlayback(from viewController: UIViewController,
                                song: savedSong){
        guard let url = URL(string: song.preview_URL ?? "" ) else{
            return
        }
            currentTrack.artistName = song.artistName
//        print(song.artistName)
            currentTrack.image_URL = song.image_URL
            currentTrack.songName = song.songName
//            print(currentTrack.songName)
//            print(currentTrack.artistName)
//            print(currentTrack.image_URL)
        
        UserDefaults.standard.set(song.artistName, forKey: "artistName")
        UserDefaults.standard.set(song.image_URL, forKey: "image_URL")
        UserDefaults.standard.set(song.songName, forKey: "songName")
        
        player = AVPlayer(url: url)
        player?.volume = 0.5
        
        let vc = SavedSongPlayerViewController()
        vc.title = song.songName
    //        vc.dataSource = self
            vc.delegate = self
        
        viewController.present(UINavigationController(rootViewController: vc),animated: true) { [weak self] in
            self?.player?.play()
            }
        
        }
}


extension SavedSongPresenter: SavedSongPlayerViewControllerDelegate
{
    func didTapPlayPause() {
        if let player = player {
            if player.timeControlStatus == .playing {
                player.pause()
            }
            else {
                if player.timeControlStatus == .paused {
                player.play()
                }
            }
        }
    }
    
    func didTapForward() {
        player?.pause()
    }
    
    func didTapBackward() {
        player?.pause()
    }
    func didSliderSlider(_ value: Float) {
        player?.volume = value
    }
}
