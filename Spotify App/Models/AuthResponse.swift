//
//  AuthResponse.swift
//  Spotify App
//
//  Created by Tristan Nguyen on 5/5/2022.
//

import Foundation
struct AuthResponse: Codable {
    let access_token: String
    let expires_in: Int
    let refresh_token: String?
    let scope: String
    let token_type: String
}
