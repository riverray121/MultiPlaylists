//
//  SpotifyImageModel.swift
//  MultiPlaylistsV0.3
//
//  Created by Elijah Retzlaff on 1/21/23.
//

import Foundation

// MARK: - Image
public struct ImageModel: Codable {
    public let height: Int?
    public let url: String
    public let width: Int?

    enum CodingKeys: String, CodingKey {
        case height = "height"
        case url = "url"
        case width = "width"
    }

    public init(height: Int?, url: String, width: Int?) {
        self.height = height
        self.url = url
        self.width = width
    }
}
