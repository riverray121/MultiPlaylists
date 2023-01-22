//
//  SpotifyTrack.swift
//  MultiPlaylistsV0.3
//
//  Created by Elijah Retzlaff on 1/21/23.
//

import Foundation

// MARK: - Track
public struct SpotifyTrack: Codable {
    public var album: SpotifyAlbum?
    public let artists: [SpotifyArtist]?
    public let availableMarkets: [String]?
    public let discNumber: Int?
    public let durationms: Int
    public let episode: Bool?
    public let explicit: Bool
//    public let externalids: Externalids?
//    public let externalUrls: ExternalUrls
    public let href: String
    public let id: String
    public let isLocal: Bool
    public let name: String
    public let popularity: Int?
    public let previewurl: String?
    public let trackNumber: Int
//    public let type: TrackType
    public let uri: String
//    public let restrictions: Restrictions?
    public let images: [ImageModel]?


    enum CodingKeys: String, CodingKey {
        case album = "album"
        case artists = "artists"
        case availableMarkets = "available_markets"
        case discNumber = "disc_number"
        case durationms = "duration_ms"
        case episode = "episode"
        case explicit = "explicit"
//        case externalids = "external_ids"
//        case externalUrls = "external_urls"
        case href = "href"
        case id = "id"
//        case restrictions = "restrictions"
        case isLocal = "is_local"
        case name = "name"
        case popularity = "popularity"
        case previewurl = "preview_url"
        case trackNumber = "track_number"
//        case type = "type"
        case uri = "uri"
        case images = "images"
    }

    public init(
        album: SpotifyAlbum?,
        artists: [SpotifyArtist]?,
        availableMarkets: [String]?,
        discNumber: Int,
        durationms: Int,
        episode: Bool?,
        explicit: Bool,
//        externalids: Externalids?,
//        externalUrls: ExternalUrls,
        href: String,
        id: String,
        isLocal: Bool,
        name: String,
        popularity: Int?,
        previewurl: String?,
        track: Bool?,
        trackNumber: Int,
//        type: TrackType,
        uri: String,
//        restrictions: Restrictions?,
        images:[ImageModel]?)
    {
        self.album = album
        self.artists = artists
        self.availableMarkets = availableMarkets
        self.discNumber = discNumber
        self.durationms = durationms
        self.episode = episode
        self.explicit = explicit
//        self.externalids = externalids
//        self.externalUrls = externalUrls
        self.href = href
        self.id = id
        self.isLocal = isLocal
        self.name = name
        self.popularity = popularity
        self.previewurl = previewurl
        self.trackNumber = trackNumber
//        self.type = type
        self.uri = uri
//        self.restrictions = restrictions
        self.images = images
    }
}
