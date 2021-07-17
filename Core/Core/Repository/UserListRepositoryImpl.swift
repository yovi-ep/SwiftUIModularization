//
//  UserListRepositoryImpl.swift
//  Core
//
//  Created by Yovi Eka Putra on 16/07/21.
//

import Foundation
import Combine

public struct UserListRepositoryImpl: UserListRepository {
    private let service: UserServices
    
    public init(service: UserServices) {
        self.service = service
    }
    
    public func get(
        keyword: String,
        page: Int,
        perPage: Int
    ) -> AnyPublisher<UserListResponse, Error> {
        return self.service.get(keyword, page: page, perPage: perPage)
    }
}
