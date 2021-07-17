//
//  UserServicesImpl.swift
//  Core
//
//  Created by Yovi Eka Putra on 16/07/21.
//

import Foundation
import Combine

public struct UserServicesImpl: UserServices {
    public init() {}
    
    public func get(
        _ keyword: String,
        page: Int,
        perPage: Int
    ) -> AnyPublisher<UserListResponse, Error> {
        guard var components = URLComponents(string: "https://api.github.com/search/users")
        else { fatalError("Couldn't create URLComponents") }
        
        components.queryItems = [
            URLQueryItem(name: "q", value: keyword),
            URLQueryItem(name: "page", value: String(page)),
            URLQueryItem(name: "per_page", value: String(perPage))
        ]
        
        return APIClient.shared
            .run(components.url!)
            .eraseToAnyPublisher()
    }
}
