//
//  MainEndPoint.swift
//  AsyncAwait
//
//  Created by Cenk Bahadır Çark on 16.02.2024.
//

import Foundation

enum MainEndPoint: Endpointable {
    case music
    case apps
    case books
    case podcast
    
    var baseUrl: String {
        return "https://rss.applemarketingtools.com/api/v2/us/"
    }
    
    var fullPath: String {
        return baseUrl + self.rawValue
    }
    
    var rawValue: String {
        switch self {
        case .music:
            return "music/most-played/50/albums.json"
        case .apps:
            return "apps/top-free/10/apps.json"
        case .books:
            return "books/top-free/10/books.json"
        case .podcast:
            return "podcasts/top/10/podcasts.json"
        }
    }
}
