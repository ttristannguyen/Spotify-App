//
//  UserProfile.swift
//  Spotify App
//
//  Created by Tristan Nguyen on 11/5/2022.
//

import Foundation

struct UserProfile: Codable{
    let country: String
    let display_name: String
    let email: String
    let explicit_content: [String: Bool]
    let external_urls: [String: String]
////    let followers:[String: Codable?]
    let id: String
    let images: [APIImage]
    let product: String
}

//{
