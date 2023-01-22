//
//  SpotifyAPICaller.swift
//  MultiPlaylistsV0.3
//
//  Created by Elijah Retzlaff on 1/10/23.
//

import Foundation

public struct PublicConstant {
    static var loginUserID: String = ""
    static let ud_loginUserID = "loginUserID"
    
    static func getLoginUserId() -> String{
        if loginUserID.isEmpty {
            loginUserID = UserDefaults.standard.string(forKey: PublicConstant.ud_loginUserID) ?? ""
        }
        return loginUserID
    }
    
    static func setLoginUserID(userID: String){
        UserDefaults.standard.set(userID, forKey: PublicConstant.ud_loginUserID)
    }
}



final class SpotifyAPICaller {
    static let shared = SpotifyAPICaller()
    
    private init() {}
    
    struct Constants {
        static let baseAPIURL = "https://api.spotify.com/v1"
    }
    
    enum APIError: Error {
        case failedToGetData
    }
    
    
    
    // MARK: - Spotify Player
    
    public func playOrResumePlayback(context_uri: String?, uris: [String]?, offset: Int?, postion_ms: Int, completion: @escaping (Bool) -> Void) {
        createRequest(with: URL(string: Constants.baseAPIURL + "/me/player/play"), type: .PUT) { baseRequest in
            var request = baseRequest
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")

            if (context_uri != nil && offset != nil) {
                let body = ["context_uri": context_uri!, "offset": ["position": offset], "position_ms": postion_ms] as [String : Any]
                let jsonData = try? JSONSerialization.data(withJSONObject: body)
                request.httpBody = jsonData
            } else if (uris != nil) {
                let body = ["uris": uris!, "position_ms": postion_ms] as [String : Any]
                let jsonData = try? JSONSerialization.data(withJSONObject: body)
                request.httpBody = jsonData
            }
            
            let task = URLSession.shared.dataTask(with: request) {data, response, error in
                guard let code = (response as? HTTPURLResponse)?.statusCode,
                      error == nil else {
                          completion(false)
                          return
                      }
                completion(code == 204)
            }
            task.resume()
        }
    }
    
    
    public func pausePlayback(completion: @escaping (Bool) -> Void) {
        createRequest(with: URL(string: Constants.baseAPIURL + "/me/player/pause"), type: .PUT) { baseRequest in
            var request = baseRequest
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            let task = URLSession.shared.dataTask(with: request) {data, response, error in
                guard let code = (response as? HTTPURLResponse)?.statusCode,
                      error == nil else {
                          completion(false)
                          return
                      }
                completion(code == 204)
            }
            task.resume()
        }
    }
    
    
    // MARK: - User Profile
    
    public func getCurrentUserProfile(completion: @escaping (Result<SpotifyUserProfile, Error>) -> Void) {
        createRequest(with: URL(string: Constants.baseAPIURL + "/me"), type: .GET) { baseRequest in
            let task = URLSession.shared.dataTask(with:  baseRequest) { data, _, error in
                guard let data = data, error == nil else {
                    completion(.failure(APIError.failedToGetData))
                    return
                }
                do {
                    let result = try JSONDecoder().decode(SpotifyUserProfile.self, from: data)
                    PublicConstant.setLoginUserID(userID: result.id)
                    completion(.success(result))
                } catch {
                    print(error.localizedDescription)
                    completion(.failure(error))
                }
            }
            task.resume()
        }
    }
    
    
    // MARK: - Private
    
    enum HTTPMethod: String {
        case GET
        case POST
        case DELETE
        case PUT
    }
    
    private func createRequest(with url: URL?, type: HTTPMethod, completion: @escaping (URLRequest) -> Void) {
        SpotifyAuthManager.shared.withValidToken { token in
            guard let apiURL = url else { return }
            var request = URLRequest(url: apiURL)
            request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
            request.setValue("application/json", forHTTPHeaderField: "Accept")
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            request.httpMethod = type.rawValue
            request.timeoutInterval = 30
            completion(request)
        }
    }
}
