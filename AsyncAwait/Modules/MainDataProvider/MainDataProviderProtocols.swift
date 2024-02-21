//
//  MainDataProviderProtocols.swift
//  AsyncAwait
//
//  Created by Cenk Bahadır Çark on 16.02.2024.
//

import Foundation

protocol MainDataProviderProtocol {
    func fetchMostPlayedSongs(endPoint: Endpointable) async throws -> MostPlayedSongResponse
    func fetchApps(endPoint: Endpointable) async throws -> MostPlayedSongResponse
    func fetchBooks(endPoint: Endpointable) async throws -> MostPlayedSongResponse
    func fetchPodcast(endPoint: Endpointable) async throws -> MostPlayedSongResponse
}
