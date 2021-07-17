//
//  UserListModel.swift
//  Core
//
//  Created by Yovi Eka Putra on 26/06/21.
//

import Foundation

public struct UserListResponse: Decodable {
    public private(set) var items: [UserListModel]?
    public private(set) var incomplete_results: Bool?
    
    public init(
        items: [UserListModel]? = nil,
        incomplete_results: Bool? = nil
    ) {
        self.items = items
        self.incomplete_results = incomplete_results
    }
}

public struct UserListModel: Decodable, Identifiable {
    private(set) public var id: Int?
    private(set) public var login: String?
    private(set) public var avatar_url: String?
    
    public init(
        id: Int? = nil,
        login: String? = nil,
        avatar_url: String? = nil
    ) {
        self.id = id
        self.login = login
        self.avatar_url = avatar_url
    }
}
