//
//  UserListModel.swift
//  Core
//
//  Created by Yovi Eka Putra on 26/06/21.
//

import Foundation

public struct UserListResponse: Decodable {
    public private(set) var items: [UserListModel]
    
    public init(items: [UserListModel] = []) {
        self.items = items
    }
}

public struct UserListModel: Decodable, Identifiable {
    private(set) public var id: Int?
    private(set) public var login: String
    private(set) public var avatar_url: String
    
    public init(id: Int?, login: String, avatar_url: String) {
        self.id = id
        self.login = login
        self.avatar_url = avatar_url
    }
}
