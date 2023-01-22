//
//  SpotifyAlbum.swift
//  MultiPlaylistsV0.3
//
//  Created by Elijah Retzlaff on 1/21/23.
//

import Foundation


// MARK: - Album
public struct SpotifyAlbum: Codable {
    public let albumType: String
    public let artists: [SpotifyArtist]
    public let availableMarkets: [String]
//    public let externalUrls: ExternalUrls
    public let href: String
    public let id: String
    public let images: [ImageModel]
    public let name: String
    public let releaseDate: String
    public let releaseDatePrecision: String
    public let totalTracks: Int
//    public let type: AlbumTypeEnum?
    public let uri: String
//    public var tracks: Tracks?
    
    enum CodingKeys: String, CodingKey {
        case albumType = "album_type"
        case artists = "artists"
        case availableMarkets = "available_markets"
//        case externalUrls = "external_urls"
        case href = "href"
        case id = "id"
        case images = "images"
        case name = "name"
        case releaseDate = "release_date"
        case releaseDatePrecision = "release_date_precision"
        case totalTracks = "total_tracks"
//        case type = "type"
        case uri = "uri"
//        case tracks = "tracks"
    }

    public init(
        albumType: String,
        artists: [SpotifyArtist],
        availableMarkets: [String],
//        externalUrls: ExternalUrls,
        href: String,
        id: String,
        images: [ImageModel],
        name: String,
        releaseDate: String,
        releaseDatePrecision: String,
        totalTracks: Int,
//        type: AlbumTypeEnum?,
        uri: String
//        ,
//        tracks: Tracks?
    ) {
        self.albumType = albumType
        self.artists = artists
        self.availableMarkets = availableMarkets
//        self.externalUrls = externalUrls
        self.href = href
        self.id = id
        self.images = images
        self.name = name
        self.releaseDate = releaseDate
        self.releaseDatePrecision = releaseDatePrecision
        self.totalTracks = totalTracks
//        self.type = type
        self.uri = uri
//        self.tracks = tracks
    }
}
