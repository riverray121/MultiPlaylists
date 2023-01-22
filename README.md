# MultiPlaylists - SoundCloud and Spotify In One

## Description

An unfinished SwiftUI app built to combine Spotify and SoundCloud into a single app to allow fo the creation of cross platform playlists.

As stands the authentication process for SoundCloud and Spotify are both fully implemented as well as Spotify API calls for play/pause of a Spotify player and an integration of a Spotify player within the app using an embeded [Spotify WebPlayerSDk Website](https://github.com/riverray121/SpotifyReactExpresssPlayer) built seperately.

The vision for the application as a whole was for a combination of all music services into a single platform to allow for cross-platform playlists as well as a reimagniation of the music sharing experience to be more personalized and communal. In doing so the hope was to create a more personalized profile (song of the day, personalized audio listening or dj settings, custom generated visuals for your playlists, etc.) and a better music sharing experience with friends (dm's for sharing songs or playlists, radio stations for better group listening, etc.).

Unfortunately, [SoundCloud has ended new access to their API since 2018ish](https://docs.google.com/forms/d/e/1FAIpQLSfNxc82RJuzC0DnISat7n4H-G7IsPQIdaMpe202iiHZEoso9w/closedform) forcing usage of their private API2 in this application (likely goes against their ToS) and the mear combination of these two services along with all future ideas expressed above violates the [Spotify Developer Policy](https://developer.spotify.com/policy/) (III. Some prohibited applications).

Built for iOS 16+ with Combine and SwiftUI.

## Usage

1. Clone this repository
2. Create an app on the [Spotify Developer website](https://developer.spotify.com/dashboard/login)
3. Add <https://github.com/riverray121> to your redirect URI's of your new Spotify App (Dashbord -> Your App -> Edit Settings)
4. Copy your Client ID and Client Secret to the SpotifyAuthManager file in the cloned Xcode project (MultiPlaylistsV0.3 -> Managers -> SpotifyAuthManager)
5. Run the project on the iOS simulator or on your own iOS device

## Details

### Uses

* [Spotify Web API](https://developer.spotify.com/documentation/web-api/)
* [Spotify WebPlayerSDk Website](https://github.com/riverray121/SpotifyReactExpresssPlayer)
* [SoundCloud Private API Access Package](https://github.com/lbrndnr/soundcloud)
* [Combine Framework](https://developer.apple.com/documentation/combine)

### Screenshots

![alt text](https://github.com/riverray121/MultiPlaylists/blob/main/imgs/loggedin.PNG?raw=true)
