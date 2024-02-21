//
//  MainViewModelProtocol.swift
//  AsyncAwait
//
//  Created by Cenk Bahadır Çark on 16.02.2024.
//

import Foundation

protocol MainViewModelProtocol {
    var delegate: MainViewModelDelegate? { get set }
    var songsList: MostPlayedSongResponse? { get set }
    var appsList: MostPlayedSongResponse? { get set }
    var booksList: MostPlayedSongResponse? { get set }
    var podcastsList: MostPlayedSongResponse? { get set }
    var tabListSection: [TabListSection] { get set }
    
    func viewDidLoadTask()
    func updateUI(songs: MostPlayedSongResponse?, apps: MostPlayedSongResponse?, books: MostPlayedSongResponse?, podcasts: MostPlayedSongResponse?)
}

protocol MainViewModelDelegate: AnyObject {
    func handle(_ notify: MainViewNotify)
}

enum MainViewNotify {
    case didFetchSongs
    case didFetchApps
    case didFetchBooks
    case didFetchPodcasts
    case reloadTableView
}

enum TabListSection {
    case songs
    case apps
    case books
    case podcasts
}
