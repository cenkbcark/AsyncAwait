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
