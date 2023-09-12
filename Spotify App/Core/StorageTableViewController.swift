//
//  StorageTableViewController.swift
//  Spotify App
//
//  Created by Tristan Nguyen on 4/5/2022.
//

import UIKit
import CoreData
import CoreMedia

class savedSong{
    var artistName: String?
    var songName: String?
    var preview_URL: String?
    var image_URL: String?
}

class StorageTableViewController: UIViewController,UITableViewDelegate, UITableViewDataSource {

    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    var savedSongs: [SavedSongs]?
    
    let songToPlay = savedSong()

    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.isPagingEnabled = true
        return scrollView
    }()
    let tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(StorageUITableViewCell.self, forCellReuseIdentifier: StorageUITableViewCell.identifier)
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        UIApplication.shared.delegate as! AppDelegate.persistentContainer.viewContext
        
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        view.backgroundColor = .systemBackground
        fetchSavedSongs()
//        scrollView.addSubview(scrollView)
//        scrollView.delegate = self

    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
    }
    
    func fetchSavedSongs(){
        print("Fetching...")//        self.tableView.reloadData()
        do {
            self.savedSongs = try context.fetch(SavedSongs.fetchRequest())
            print("Fetched")
            
            DispatchQueue.main.async {
                self.tableView.reloadData()
                print("Reloded Table")
            }
        }
        catch {
            
        }
        self.tableView.reloadData()
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return savedSongs?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: StorageUITableViewCell.identifier, for: indexPath) as? StorageUITableViewCell else{
            return UITableViewCell()
        }
        let song = self.savedSongs?[indexPath.row]
        let viewModel = StorageTableViewModel(
            songName: song?.songName,
            artistName: song?.artistName,
            imageURL: URL(string: song?.imageString ?? ""))
        cell.configure(with: viewModel)
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let song = self.savedSongs?[indexPath.row]
        songToPlay.songName = song?.songName
        songToPlay.artistName = song?.artistName
        songToPlay.image_URL = song?.imageString
        songToPlay.preview_URL = song?.previewString
        SavedSongPresenter.shared.startSavedSongPlayback(from: self, song: songToPlay)
        
        
        
        
        
        return
    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            print("Delete")
            let songtoRemove = self.savedSongs![indexPath.row]
            self.context.delete(songtoRemove)
            do {
                try self.context.save()
            }
            catch {
                
            }
            
            self.fetchSavedSongs()
        }
    }
}

