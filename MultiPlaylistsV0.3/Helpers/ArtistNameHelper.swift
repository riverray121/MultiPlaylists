//
//  ArtistNameHelper.swift
//  MultiPlaylistsV0.3
//
//  Created by Elijah Retzlaff on 1/21/23.
//

import Foundation

struct ArtistNameHelper {
    static func getArtistsName(artists: [SpotifyArtist]) -> String {
        let artistsnames = artists.compactMap { $0.name }
        return artistsnames.joined(separator: ", ")
    }
}
