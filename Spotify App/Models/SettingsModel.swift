//
//  SettingsModel.swift
//  Spotify App
//
//  Created by Tristan Nguyen on 11/5/2022.
//

import Foundation

struct Section {
    let title: String
    let options: [Option]
}
struct Option {
    let title: String
    let handler: () -> Void
    
}

