//
//  PlaybackPresenter.swift
//  Spotify App
//
//  Created by Tristan Nguyen on 25/5/2022.
//
import AVFoundation
import Foundation
import UIKit
import CoreData

protocol PlayerDataSource: AnyObject {
    var songName: String? { get }
    var subtitle: String? { get } // variables are instantiated and create upon genesis
    var imageURL: URL? { get }
//    var previewURL: URL? { get }
    var imageString: String? { get }
    var previewString: String? { get }
}


final class PlaybackPresenter {

    
    static let shared = PlaybackPresenter()

    private var track: AudioTrack?
    private var tracks = [AudioTrack]()
    var playerVC: PlayerViewController?
    var index = 0
    var currentTrack: AudioTrack? {
        if let track = track, tracks.isEmpty {
//            print(track)
            return track
        }
        else if let player = self.playerQueue, !tracks.isEmpty {

            return tracks[index]
        }
        return nil
    }
    
    var player: AVPlayer?
    var playerQueue: AVQueuePlayer?

    
    func startPlayback(from viewController: UIViewController,
                              track: AudioTrack){
        guard let url = URL(string: track.preview_url ?? "" ) else{
            return
        }
        player = AVPlayer(url: url)
        player?.volume = 0.5
        
        
        self.track = track
        self.tracks = []
        
    
        let vc = PlayerViewController()
        vc.title = track.name
        vc.dataSource = self
        vc.delegate = self // PlaybackPresenter is now PlayerViewControllers delegate
        viewController.present(UINavigationController(rootViewController: vc),animated: true) { [weak self] in
            self?.player?.play()
        }
        self.playerVC = vc
        }

    
    func startPlayback(from viewController: UIViewController,
                          tracks: [AudioTrack]){
        self.track = nil
        self.tracks = tracks
        
        self.playerQueue = AVQueuePlayer(items: tracks.compactMap({
            guard let url = URL(string: $0.preview_url ?? "") else { // for each track, put what comes after the preview url into the items array which is an array of AVPlayer
                return nil
            }
            return AVPlayerItem(url: url)
        }))
        self.playerQueue?.volume = 0.5
        
        
        let vc = PlayerViewController()
        vc.dataSource = self
        vc.delegate = self // PlaybackPresenter is now PlayerViewControllers delegate
        viewController.present(UINavigationController(rootViewController: vc),animated: true, completion: nil)
        self.playerQueue?.play()
        self.playerVC = vc
            }
        
}
extension PlaybackPresenter: PlayerDataSource {
    var songName: String? {
        return currentTrack?.name
        
    }
    
    var subtitle: String? {
        return currentTrack?.artists.first?.name
    }
    
    var imageURL: URL? {
        return URL(string: currentTrack?.album?.images.first?.url ?? "")
    }
    
    var imageString: String? {
        return currentTrack?.album?.images.first?.url ?? ""
    }
    var previewString: String? {
        track?.preview_url ?? ""
    }
    
    
}
extension PlaybackPresenter: PlayerViewControllerDelegate
{
    func didTapPlayPause() {
        if let player = player {
            if player.timeControlStatus == .playing {
                player.pause()
            }
            else if player.timeControlStatus == .paused {
                player.play()
            }
            
        }
        else if let player = playerQueue {
            if player.timeControlStatus == .playing {
                player.pause()
            }
            else if player.timeControlStatus == .paused {
                player.play()
            }

        }
    }
    
    func didTapForward() {
        if tracks.isEmpty {
            player?.pause()
        }
        else if let player = playerQueue {
            playerQueue?.advanceToNextItem()
            index += 1
            playerVC?.refreshUI()
            
        }
    }
    
    func didTapBackward() {
        if tracks.isEmpty {
            player?.pause()
            player?.play() // pause -> play replays song
            
        }
        else if let firstItem = playerQueue?.items().first {
            playerQueue?.pause()
            playerQueue?.removeAllItems()
            playerQueue = AVQueuePlayer(items: [firstItem])
            playerQueue?.play()
            playerQueue?.volume = 0.5
            
        }
        
    }
    func didSliderSlider(_ value: Float) {
        player?.volume = value
    }
}
