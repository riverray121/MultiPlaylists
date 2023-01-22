//
//  SpotifyAuthManager.swift
//  MultiPlaylistsV0.3
//
//  Created by Elijah Retzlaff on 1/10/23.
//

import Foundation
import SwiftUI
import Combine


final class SpotifyAuthManager: ObservableObject {
    
    static let shared = SpotifyAuthManager()
    
    private let session: URLSession
    private var disposables = Set<AnyCancellable>()
    private var refreshingToken = false
    
    @Published var authResponse: SpotifyAuthResponse?
    
        
    private init(session: URLSession = .shared) {
        self.session = session
    }
    
    
    struct Constants {
        
        private static let bundleInfo = Bundle.main.infoDictionary
        
        static var clientID: String = "YOUR CLIENT ID HERE"
        static var clientSecret: String = "YOUR CLIENT SECRET HERE"
        static let tokenAPIURL = "https://accounts.spotify.com/api/token"
        static let redirectURI = "https://github.com/riverray121"
        static let scopes = """
                                user-read-private\
                                %20playlist-modify-public\
                                %20playlist-read-private\
                                %20playlist-modify-private\
                                %20user-follow-read\
                                %20user-follow-modify\
                                %20user-library-read\
                                %20user-read-email\
                                %20user-library-modify\
                                %20user-read-currently-playing\
                                %20user-read-playback-position\
                                %20user-read-playback-state\
                                %20user-modify-playback-state\
                                %20app-remote-control\
                                %20streaming
                                """
        
        static func getClientID() -> String {
            return clientID
        }
        static func getClientSecret() -> String {
            return clientSecret
        }
        
    }
        
    public var signInURL: URL? {
        let base = "https://accounts.spotify.com/authorize"
        let urlString = """
                            \(base)\
                            ?response_type=code\
                            &client_id=\(Constants.clientID)\
                            &scope=\(Constants.scopes)\
                            &redirect_uri=\(Constants.redirectURI)\
                            &show_dialog=TRUE
                            """
        return URL(string: urlString)
    }
    
    var isSignedIn: Bool {
        return accessToken != nil
    }
    
    private var accessToken: String? {
        return SpotifyUserDefaultsHelper.getData(type: String.self, forKey: .spfyAccessToken)
    }
    
    private var refreshToken: String? {
        return SpotifyUserDefaultsHelper.getData(type: String.self, forKey: .spfyRefreshToken)
    }
    
    private var tokenExpirationDate: Date? {
        return SpotifyUserDefaultsHelper.getData(type: Date.self, forKey: .spfyExpiresIn)
    }
    
    private var shouldRefreshToken: Bool {
        guard let expirationDate = tokenExpirationDate else { return false }
        let currentDate = Date()
        let fiveMinutes: TimeInterval = 300
        return currentDate.addingTimeInterval(fiveMinutes) >= expirationDate
    }
    
    private var onRefreshBlocks = [((String) -> Void)]()
    
    
    
    // MARK: Authentication Process -
    
    /// Supplies a valid token to be used with API calls
    public func withValidToken(completion: @escaping (String) -> Void) {
        guard !refreshingToken else {
            // Append the completion
            onRefreshBlocks.append(completion)
            return
        }
        if shouldRefreshToken {
            // Refresh
            refreshIfNeeded { [weak self] (success) in
                if let token = self?.accessToken, success {
                    completion(token)
                }
            }
        } else if let token = accessToken {
            completion(token)
        }
    }
    
    /// Refreshes the token if needed
    public func refreshIfNeeded(completion: ((Bool) -> Void)?) {
        guard !refreshingToken else {
            return
        }
        
        guard shouldRefreshToken else {
            completion?(true)
            return
        }
        guard let refreshToken = self.refreshToken else {
            return
        }
        // refresh the token
        guard let url = URL(string: Constants.tokenAPIURL) else {return}
        
        // We are currently refreshing
        refreshingToken = true
        
        var components = URLComponents()
        components.queryItems = [
            URLQueryItem(name: "grant_type", value: "refresh_token"),
            URLQueryItem(name: "refresh_token", value: refreshToken)
        ]
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/x-www-form-urlencoded ", forHTTPHeaderField: "Content-Type")
        request.httpBody = components.query?.data(using: .utf8)
        
        let basicToken = Constants.getClientID() + ":" + Constants.getClientSecret()
        let data = basicToken.data(using: .utf8)
        guard let base64String = data?.base64EncodedString() else {
            print("ERROR: Failure to get base64String")
            completion?(false)
            return
        }
        
        request.setValue("Basic \(base64String)", forHTTPHeaderField: "Authorization")
        
        URLSession.shared.dataTask(with: request) { [weak self] (data, _, error) in
            self?.refreshingToken = false
            guard let data = data, error == nil else {
                print("ERROR: Data error")
                completion?(false)
                return
            }
            
            do {
                let result = try JSONDecoder().decode(SpotifyAuthResponse.self, from: data)
                self?.onRefreshBlocks.forEach { $0(result.accessToken) }
                self?.onRefreshBlocks.removeAll()
                print("Successfully refreshed token")
                self?.cacheToken(authInfo: result)
                completion?(true)
            } catch {
                print("ERROR: \(error.localizedDescription)")
                completion?(false)
            }
        }.resume()
    }
    
    private func cacheToken(authInfo: SpotifyAuthResponse) {
        SpotifyUserDefaultsHelper.setData(value: authInfo.accessToken, key: .spfyAccessToken)
        if let refreshToken = authInfo.refreshToken {
            SpotifyUserDefaultsHelper.setData(value: refreshToken, key: .spfyRefreshToken)
        }
        let expiresIn = Date().addingTimeInterval(TimeInterval(authInfo.expiresIn))
        SpotifyUserDefaultsHelper.setData(value: expiresIn, key: .spfyExpiresIn)
    }
    
    public func signOut(completion: (Bool) -> Void) {
        UserDefaults.standard.setValue(nil, forKey: "spfyAccessToken")
        UserDefaults.standard.setValue(nil, forKey: "spfyRefreshToken")
        UserDefaults.standard.setValue(nil, forKey: "spfyExpiresIn")
        UserDefaults.standard.setValue(nil, forKey: PublicConstant.ud_loginUserID)
        MainAuthManager.shared.spotifyAuthenticationState = .unauthenticated
        MainAuthManager.shared.updateGeneralAuthState()
        completion(true)
    }
    

    var signInUrlRequest: URLRequest {
        guard let url = SpotifyAuthManager.shared.signInURL else {
            fatalError()
        }
        return URLRequest(url: url)
    }
    
    
    
    // MARK: Authentication Exchange -
    
    func makeExchangeCodeRequest(code: String) -> URLRequest? {
        guard let url = URL(string: Constants.tokenAPIURL) else {
            return nil
        }
        
        var components = URLComponents()
        components.queryItems = [
            URLQueryItem(name: "grant_type", value: "authorization_code"),
            URLQueryItem(name: "code", value: code),
            URLQueryItem(name: "redirect_uri", value: Constants.redirectURI)
        ]

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/x-www-form-urlencoded ", forHTTPHeaderField: "Content-Type")
        request.httpBody = components.query?.data(using: .utf8)

        let basicToken = Constants.getClientID() + ":" + Constants.getClientSecret()
        let data = basicToken.data(using: .utf8)
        guard let base64String = data?.base64EncodedString() else {
            print("ERROR: Failure to get base64String")
            return nil
        }

        request.setValue("Basic \(base64String)", forHTTPHeaderField: "Authorization")
        
        return request
    }
        
    
    func exchangeCodeForToken(code: String) -> AnyPublisher<SpotifyAuthResponse, SpotifyError> {
        exchange(with: makeExchangeCodeRequest(code: code))
    }
    
    private func exchange<T>(with request: URLRequest?) -> AnyPublisher<T, SpotifyError> where T: Decodable {
        guard let urlRequest = request else {
            let error = SpotifyError.network(description: "Couldn't create URL")
            return Fail(error: error)
                .eraseToAnyPublisher()
        }
        
        return session.dataTaskPublisher(for: urlRequest)
            .mapError { error in
                SpotifyError.network(description: error.localizedDescription)
            }
            .flatMap(maxPublishers: .max(1)) { pair in
                decode(pair.data)
            }
            .eraseToAnyPublisher()
    }
    
    
    // MARK: Authentication Fetching -
    
    func fetchAuthResponse(using code: String) {
        fetchToken(forCode: code) { authResponse in
            self.cacheToken(authInfo: authResponse)
        }
        
    }
    
    private func fetchToken(forCode code: String, completion: @escaping ((SpotifyAuthResponse) -> Void)) {
        exchangeCodeForToken(code: code)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: {[weak self] value in
                guard let self = self else { return }
                switch value {
                case .failure:
                    self.authResponse = nil
                case .finished: break
                }
            }, receiveValue: {[weak self] auth in
                guard let self = self else { return }
                self.authResponse = auth
                MainAuthManager.shared.spotifyAuthenticationState = .authenticated
                MainAuthManager.shared.updateGeneralAuthState()
                completion(auth)
            })
            .store(in: &disposables)
    }
    
}
