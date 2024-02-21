//
//  MainViewModel.swift
//  AsyncAwait
//
//  Created by Cenk Bahadır Çark on 16.02.2024.
//

import Foundation

final class MainViewModel: MainViewModelProtocol {
    weak var delegate: MainViewModelDelegate?
    var tabListSection: [TabListSection] = []
    var songsList: MostPlayedSongResponse?
    var appsList: MostPlayedSongResponse?
    var booksList: MostPlayedSongResponse?
    var podcastsList: MostPlayedSongResponse?
    
    private let dataProvider: MainDataProviderProtocol
    
    init(dataProvider: MainDataProviderProtocol) {
        self.dataProvider = dataProvider
    }
    
    func fetchSongs() {
        Task {
            do {
                songsList = try await dataProvider.fetchMostPlayedSongs(endPoint: MainEndPoint.music)
                self.tabListSection.append(.songs)
                delegate?.handle(.reloadTableView)
            }catch {
                print(("Foo fetchSongs error: \(error.localizedDescription)"))
            }
        }
    }
    
    func fetchApps() {
        Task {
            do {
                appsList = try await dataProvider.fetchApps(endPoint: MainEndPoint.apps)
                self.tabListSection.append(.apps)
                delegate?.handle(.reloadTableView)
            }catch {
                print(("Foo fetchApps error: \(error.localizedDescription)"))
            }
        }
    }
    
    func fetchBooks() {
        Task {
            do {
                booksList = try await dataProvider.fetchApps(endPoint: MainEndPoint.books)
                self.tabListSection.append(.books)
                delegate?.handle(.reloadTableView)
            }catch {
                print(("Foo fetchBooks error: \(error.localizedDescription)"))
            }
        }
    }
    
    func fetchPodcasts() {
        Task {
            do {
                podcastsList = try await dataProvider.fetchApps(endPoint: MainEndPoint.podcast)
                self.tabListSection.append(.podcasts)
                delegate?.handle(.reloadTableView)
            }catch {
                print(("Foo fetchPodcasts error: \(error.localizedDescription)"))
            }
        }
    }
    
    func viewDidLoadTask() {
        Task {
            do {
                async let mostPlayedSongsResponse = try? await dataProvider.fetchMostPlayedSongs(endPoint: MainEndPoint.music)
                async let appsResponse = try? await dataProvider.fetchApps(endPoint: MainEndPoint.apps)
                async let booksResponse = try? await dataProvider.fetchBooks(endPoint: MainEndPoint.books)
                async let podCastsResponse = try? await dataProvider.fetchPodcast(endPoint: MainEndPoint.podcast)

                await updateUI(songs: mostPlayedSongsResponse, apps: appsResponse, books: booksResponse, podcasts: podCastsResponse)
            }
        }
    }
    
    func updateUI(songs: MostPlayedSongResponse?,
                  apps: MostPlayedSongResponse?,
                  books: MostPlayedSongResponse?,
                  podcasts: MostPlayedSongResponse?) {
        
        if let songs {
            self.songsList = songs
            self.tabListSection.append(.songs)
            delegate?.handle(.reloadTableView)
        }
        
        if let apps {
            self.tabListSection.append(.apps)
            self.appsList = apps
            delegate?.handle(.reloadTableView)
        }
        
        if let books {
            self.tabListSection.append(.books)
            self.booksList = books
            delegate?.handle(.reloadTableView)
        }
        
        if let podcasts {
            self.tabListSection.append(.podcasts)
            self.podcastsList = podcasts
            delegate?.handle(.reloadTableView)
        }
    }
}
