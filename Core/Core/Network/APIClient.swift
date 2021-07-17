//
//  APIClient.swift
//  Core
//
//  Created by Yovi Eka Putra on 26/06/21.
//

import Foundation
import Combine

struct APIClient {
    static let shared: APIClient = APIClient()
    private let decoder = JSONDecoder()
    private init() {}
    
    func run<R: Decodable>(_ url: URL) -> AnyPublisher<R, Error> { // 2
        let json = decoder
        let request = URLRequest(url: url)
        
        print("Request \(request.url?.absoluteString ?? "")")
        return URLSession.shared
            .dataTaskPublisher(for: request) // 3
            .tryMap { try json.decode(R.self, from: $0.data) }
            .print()
            .receive(on: DispatchQueue.main) // 6
            .subscribe(on: DispatchQueue.global(qos: .background))
            .eraseToAnyPublisher() // 7
    }
}
