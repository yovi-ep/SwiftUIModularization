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
