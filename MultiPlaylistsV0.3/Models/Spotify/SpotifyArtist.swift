//
//  SpotifyArtist.swift
//  MultiPlaylistsV0.3
//
//  Created by Elijah Retzlaff on 1/21/23.
//

import Foundation


// MARK: - Artist
public class SpotifyArtist: Codable {
//    public let externalUrls: ExternalUrls
//    public let followers: Followers?
    public let genres: [String]?
    public let href: String
    public let id: String
    public let images: [ImageModel]?
    public let name: String
    public let popularity: Int?
    public let type: String
    public let uri: String

    enum CodingKeys: String, CodingKey {
//        case externalUrls = "external_urls"
//        case followers = "followers"
        case genres = "genres"
        case href = "href"
        case id = "id"
        case images = "images"
        case name = "name"
        case popularity = "popularity"
        case type = "type"
        case uri = "uri"
    }

    public init(
//        externalUrls: ExternalUrls,
//        followers: Followers,
        genres: [String],
        href: String,
        id: String,
        images: [ImageModel],
        name: String,
        popularity: Int,
        type: String,
        uri: String) {
//        self.externalUrls = externalUrls
//        self.followers = followers
        self.genres = genres
        self.href = href
        self.id = id
        self.images = images
        self.name = name
        self.popularity = popularity
        self.type = type
        self.uri = uri
    }
}
