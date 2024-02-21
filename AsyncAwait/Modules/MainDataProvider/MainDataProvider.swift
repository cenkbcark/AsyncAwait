//
//  MainDataProvider.swift
//  AsyncAwait
//
//  Created by Cenk Bahadır Çark on 16.02.2024.
//

import Foundation

final class MainDataProvider: MainDataProviderProtocol {
    private let serviceManager: Networkable
    
    init(serviceManager: Networkable) {
        self.serviceManager = serviceManager
    }
    
    func fetchMostPlayedSongs(endPoint: Endpointable) async throws -> MostPlayedSongResponse {
        return try await serviceManager.fetchData(endPoint: endPoint)
    }
    
    func fetchApps(endPoint: Endpointable) async throws -> MostPlayedSongResponse {
        return try await serviceManager.fetchData(endPoint: endPoint)
    }
    
    func fetchBooks(endPoint: Endpointable) async throws -> MostPlayedSongResponse {
        return try await serviceManager.fetchData(endPoint: endPoint)
    }
    
    func fetchPodcast(endPoint: Endpointable) async throws -> MostPlayedSongResponse {
        return try await serviceManager.fetchData(endPoint: endPoint)
    }
}
