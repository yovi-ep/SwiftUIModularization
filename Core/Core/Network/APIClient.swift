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
    
    struct Response<T> { // 1
        let value: T
        let response: URLResponse
    }
    
    func run<T: Decodable>(_ request: URLRequest) -> AnyPublisher<Response<T>, Error> { // 2
        let json = decoder
        print("Request \(request.url?.absoluteString ?? "")")
        return URLSession.shared
            .dataTaskPublisher(for: request) // 3
            .tryMap { result -> Response<T> in
                let value = try json.decode(T.self, from: result.data) // 4
                return Response(value: value, response: result.response) // 5
            }
            .print()
            .receive(on: DispatchQueue.main) // 6
            .subscribe(on: DispatchQueue.global(qos: .background))
            .eraseToAnyPublisher() // 7
    }
}
