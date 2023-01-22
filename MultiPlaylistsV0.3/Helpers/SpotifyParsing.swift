//
//  SpotifyParsing.swift
//  MultiPlaylistsV0.3
//
//  Created by Elijah Retzlaff on 1/10/23.
//

import Foundation
import Combine

func decode<T: Decodable>(_ data: Data) -> AnyPublisher<T, SpotifyError> {
    let decoder = JSONDecoder()
    decoder.dateDecodingStrategy = .secondsSince1970
    
    return Just(data)
        .decode(type: T.self, decoder: decoder)
        .mapError { error in
            SpotifyError.parsing(description: error.localizedDescription)
        }
        .eraseToAnyPublisher()
}
