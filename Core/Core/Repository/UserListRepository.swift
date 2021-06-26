//
//  UserListRepository.swift
//  Core
//
//  Created by Yovi Eka Putra on 26/06/21.
//

import Foundation
import Combine

public protocol UserListRepository {
    func get(path: String) -> AnyPublisher<UserListResponse, Error>
}

public struct UserListRepositoryImpl: UserListRepository {
    private let service: UserServices
    
    public init(service: UserServices) {
        self.service = service
    }
    
    public func get(path: String) -> AnyPublisher<UserListResponse, Error> {
        return self.service.get(path)
    }
}
