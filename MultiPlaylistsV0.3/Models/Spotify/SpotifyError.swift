//
//  SpotifyError.swift
//  MultiPlaylistsV0.3
//
//  Created by Elijah Retzlaff on 1/10/23.
//

import Foundation

enum SpotifyError: Error {
    case parsing(description: String)
    case network(description: String)
}
