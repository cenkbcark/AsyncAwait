//
//  ServiceManager.swift
//  AsyncAwait
//
//  Created by Cenk Bahadır Çark on 16.02.2024.
//

import Foundation

final class ServiceManager: Networkable {
    
    func fetchData<T>(endPoint: Endpointable) async throws -> T where T : Decodable {
        let components = URLComponents(string: endPoint.fullPath)
                
        guard let url = components?.url else { throw NSError(domain: "InvalidURL", code: 0) }
        
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
            throw NSError(domain: "Invalid Response", code: 1)
        }
        
        do {
            let decoder = JSONDecoder()
            return try decoder.decode(T.self, from: data)
        }catch {
            throw error
        }
    }
}
