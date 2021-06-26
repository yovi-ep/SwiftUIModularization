//
//  UserService.swift
//  Core
//
//  Created by Yovi Eka Putra on 26/06/21.
//

import Foundation
import Combine

public protocol UserServices {
    func get(_ path: String) -> AnyPublisher<UserListResponse, Error>
}

public struct UserServicesImpl: UserServices {
    public init() {}
    
    public func get(_ path: String) -> AnyPublisher<UserListResponse, Error> {
        guard var components = URLComponents(string: "https://api.github.com/search/users")
        else { fatalError("Couldn't create URLComponents") }
        components.queryItems = [
            URLQueryItem(name: "q", value: "yovi"),
            URLQueryItem(name: "page", value: "1"),
            URLQueryItem(name: "per_page", value: "10")
        ]
        
        let request = URLRequest(url: components.url!)
        
        return APIClient.shared.run(request)
            .map(\.value)
            .eraseToAnyPublisher()
    }
}
