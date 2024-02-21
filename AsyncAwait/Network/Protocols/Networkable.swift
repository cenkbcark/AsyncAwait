//
//  Networkable.swift
//  AsyncAwait
//
//  Created by Cenk Bahadır Çark on 16.02.2024.
//

import Foundation

protocol Networkable {
    func fetchData<T: Decodable>(endPoint: Endpointable) async throws -> T
}
